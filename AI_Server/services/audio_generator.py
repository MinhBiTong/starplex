import subprocess
import time
from pathlib import Path
from uuid import uuid4

from config import settings


class AudioGenerationError(RuntimeError):
    pass


def _mmaudio_available(interpreter: str) -> bool:
    return bool(interpreter) and Path(interpreter).is_file()


def _find_output(directory: Path, not_before: float, exclude: set[Path]) -> Path | None:
    candidates = [
        path
        for path in directory.rglob("*")
        if path.suffix.lower() == ".mp4"
        and path.is_file()
        and path.stat().st_mtime >= not_before
        and path.resolve() not in exclude
    ]
    if not candidates:
        return None
    return max(candidates, key=lambda path: path.stat().st_mtime)


def _run_mmaudio(video_path: Path, work_dir: Path, prompt: str | None) -> Path | None:
    """Run the MMAudio demo CLI once. Returns the muxed mp4 or None."""
    work_dir.mkdir(parents=True, exist_ok=True)
    command = [
        settings.MMAUDIO_PYTHON,
        "-m",
        "mmaudio.cli.demo",
        "--video",
        str(video_path),
        "--output",
        str(work_dir),
        "--model",
        settings.MMAUDIO_MODEL,
    ]
    if prompt:
        command += ["--prompt", prompt]
    started = time.time()
    try:
        completed = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=settings.MMAUDIO_TIMEOUT_SECONDS,
        )
    except (subprocess.TimeoutExpired, OSError) as error:
        print(f"MMAudio did not run: {type(error).__name__}: {error}")
        return None
    if completed.returncode != 0:
        print(f"MMAudio failed (code {completed.returncode}): {completed.stderr[-500:]}")
        return None
    return _find_output(work_dir, started, {video_path})


def enhance_with_audio(
    video_path: Path, prompt: str, duration_seconds: int
) -> tuple[Path, bool]:
    """Attach synchronized audio to a silent clip.

    MMAudio runs in an isolated venv as a subprocess because its dependency
    set (torchmcubes, specialized audio stack) is not compatible with the
    main server environment. On any failure the original silent clip is
    returned so the job still completes — audio is an enhancement, never a
    hard requirement.

    Returns (video_path, has_audio).
    """
    interpreter = settings.MMAUDIO_PYTHON
    if not _mmaudio_available(interpreter):
        print("MMAUDIO_PYTHON is not configured; shipping silent video")
        return video_path, False

    # The CLI derives the clip length from the video itself; duration_seconds
    # is only carried for logging.
    print(f"MMAudio enhancing {video_path.name} ({duration_seconds}s)", flush=True)
    with_prompt = _run_mmaudio(video_path, video_path.parent / f"_aud_{uuid4().hex[:8]}", prompt)
    if with_prompt is not None:
        return with_prompt, True
    # Some CLI versions reject --prompt; retry plain video-to-audio once.
    without_prompt = _run_mmaudio(
        video_path, video_path.parent / f"_aud_{uuid4().hex[:8]}", None
    )
    if without_prompt is not None:
        return without_prompt, True
    print("MMAudio unavailable; shipping silent video")
    return video_path, False
