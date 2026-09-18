from pydantic_settings import BaseSettings, SettingsConfigDict
from functools import lru_cache
from pathlib import Path
import secrets
import warnings

_SERVER_DIR = Path(__file__).resolve().parents[1]


class Settings(BaseSettings):
    PROJECT_NAME: str = "AI Server GENERATE IMAGES AND VIDEOS"
    SECRET_KEY: str = ""
    ENVIRONMENT: str = "development"  # "development" | "production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_DAYS: int = 15
    REDIS_URL: str = "redis://localhost:6379/0"
    DATABASE_URL: str = "mysql+aiomysql://root:@localhost:3306/project4"

    #EMAIL dung cho quen mat khau
    SMTP_HOST: str = "smtp.gmail.com"
    SMTP_PORT: int = 587
    SMTP_USER: str = ""
    SMTP_PASSWORD: str = ""
    EMAIL_FROM: str = ""
    FRONTEND_URL: str = "http://localhost:3000"
    CORS_ORIGINS: str = "*"
    STRIPE_SECRET_KEY: str = ""
    STRIPE_WEBHOOK_SECRET: str = ""
    STRIPE_SUCCESS_URL: str = ""
    STRIPE_CANCEL_URL: str = ""
    SDXL_BASE_MODEL: str = "stabilityai/stable-diffusion-xl-base-1.0"
    SDXL_LIGHTNING_UNET: str = str(
        _SERVER_DIR / "SDXL-Lightning" / "sdxl_lightning_4step_unet.safetensors"
    )
    TRANSLATION_MODEL_DIR: str = str(_SERVER_DIR / "translategemma-4b-it")
    TRANSLATION_DEVICE: str = "auto"
    # "auto" follows TranslateGemma's native bfloat16 weights on CUDA and
    # uses float32 on CPU. Set this to "float16" only after validating output
    # quality on a different GPU/model build.
    TRANSLATION_DTYPE: str = "auto"
    # The image endpoint uses the translator and SDXL sequentially. Keeping
    # TranslateGemma on the GPU would leave too little VRAM for SDXL.
    TRANSLATION_KEEP_LOADED: bool = False
    GENERATED_IMAGE_DIR: str = str(_SERVER_DIR / "generated_images")
    # Profile avatars. Uploads are re-encoded to JPEG <=512px before landing
    # here, so files stay small and the static mount below serves them.
    AVATAR_DIR: str = str(_SERVER_DIR / "avatars")
    IMAGE_DEVICE: str = "auto"
    # RTX 4060 Laptop GPUs commonly have 8GB VRAM. Model offload keeps the
    # pipeline stable on that hardware while still executing the UNet on CUDA.
    IMAGE_CPU_OFFLOAD: bool = True
    # Attention slicing reduces memory but is slower for a single image.
    IMAGE_ATTENTION_SLICING: bool = False
    IMAGE_VAE_SLICING: bool = False
    IMAGE_FUSE_QKV: bool = True
    IMAGE_CHANNELS_LAST: bool = True
    IMAGE_DISABLE_PROGRESS: bool = True
    AI_LOCAL_FILES_ONLY: bool = True

    # === Text-to-video (LTX-Video 0.9.8 2B distilled) ===
    # Local snapshot dirs prepared by scripts/download_video_models.py. When a
    # dir does not exist the value is treated as a Hugging Face repo id, so a
    # machine with internet can run without running the download script.
    VIDEO_MODEL_DIR: str = str(_SERVER_DIR / "models" / "ltxv-2b-distilled")
    VIDEO_UPSCALER_DIR: str = str(
        _SERVER_DIR / "models" / "ltxv-spatial-upscaler-0.9.8"
    )
    VIDEO_DEVICE: str = "auto"
    # Same 8 GB budget as the image pipeline: only the active component sits
    # on the GPU. The pipeline is pushed back to CPU RAM after every job so
    # the MMAudio subprocess (and image requests) can use the freed VRAM.
    VIDEO_CPU_OFFLOAD: bool = True
    # "auto" (default) switches to layer-by-layer sequential offload on small
    # GPUs: the T5-XXL text encoder alone is ~9.4 GB in fp16 and cannot fit
    # an 8 GB card whole, while whole-component offload only survives via
    # unreliable Windows system-memory fallback. "false" forces whole-model
    # offload, "true" forces sequential.
    VIDEO_SEQUENTIAL_OFFLOAD: str = "auto"
    # Tiled VAE decoding keeps the 1088-high decode of tier "1080p" inside 8GB.
    VIDEO_VAE_TILING: bool = True
    VIDEO_STEPS: int = 8
    # 24 fps keeps 4/6/8 s on the 8*n+1 frame grid the LTX sampler requires
    # (97 / 145 / 193 frames). 30 fps would break the 6 s tier.
    VIDEO_FPS: int = 24
    GENERATED_VIDEO_DIR: str = str(_SERVER_DIR / "generated_videos")
    # Optional MMAudio (video-to-audio) running in its own venv, see
    # docs/VIDEO_SETUP.md. Empty string disables audio: clips ship silent.
    MMAUDIO_PYTHON: str = ""
    # small | medium | large — smaller models fit the 8 GB card more easily.
    MMAUDIO_MODEL: str = "small"
    MMAUDIO_TIMEOUT_SECONDS: int = 900

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


@lru_cache
def get_settings() -> Settings:
    loaded = Settings()
    if not loaded.SECRET_KEY:
        if loaded.ENVIRONMENT == "production":
            raise RuntimeError(
                "SECRET_KEY must be set in production. JWT tokens cannot be "
                "signed with an ephemeral key. Generate one with: "
                "python -c 'import secrets; print(secrets.token_urlsafe(32))'"
            )
        # Dev only — keep server running but warn loudly.
        warnings.warn(
            "SECRET_KEY is not configured; using a temporary development key. "
            "All JWT tokens will be invalidated on every restart.",
            RuntimeWarning,
            stacklevel=2,
        )
        loaded.SECRET_KEY = secrets.token_urlsafe(32)
    return loaded


settings = get_settings()
