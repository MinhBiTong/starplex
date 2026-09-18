import asyncio
import shutil
from pathlib import Path
from uuid import uuid4

from fastapi import APIRouter, Depends, HTTPException, Request, status
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from schema.generation import (
    GenerationHistoryItem,
    GenerationUsage,
    ImageGenerationRequest,
    ImageGenerationResponse,
    VideoGenerationRequest,
    VideoGenerationResponse,
    VideoGenerationStatusResponse,
)
from services.audio_generator import enhance_with_audio
from services.gpu_lock import gpu_lock
from services.image_generator import ImageGenerationError, get_image_generator
from services.translation import (
    PromptTranslationError,
    release_translator,
    translate_prompt_to_english,
)
from services.video_generator import get_video_generator
from config import settings
from controller.v1.dependencies import get_current_user
from db.session import AsyncSessionLocal, get_db
from schema.users import User
from config.rate_limit import limiter


router = APIRouter(prefix="/generate", tags=["Generation"])

# In-process bookkeeping so completed background tasks can be garbage
# collected while the server keeps running.
_video_tasks: set[asyncio.Task] = set()

# Base cost comes from the admin setting 'video_credit_cost' and is scaled by
# the requested duration and quality tier. 720p/4s = base, 1080p/8s = 4x base.
_VIDEO_DURATION_FACTORS = {4: 1.0, 6: 1.5, 8: 2.0}
_VIDEO_QUALITY_FACTORS = {"720p": 1.0, "1080p": 2.0}


def _video_credit_cost(base: int, duration_seconds: int, quality: str) -> int:
    factor = _VIDEO_DURATION_FACTORS.get(duration_seconds, 1.0) * _VIDEO_QUALITY_FACTORS.get(
        quality, 1.0
    )
    return max(1, round(base * factor))


