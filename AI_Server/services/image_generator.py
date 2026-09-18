import threading
import os
import shutil
from datetime import datetime
from functools import lru_cache
from pathlib import Path
from types import MethodType
from uuid import uuid4

from config import settings


class ImageGenerationError(RuntimeError):
    pass


_STYLE_SUFFIXES = {
    "Cinematic": "cinematic composition, dramatic lighting, film still, high detail",
    "Documentary": "documentary photography, natural light, authentic detail",
    "Studio": "studio photography, controlled lighting, polished composition",
    "Animated": "stylized animation, expressive shapes, highly detailed illustration",
}


def _dimensions(aspect_ratio: str) -> tuple[int, int]:
    return {
        "16:9": (1024, 576),
        "1:1": (768, 768),
        "9:16": (576, 1024),
    }[aspect_ratio]


class SDXLLightningGenerator:
    def __init__(self):
        self._pipeline = None
        self._lock = threading.Lock()

    def _load_pipeline(self):
        if self._pipeline is not None:
            return self._pipeline

        try:
            import torch
            from diffusers import (
                EulerDiscreteScheduler,
                StableDiffusionXLPipeline,
                UNet2DConditionModel,
            )
            base_model = self._resolve_base_model()
            if not Path(base_model).is_dir():
                # Resolve an already cached Hugging Face snapshot.  The
                # Lightning checkpoint supplies the UNet weights, so the
                # base snapshot only needs its config/encoders/VAE files.
                from huggingface_hub import snapshot_download

                base_model = snapshot_download(
                    base_model,
                    local_files_only=settings.AI_LOCAL_FILES_ONLY,
                )

            device = settings.IMAGE_DEVICE
            if device == "auto":
                device = "cuda" if torch.cuda.is_available() else "cpu"
            dtype = torch.float16 if device == "cuda" else torch.float32
            if device == "cuda":
                # Safe speed-up on Ampere/Ada GPUs for float32 helper ops.
                torch.backends.cuda.matmul.allow_tf32 = True
                torch.backends.cudnn.allow_tf32 = True
                torch.set_float32_matmul_precision("high")

            lightning_unet_dir = self._prepare_lightning_unet_dir(base_model)
            unet_load_kwargs = {
                "dtype": dtype,
            }
            try:
                # Accelerate's low-memory loader prevents a second full copy
                # of the 5GB Lightning checkpoint in system RAM.
                unet_load_kwargs["low_cpu_mem_usage"] = True
                unet = UNet2DConditionModel.from_pretrained(
                    str(lightning_unet_dir),
                    **unet_load_kwargs,
                )
            except TypeError:
                unet_load_kwargs.pop("low_cpu_mem_usage", None)
                unet = UNet2DConditionModel.from_pretrained(
                    str(lightning_unet_dir),
                    **unet_load_kwargs,
                )

            load_kwargs = {
                "unet": unet,
                "dtype": dtype,
                # The snapshot was resolved locally above. Avoid a network
                # check on every cold start and make offline startup reliable.
                "local_files_only": settings.AI_LOCAL_FILES_ONLY,
            }
            if device == "cuda":
                load_kwargs["variant"] = "fp16"
            pipeline = StableDiffusionXLPipeline.from_pretrained(
                base_model,
                **load_kwargs,
            )
            if hasattr(pipeline, "vae"):
                # The current diffusers/Accelerate combination passes a dtype
                # through the VAE offload hook and logs a warning even though
                # its protected-module list is empty. Keep the exact PyTorch
                # move/cast behavior while bypassing only that noisy wrapper.
                def _vae_to_without_dtype_warning(vae, *args, **kwargs):
                    return torch.nn.Module.to(vae, *args, **kwargs)

                pipeline.vae.to = MethodType(
                    _vae_to_without_dtype_warning,
                    pipeline.vae,
                )
            pipeline.scheduler = EulerDiscreteScheduler.from_config(
                pipeline.scheduler.config,
                timestep_spacing="trailing",
            )

            # These options reduce per-step attention overhead without the
            # latency penalty of attention slicing. They are especially useful
            # for SDXL-Lightning, which already needs only four steps.
            if device == "cuda" and settings.IMAGE_FUSE_QKV:
                try:
                    pipeline.fuse_qkv_projections()
                except (AttributeError, NotImplementedError, RuntimeError) as error:
                    print(f"SDXL QKV fusion unavailable: {error}")
            if device == "cuda" and settings.IMAGE_CHANNELS_LAST:
                pipeline.unet.to(memory_format=torch.channels_last)

            if device == "cuda" and settings.IMAGE_CPU_OFFLOAD:
                # Keep only the active pipeline component on the GPU. This is
                # safer than filling all 8GB of VRAM with SDXL components.
                pipeline.enable_model_cpu_offload()
            else:
                pipeline = pipeline.to(device)
            if hasattr(pipeline, "vae") and hasattr(pipeline, "upcast_vae"):
                # Avoid the deprecated diffusers helper while preserving the
                # required fp32 VAE upcast before decoding.
                def _safe_upcast_vae():
                    torch.nn.Module.to(pipeline.vae, dtype=torch.float32)

                pipeline.upcast_vae = _safe_upcast_vae
            if settings.IMAGE_ATTENTION_SLICING and hasattr(
                pipeline, "enable_attention_slicing"
            ):
                pipeline.enable_attention_slicing()
            if settings.IMAGE_VAE_SLICING:
                if hasattr(pipeline, "enable_vae_slicing"):
                    pipeline.enable_vae_slicing()
                elif hasattr(pipeline, "vae") and hasattr(pipeline.vae, "enable_slicing"):
                    pipeline.vae.enable_slicing()
            if settings.IMAGE_DISABLE_PROGRESS:
                pipeline.set_progress_bar_config(disable=True)
            self._pipeline = pipeline
            memory_mode = "CPU offload" if device == "cuda" and settings.IMAGE_CPU_OFFLOAD else "GPU resident"
            print(f"SDXL-Lightning image model loaded on {device} ({memory_mode})")
            return pipeline
        except Exception as error:
            print(f"SDXL-Lightning load failed: {type(error).__name__}: {error}")
            raise ImageGenerationError(
                "SDXL-Lightning model could not be loaded. "
                "Check the base SDXL model cache and model path."
            ) from error

    @staticmethod
    def _resolve_base_model() -> str:
        configured = settings.SDXL_BASE_MODEL
        if Path(configured).is_dir():
            return configured

        # Hugging Face marks a snapshot incomplete when optional repository
        # files are absent.  Diffusers only needs the model files below, and
        # these are already present in the local snapshot on this machine.
        hf_home = Path(os.environ.get("HF_HOME", Path.home() / ".cache" / "huggingface"))
        model_cache = hf_home / "hub" / f"models--{configured.replace('/', '--')}" / "snapshots"
        snapshots = [p for p in model_cache.glob("*") if (p / "model_index.json").is_file()]
        if snapshots:
            return str(max(snapshots, key=lambda p: p.stat().st_mtime))
        return configured

    @staticmethod
    def _prepare_lightning_unet_dir(base_model: str) -> Path:
        source = Path(settings.SDXL_LIGHTNING_UNET).resolve()
        if not source.is_file():
            raise FileNotFoundError(f"Lightning UNet file not found: {source}")

        target_dir = source.parent / "diffusers_unet"
        target_dir.mkdir(parents=True, exist_ok=True)

        source_config = Path(base_model) / "unet" / "config.json"
        target_config = target_dir / "config.json"
        if not target_config.exists():
            shutil.copyfile(source_config, target_config)

        target_weights = target_dir / "diffusion_pytorch_model.safetensors"
        if not target_weights.exists():
            try:
                os.link(source, target_weights)
            except OSError:
                # Hard links can be unavailable on some Windows volumes. A
                # normal copy remains a valid fallback, but is only used when
                # the filesystem cannot create a link.
                shutil.copyfile(source, target_weights)
        return target_dir

    def generate(self, prompt: str, aspect_ratio: str, style: str) -> tuple[Path, int, int]:
        width, height = _dimensions(aspect_ratio)
        styled_prompt = f"{prompt}, {_STYLE_SUFFIXES[style]}"
        output_dir = Path(settings.GENERATED_IMAGE_DIR)
        output_dir.mkdir(parents=True, exist_ok=True)

        with self._lock:
            try:
                pipeline = self._load_pipeline()
                import torch

                with torch.inference_mode():
                    result = pipeline(
                        prompt=styled_prompt,
                        num_inference_steps=4,
                        guidance_scale=0.0,
                        width=width,
                        height=height,
                        num_images_per_prompt=1,
                    )
                image = result.images[0]
                filename = f"reel_{datetime.utcnow():%Y%m%d_%H%M%S}_{uuid4().hex[:8]}.png"
                output_path = output_dir / filename
                image.save(output_path, format="PNG")
                return output_path, width, height
            except ImageGenerationError:
                raise
            except Exception as error:
                raise ImageGenerationError("Image generation failed") from error


@lru_cache(maxsize=1)
def get_image_generator() -> SDXLLightningGenerator:
    return SDXLLightningGenerator()
