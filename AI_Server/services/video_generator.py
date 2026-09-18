import threading
from datetime import datetime
from functools import lru_cache
from pathlib import Path
from uuid import uuid4

from config import settings


class VideoGenerationError(RuntimeError):
    pass


# All values are divisible by 32 as the LTX VAE requires. Tier "1080p" is
# produced by a 2x spatial latent upsample of a base pass run at exactly half
# the target size, which is the multi-scale rendering path of LTX-Video.
_DIMENSIONS = {
    "720p": {"16:9": (1280, 704), "1:1": (704, 704), "9:16": (704, 1280)},
    "1080p": {"16:9": (1920, 1088), "1:1": (1088, 1088), "9:16": (1088, 1920)},
}


def _frame_count(duration_seconds: int) -> int:
    frames = duration_seconds * settings.VIDEO_FPS + 1
    if frames % 8 != 1:
        raise VideoGenerationError(
            f"Duration {duration_seconds}s does not map to the 8*n+1 frame "
            f"grid at {settings.VIDEO_FPS} fps"
        )
    return frames


class LTXVVideoGenerator:
    """Text-to-video on an 8 GB GPU with LTX-Video 2B distilled.

    Tier "720p" renders directly at the target size. Tier "1080p" renders a
    base pass at half size, then refines the latents with the official LTX
    spatial upsampler for a genuine 1920x1088 output (no fake ffmpeg resize).
    The distilled checkpoint needs only 8 sampling steps, which is what keeps
    generation times acceptable on this hardware.
    """

    def __init__(self):
        self._pipeline = None
        self._upsample_pipeline = None
        # True when the loaded LTXLatentUpsamplePipeline expects latents
        # (diffusers 0.33-0.40); False when it expects decoded frames
        # (diffusers >= 0.41, it re-encodes via the VAE itself).
        self._upsample_takes_latents = False
        self._lock = threading.Lock()

    # -- model loading ------------------------------------------------------

    @staticmethod
    def _resolve_model_path(configured: str) -> str:
        if Path(configured).is_dir():
            return configured
        # No local snapshot: fall back to the Hugging Face hub id. With
        # AI_LOCAL_FILES_ONLY=True this only resolves from the HF cache.
        return configured

    def _load_pipeline(self):
        if self._pipeline is not None:
            return self._pipeline
        try:
            import torch
            from diffusers import LTXPipeline

            model_path = self._resolve_model_path(settings.VIDEO_MODEL_DIR)
            pipeline = LTXPipeline.from_pretrained(
                model_path,
                torch_dtype=torch.float16,
                local_files_only=settings.AI_LOCAL_FILES_ONLY,
            )
            pipeline.set_progress_bar_config(disable=True)
            self._pipeline = pipeline
            return pipeline
        except Exception as error:
            print(f"LTX-Video load failed: {type(error).__name__}: {error}")
            raise VideoGenerationError(
                "LTX-Video model could not be loaded. Run "
                "scripts/download_video_models.py or check VIDEO_MODEL_DIR."
            ) from error

    @staticmethod
    def _load_upsampler_class():
        # The upsampler class moved between diffusers releases; probe the
        # known locations (newest first).
        try:
            from diffusers.pipelines.ltx.modeling_latent_upsampler import (
                LTXLatentUpsamplerModel,
            )

            return LTXLatentUpsamplerModel
        except ImportError:
            pass
        try:
            from diffusers import LTXLatentUpsampleModel

            return LTXLatentUpsampleModel
        except ImportError:
            pass
        from diffusers.models.transformers.ltx_transformer_3d import (
            LTXLatentUpsampleModel,
        )

        return LTXLatentUpsampleModel

    def _load_upsample_pipeline(self):
        if self._upsample_pipeline is not None:
            return self._upsample_pipeline
        try:
            import torch
            from diffusers import LTXLatentUpsamplePipeline

            base = self._load_pipeline()
            upsampler_cls = self._load_upsampler_class()
            configured = self._resolve_model_path(settings.VIDEO_UPSCALER_DIR)
            subfolder = None
            upsampler_dir = Path(configured)
            if upsampler_dir.is_dir():
                # diffusers-format repos keep the upsampler weights in a
                # latent_upsampler/ subdir; older layouts sit at the root.
                if (upsampler_dir / "latent_upsampler" / "config.json").is_file():
                    configured = str(upsampler_dir / "latent_upsampler")
            else:
                # Hugging Face repo id: the weights live in the subfolder.
                subfolder = "latent_upsampler"
            upsampler = upsampler_cls.from_pretrained(
                configured,
                torch_dtype=torch.float16,
                local_files_only=settings.AI_LOCAL_FILES_ONLY,
                **({"subfolder": subfolder} if subfolder else {}),
            )
            try:
                # diffusers >= 0.41: a pure upsampler + decoder, no transformer.
                # It takes decoded base-resolution frames, VAE-encodes them,
                # upsamples the latents and decodes at 2x.
                pipeline = LTXLatentUpsamplePipeline(
                    vae=base.vae,
                    latent_upsampler=upsampler,
                )
                self._upsample_takes_latents = False
            except TypeError:
                # diffusers 0.33–0.40: latents are refined by the transformer.
                pipeline = LTXLatentUpsamplePipeline(
                    vae=base.vae,
                    transformer=base.transformer,
                    upsampler=upsampler,
                    scheduler=base.scheduler,
                )
                self._upsample_takes_latents = True
            pipeline.set_progress_bar_config(disable=True)
            self._upsample_pipeline = pipeline
            return pipeline
        except Exception as error:
            print(f"LTX upsampler load failed: {type(error).__name__}: {error}")
            raise VideoGenerationError(
                "The LTX spatial upsampler could not be loaded. Run "
                "scripts/download_video_models.py or check VIDEO_UPSCALER_DIR."
            ) from error

    # -- GPU residency ------------------------------------------------------

    @staticmethod
    def _should_use_sequential_offload() -> bool:
        mode = settings.VIDEO_SEQUENTIAL_OFFLOAD.strip().lower()
        if mode == "true":
            return True
        if mode == "false":
            return False
        # auto: sequential whenever the card cannot hold the ~9.4 GB fp16
        # T5-XXL encoder plus working memory.
        try:
            import torch

            total = torch.cuda.get_device_properties(0).total_memory
            return total <= 12 * 1024**3
        except Exception:
            return True

    def _prepare_for_run(self, pipeline, sequential: bool | None = None):
        """Give a pipeline the GPU before a run.

        Hooks are removed first because the base and upsample pipelines share
        components; enabling offload twice would stack accelerate hooks on the
        same modules.
        """
        import torch

        device = settings.VIDEO_DEVICE
        if device == "auto":
            device = "cuda" if torch.cuda.is_available() else "cpu"
        try:
            pipeline.remove_all_hooks()
        except Exception:
            pass
        if device != "cuda":
            pipeline.to(device)
            return device
        if sequential is None:
            sequential = self._should_use_sequential_offload()
        if sequential:
            # Layer-by-layer streaming: VRAM peak stays ~1-2 GB regardless of
            # component size. The only cost is PCIe transfer per step, which
            # is negligible at 8 sampling steps.
            pipeline.enable_sequential_cpu_offload()
            if settings.VIDEO_VAE_TILING and hasattr(pipeline, "vae"):
                try:
                    pipeline.vae.enable_tiling()
                except (AttributeError, NotImplementedError):
                    pass
        elif settings.VIDEO_CPU_OFFLOAD:
            pipeline.enable_model_cpu_offload()
            if settings.VIDEO_VAE_TILING and hasattr(pipeline, "vae"):
                try:
                    pipeline.vae.enable_tiling()
                except (AttributeError, NotImplementedError):
                    pass
        else:
            pipeline.to(device)
        return device

    def release(self):
        try:
            import torch

            for pipeline in (self._pipeline, self._upsample_pipeline):
                if pipeline is None:
                    continue
                try:
                    pipeline.remove_all_hooks()
                except (AttributeError, RuntimeError):
                    pass
                try:
                    pipeline.to("cpu")
                except (AttributeError, RuntimeError):
                    pass
            if torch.cuda.is_available():
                torch.cuda.empty_cache()
        except Exception as error:
            print(f"VRAM release after video job failed: {error}")

    def _unload_base(self):
        """Drop the base pipeline so its weights leave system RAM.

        With sequential offload the T5 encoder (~9.4 GB) and transformer
        (~4 GB) permanently occupy RAM. The 1080p stage decodes 97 frames at
        1920x1088 and its postprocess needs several more GB, which does not
        fit alongside them on a 16 GB machine. The next base run simply
        reloads from disk (~30 s), and the upsample pipeline keeps a shared
        reference to the VAE so it survives this unload.
        """
        import gc

        self._pipeline = None
        gc.collect()

    # -- generation ---------------------------------------------------------

    def _run_base(self, prompt: str, width: int, height: int, frames: int, output_type: str):
        pipeline = self._load_pipeline()
        self._prepare_for_run(pipeline)
        # CFG=1: the distilled checkpoint was trained without classifier-free
        # guidance, so no negative prompt is passed.
        result = pipeline(
            prompt=prompt,
            width=width,
            height=height,
            num_frames=frames,
            num_inference_steps=settings.VIDEO_STEPS,
            guidance_scale=1.0,
            decode_timestep=0.05,
            decode_noise_scale=0.025,
            output_type=output_type,
        )
        return result.frames

    def _run_upsample(self, base_output, prompt: str, width: int, height: int, frames: int):
        """Upsample a base-resolution pass to the full target size.

        `base_output` holds latents (diffusers 0.33–0.40) or decoded PIL
        frames (diffusers >= 0.41); `width`/`height` are the FULL target.
        """
        pipeline = self._load_upsample_pipeline()
        # No T5 here — components are small, whole-model offload is faster.
        self._prepare_for_run(pipeline, sequential=False)
        if self._upsample_takes_latents:
            result = pipeline(
                prompt=prompt,
                video=base_output,
                width=width,
                height=height,
                num_frames=frames,
                num_inference_steps=settings.VIDEO_STEPS,
                guidance_scale=1.0,
                decode_timestep=0.05,
                decode_noise_scale=0.025,
                output_type="pil",
            )
        else:
            result = pipeline(
                video=base_output,
                width=width // 2,
                height=height // 2,
                decode_timestep=0.05,
                decode_noise_scale=0.025,
                output_type="pil",
            )
        return result.frames[0]

    def generate(
        self,
        prompt: str,
        aspect_ratio: str,
        quality: str,
        duration_seconds: int,
    ) -> tuple[Path, int, int]:
        target_width, target_height = _DIMENSIONS[quality][aspect_ratio]
        frames = _frame_count(duration_seconds)
        output_dir = Path(settings.GENERATED_VIDEO_DIR)
        output_dir.mkdir(parents=True, exist_ok=True)
        filename = f"reel_{datetime.utcnow():%Y%m%d_%H%M%S}_{uuid4().hex[:8]}.mp4"
        output_path = output_dir / filename

        with self._lock:
            try:
                if quality == "720p":
                    # [0] unwraps the batch: result.frames is List[List[PIL]].
                    frames_out = self._run_base(
                        prompt, target_width, target_height, frames, output_type="pil"
                    )[0]
                else:
                    # Force the upsample pipeline to load first so we know
                    # which input format the base pass must produce.
                    self._load_upsample_pipeline()
                    base_output = self._run_base(
                        prompt,
                        target_width // 2,
                        target_height // 2,
                        frames,
                        output_type="latent" if self._upsample_takes_latents else "pil",
                    )
                    if not self._upsample_takes_latents:
                        # Unwrap the batch: the >= 0.41 pipeline wants a flat
                        # list of PIL frames, not a batched list.
                        base_output = base_output[0]
                    # Free T5 + transformer RAM before the 1088p decode —
                    # see _unload_base for the memory math.
                    self._unload_base()
                    frames_out = self._run_upsample(
                        base_output, prompt, target_width, target_height, frames
                    )

                # H.264 via the imageio-ffmpeg backend: OpenCV's default
                # mp4v codec is not playable in browsers/many players, and
                # +faststart moves the moov atom up so clips stream over
                # HTTP instead of waiting for the full download.
                import imageio
                import numpy as np

                with imageio.get_writer(
                    str(output_path),
                    fps=settings.VIDEO_FPS,
                    codec="libx264",
                    quality=8,
                    macro_block_size=16,
                    ffmpeg_params=["-pix_fmt", "yuv420p", "-movflags", "+faststart"],
                ) as writer:
                    for frame in frames_out:
                        writer.append_data(np.asarray(frame))
                return output_path, target_width, target_height
            except VideoGenerationError:
                raise
            except Exception as error:
                print(f"Video generation failed: {type(error).__name__}: {error}")
                raise VideoGenerationError("Video generation failed") from error
            finally:
                self.release()


@lru_cache(maxsize=1)
def get_video_generator() -> LTXVVideoGenerator:
    return LTXVVideoGenerator()