@router.get("/history", response_model=list[GenerationHistoryItem])
async def generation_history(
    limit: int = 50,
    offset: int = 0,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    limit = min(max(limit, 1), 100)
    offset = max(offset, 0)
    result = await db.execute(
        text(
            """
            SELECT g.id, g.type, g.prompt, g.aspect_ratio, g.status,
                   g.credit_cost, g.error_message, g.created_at, g.completed_at,
                   (
                       SELECT f.file_url
                       FROM GenerationFiles f
                       WHERE f.generation_id = g.id
                       ORDER BY f.id DESC
                       LIMIT 1
                   ) AS file_url
            FROM Generations g
            WHERE g.user_id = :user_id
            ORDER BY g.created_at DESC, g.id DESC
            LIMIT :limit OFFSET :offset
            """
        ),
        {"user_id": user.id, "limit": limit, "offset": offset},
    )
    return [GenerationHistoryItem(**dict(row)) for row in result.mappings()]


@router.get("/usage", response_model=GenerationUsage)
async def generation_usage(
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    balance_result = await db.execute(
        text("SELECT balance FROM CreditWallets WHERE user_id = :user_id"),
        {"user_id": user.id},
    )
    return GenerationUsage(
        credit_balance=int(balance_result.scalar_one_or_none() or 0),
    )


def _translate_and_generate(data: ImageGenerationRequest):
    # The two large models cannot fit in the 8 GB GPU at the same time. Keep
    # this critical section around both stages so concurrent requests cannot
    # evict a translator while another request is still using it. The same
    # lock also serializes against video jobs (see /generate/video).
    with gpu_lock:
        try:
            translated_prompt = translate_prompt_to_english(data.prompt)
        finally:
            release_translator()
        output_path, width, height = get_image_generator().generate(
            translated_prompt,
            data.aspect_ratio,
            data.style,
        )
        return translated_prompt, output_path, width, height


@router.post("/image", response_model=ImageGenerationResponse)
@limiter.limit("10/minute")  # Rate limit: 10 image generations per minute per user
async def generate_image(
    data: ImageGenerationRequest,
    request: Request,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    if data.type != "image":
        raise HTTPException(status_code=400, detail="Only text-to-image is supported")

    cost = 3
    setting = await db.execute(text("SELECT setting_value FROM SystemSettings WHERE setting_key = 'image_credit_cost'"))
    setting_value = setting.scalar_one_or_none()
    if setting_value is not None:
        try:
            cost = max(0, int(setting_value))
        except (TypeError, ValueError):
            pass

    wallet_result = await db.execute(
        text("SELECT id, balance FROM CreditWallets WHERE user_id = :user_id FOR UPDATE"),
        {"user_id": user.id},
    )
    wallet = wallet_result.mappings().first()
    if not wallet:
        raise HTTPException(status_code=409, detail="Credit wallet not found")
    if wallet["balance"] < cost:
        raise HTTPException(status_code=402, detail="Not enough credits")

    before = int(wallet["balance"])
    after = before - cost
    await db.execute(
        text("UPDATE CreditWallets SET balance = :balance, updated_at = NOW() WHERE id = :id"),
        {"balance": after, "id": wallet["id"]},
    )
    await db.execute(
        text(
            """
            INSERT INTO Generations
                (user_id, type, prompt, aspect_ratio, status, credit_cost, created_at)
            VALUES (:user_id, 'image', :prompt, :aspect_ratio, 'processing', :credit_cost, NOW())
            """
        ),
        {"user_id": user.id, "prompt": data.prompt, "aspect_ratio": data.aspect_ratio, "credit_cost": cost},
    )
    generation_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())
    await db.execute(
        text(
            """
            INSERT INTO CreditTransactions
                (user_id, wallet_id, type, amount, balance_before, balance_after,
                 reference_type, reference_id, description, created_at)
            VALUES (:user_id, :wallet_id, 'generation', :amount, :before, :after,
                    'generation', :reference_id, :description, NOW())
            """
        ),
        {"user_id": user.id, "wallet_id": wallet["id"], "amount": -cost, "before": before, "after": after, "reference_id": generation_id, "description": "Image generation"},
    )
    await db.commit()

    print(f"[PROMPT] {data.prompt}", flush=True)
    try:
        translated_prompt, output_path, width, height = await asyncio.to_thread(
            _translate_and_generate,
            data,
        )
        print(f"[TRANSLATED_PROMPT] {translated_prompt}", flush=True)
    except PromptTranslationError as error:
        await _fail_generation(db, generation_id, user.id, wallet["id"], cost, "Translation failed")
        raise HTTPException(status_code=503, detail=str(error)) from error
    except ImageGenerationError as error:
        await _fail_generation(db, generation_id, user.id, wallet["id"], cost, "Image generation failed")
        raise HTTPException(status_code=503, detail=str(error)) from error

    base_url = str(request.base_url).rstrip("/")
    await db.execute(
        text("UPDATE Generations SET status = 'completed', completed_at = NOW() WHERE id = :id"),
        {"id": generation_id},
    )
    await db.execute(
        text("INSERT INTO GenerationFiles (generation_id, file_type, file_url, file_size, created_at) VALUES (:generation_id, 'image', :file_url, :file_size, NOW())"),
        {"generation_id": generation_id, "file_url": f"{base_url}/generated/{output_path.name}", "file_size": output_path.stat().st_size if output_path.exists() else None},
    )
    await db.commit()
    return ImageGenerationResponse(
        generation_id=generation_id,
        status="completed",
        credit_cost=cost,
        image_url=f"{base_url}/generated/{output_path.name}",
        prompt=data.prompt,
        translated_prompt=translated_prompt,
        aspect_ratio=data.aspect_ratio,
        width=width,
        height=height,
    )


async def _fail_generation(
    db: AsyncSession,
    generation_id: int,
    user_id: int,
    wallet_id: int,
    cost: int,
    message: str,
) -> None:
    await db.rollback()
    wallet_result = await db.execute(text("SELECT balance FROM CreditWallets WHERE id = :id FOR UPDATE"), {"id": wallet_id})
    wallet = wallet_result.mappings().one()
    before = int(wallet["balance"])
    after = before + cost
    await db.execute(text("UPDATE CreditWallets SET balance = :balance, updated_at = NOW() WHERE id = :id"), {"balance": after, "id": wallet_id})
    await db.execute(text("UPDATE Generations SET status = 'failed', error_message = :message WHERE id = :id"), {"id": generation_id, "message": message})
    await db.execute(text("INSERT INTO CreditTransactions (user_id, wallet_id, type, amount, balance_before, balance_after, reference_type, reference_id, description, created_at) VALUES (:user_id, :wallet_id, 'refund', :amount, :before, :after, 'generation', :reference_id, :description, NOW())"), {"user_id": user_id, "wallet_id": wallet_id, "amount": cost, "before": before, "after": after, "reference_id": generation_id, "description": "Generation failed; credit refunded"})
    await db.commit()


@router.post("/video", response_model=VideoGenerationResponse, status_code=status.HTTP_202_ACCEPTED)
@limiter.limit("2/minute")  # Video takes minutes of GPU time; cap job spam.
async def generate_video(
    data: VideoGenerationRequest,
    request: Request,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    base_setting = await db.execute(
        text("SELECT setting_value FROM SystemSettings WHERE setting_key = 'video_credit_cost'")
    )
    base_cost = 12
    setting_value = base_setting.scalar_one_or_none()
    if setting_value is not None:
        try:
            base_cost = max(1, int(setting_value))
        except (TypeError, ValueError):
            pass
    cost = _video_credit_cost(base_cost, data.duration_seconds, data.quality)

    wallet_result = await db.execute(
        text("SELECT id, balance FROM CreditWallets WHERE user_id = :user_id FOR UPDATE"),
        {"user_id": user.id},
    )
    wallet = wallet_result.mappings().first()
    if not wallet:
        raise HTTPException(status_code=409, detail="Credit wallet not found")
    if wallet["balance"] < cost:
        raise HTTPException(status_code=402, detail="Not enough credits")

    before = int(wallet["balance"])
    after = before - cost
    await db.execute(
        text("UPDATE CreditWallets SET balance = :balance, updated_at = NOW() WHERE id = :id"),
        {"balance": after, "id": wallet["id"]},
    )
    await db.execute(
        text(
            """
            INSERT INTO Generations
                (user_id, type, prompt, aspect_ratio, duration_seconds,
                 resolution, status, credit_cost, created_at)
            VALUES (:user_id, 'video', :prompt, :aspect_ratio, :duration_seconds,
                    :resolution, 'processing', :credit_cost, NOW())
            """
        ),
        {
            "user_id": user.id,
            "prompt": data.prompt,
            "aspect_ratio": data.aspect_ratio,
            "duration_seconds": data.duration_seconds,
            "resolution": data.quality,
            "credit_cost": cost,
        },
    )
    generation_id = int((await db.execute(text("SELECT LAST_INSERT_ID()"))).scalar_one())
    await db.execute(
        text(
            """
            INSERT INTO CreditTransactions
                (user_id, wallet_id, type, amount, balance_before, balance_after,
                 reference_type, reference_id, description, created_at)
            VALUES (:user_id, :wallet_id, 'generation', :amount, :before, :after,
                    'generation', :reference_id, :description, NOW())
            """
        ),
        {
            "user_id": user.id,
            "wallet_id": wallet["id"],
            "amount": -cost,
            "before": before,
            "after": after,
            "reference_id": generation_id,
            "description": f"Video generation {data.quality} {data.duration_seconds}s",
        },
    )
    await db.commit()

    # The heavy work continues in the background; the client polls the
    # status endpoint until the row turns 'completed' or 'failed'.
    task = asyncio.create_task(
        _run_video_job(
            generation_id=generation_id,
            user_id=user.id,
            wallet_id=wallet["id"],
            cost=cost,
            prompt=data.prompt,
            aspect_ratio=data.aspect_ratio,
            quality=data.quality,
            duration_seconds=data.duration_seconds,
            base_url=str(request.base_url).rstrip("/"),
        )
    )
    _video_tasks.add(task)
    task.add_done_callback(_video_tasks.discard)

    return VideoGenerationResponse(
        generation_id=generation_id,
        status="processing",
        credit_cost=cost,
        prompt=data.prompt,
        aspect_ratio=data.aspect_ratio,
        duration_seconds=data.duration_seconds,
        quality=data.quality,
    )


@router.get("/video/{generation_id}", response_model=VideoGenerationStatusResponse)
async def video_status(
    generation_id: int,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    result = await db.execute(
        text(
            """
            SELECT g.status, g.credit_cost, g.error_message, g.aspect_ratio,
                   g.duration_seconds, g.resolution, g.created_at, g.completed_at,
                   (
                       SELECT f.file_url
                       FROM GenerationFiles f
                       WHERE f.generation_id = g.id AND f.file_type = 'video'
                       ORDER BY f.id DESC
                       LIMIT 1
                   ) AS file_url
            FROM Generations g
            WHERE g.id = :generation_id AND g.user_id = :user_id AND g.type = 'video'
            """
        ),
        {"generation_id": generation_id, "user_id": user.id},
    )
    row = result.mappings().first()
    if not row:
        raise HTTPException(status_code=404, detail="Video generation not found")
    return VideoGenerationStatusResponse(
        generation_id=generation_id,
        status=row["status"],
        credit_cost=row["credit_cost"],
        video_url=row["file_url"],
        error_message=row["error_message"],
        aspect_ratio=row["aspect_ratio"],
        duration_seconds=row["duration_seconds"],
        resolution=row["resolution"],
        created_at=row["created_at"],
        completed_at=row["completed_at"],
    )


def _video_job_work(
    prompt: str, aspect_ratio: str, quality: str, duration_seconds: int
):
    """GPU-bound part of a video job; runs in a worker thread.

    Holds the shared GPU lock for the whole render (video model, then the
    MMAudio subprocess) so no image request can touch the 8 GB card in
    between.
    """
    with gpu_lock:
        try:
            translated_prompt = translate_prompt_to_english(prompt)
        finally:
            release_translator()
        silent_path, width, height = get_video_generator().generate(
            translated_prompt, aspect_ratio, quality, duration_seconds
        )
        final_path, has_audio = enhance_with_audio(
            silent_path, translated_prompt, duration_seconds
        )
        return translated_prompt, final_path, width, height, has_audio


def _finalize_video_path(path: Path) -> Path:
    """Move MMAudio output from its temp work dir into the static video dir."""
    video_dir = Path(settings.GENERATED_VIDEO_DIR)
    video_dir.mkdir(parents=True, exist_ok=True)
    if path.parent.resolve() == video_dir.resolve():
        return path
    target = video_dir / f"reel_{uuid4().hex[:12]}.mp4"
    shutil.move(str(path), str(target))
    work_dir = path.parent
    shutil.rmtree(work_dir, ignore_errors=True)
    return target


async def _run_video_job(
    generation_id: int,
    user_id: int,
    wallet_id: int,
    cost: int,
    prompt: str,
    aspect_ratio: str,
    quality: str,
    duration_seconds: int,
    base_url: str,
) -> None:
    async with AsyncSessionLocal() as db:
        try:
            (
                translated_prompt,
                raw_path,
                width,
                height,
                has_audio,
            ) = await asyncio.to_thread(
                _video_job_work, prompt, aspect_ratio, quality, duration_seconds
            )
            final_path = _finalize_video_path(raw_path)
            resolution_label = f"{width}x{height}"
            print(
                f"[VIDEO] #{generation_id} done: {resolution_label}, "
                f"audio={'yes' if has_audio else 'no'}",
                flush=True,
            )
            await db.execute(
                text(
                    "UPDATE Generations SET status = 'completed', completed_at = NOW(), "
                    "resolution = :resolution WHERE id = :id"
                ),
                {"resolution": resolution_label, "id": generation_id},
            )
            await db.execute(
                text(
                    "INSERT INTO GenerationFiles (generation_id, file_type, file_url, "
                    "file_size, created_at) VALUES (:generation_id, 'video', :file_url, "
                    ":file_size, NOW())"
                ),
                {
                    "generation_id": generation_id,
                    "file_url": f"{base_url}/videos/{final_path.name}",
                    "file_size": final_path.stat().st_size if final_path.exists() else None,
                },
            )
            await db.commit()
        except PromptTranslationError as error:
            await _fail_generation(db, generation_id, user_id, wallet_id, cost, "Translation failed")
            print(f"[VIDEO] #{generation_id} translation failed: {error}", flush=True)
        except Exception as error:
            await _fail_generation(db, generation_id, user_id, wallet_id, cost, "Video generation failed")
            print(f"[VIDEO] #{generation_id} failed: {type(error).__name__}: {error}", flush=True)


async def reconcile_stale_video_jobs() -> None:
    """Fail video jobs left 'processing' by a previous server run.

    Video jobs live inside the server process, so a row that is still
    'processing' at startup can only come from a crash or restart — refund
    the credits and mark it failed.
    """
    async with AsyncSessionLocal() as db:
        rows = (
            await db.execute(
                text(
                    "SELECT id, user_id, credit_cost FROM Generations "
                    "WHERE type = 'video' AND status IN ('pending', 'processing')"
                )
            )
        ).mappings().all()
        for row in rows:
            wallet = (
                await db.execute(
                    text("SELECT id FROM CreditWallets WHERE user_id = :user_id"),
                    {"user_id": row["user_id"]},
                )
            ).scalar_one_or_none()
            if wallet is None:
                await db.execute(
                    text(
                        "UPDATE Generations SET status = 'failed', "
                        "error_message = 'Server restarted during generation' WHERE id = :id"
                    ),
                    {"id": row["id"]},
                )
                await db.commit()
                continue
            await _fail_generation(
                db,
                row["id"],
                row["user_id"],
                int(wallet),
                int(row["credit_cost"]),
                "Server restarted during generation",
            )
            print(f"[VIDEO] #{row['id']} stale job failed and refunded", flush=True)


@router.delete("/{generation_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_generation(
    generation_id: int,
    db: AsyncSession = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Delete a generation (soft delete by marking status as failed)"""
    # Check if generation exists and belongs to user
    result = await db.execute(
        text(
            "SELECT id, user_id, status FROM Generations "
            "WHERE id = :generation_id"
        ),
        {"generation_id": generation_id},
    )
    generation = result.mappings().first()
    
    if not generation:
        raise HTTPException(status_code=404, detail="Generation not found")
    
    if generation["user_id"] != user.id:
        raise HTTPException(
            status_code=403,
            detail="You don't have permission to delete this generation"
        )
    
    # Don't allow deleting processing generations
    if generation["status"] == "processing":
        raise HTTPException(
            status_code=409,
            detail="Cannot delete generation that is currently processing"
        )
    
    # Soft delete: Mark as failed with deleted message
    await db.execute(
        text(
            "UPDATE Generations SET status = 'failed', "
            "error_message = 'Deleted by user' WHERE id = :generation_id"
        ),
        {"generation_id": generation_id},
    )
    
    await db.commit()
    return None  # 204 No Content
