from pathlib import Path

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.exceptions import RequestValidationError
from fastapi.staticfiles import StaticFiles
from fastapi.responses import JSONResponse
from sqlalchemy import text
from slowapi import _rate_limit_exceeded_handler
from slowapi.errors import RateLimitExceeded

from config import settings
from config.rate_limit import limiter
from db.session import engine
from config.exception import AppException
from config.exception_handlers import (
    app_exception_handler,
    generic_exception_handler,
    validation_exception_handler,
)
from controller.v1.endpoints import admin_dashboard, auth, credits, generation, payment_packages, payments, settings as settings_api, users


app = FastAPI(title=settings.PROJECT_NAME)

# Add rate limiter state and exception handler
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

generated_image_dir = Path(settings.GENERATED_IMAGE_DIR)
generated_image_dir.mkdir(parents=True, exist_ok=True)
app.mount(
    "/generated",
    StaticFiles(directory=generated_image_dir),
    name="generated-images",
)

avatar_dir = Path(settings.AVATAR_DIR)
avatar_dir.mkdir(parents=True, exist_ok=True)
app.mount(
    "/avatars",
    StaticFiles(directory=avatar_dir),
    name="avatars",
)

generated_video_dir = Path(settings.GENERATED_VIDEO_DIR)
generated_video_dir.mkdir(parents=True, exist_ok=True)
app.mount(
    "/videos",
    StaticFiles(directory=generated_video_dir),
    name="generated-videos",
)

_cors_origins = [origin.strip() for origin in settings.CORS_ORIGINS.split(",") if origin.strip()]
_allow_all_origins = "*" in _cors_origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=_cors_origins,
    allow_credentials=not _allow_all_origins,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Middleware to inject user into request state for rate limiting
@app.middleware("http")
async def inject_user_for_rate_limit(request: Request, call_next):
    """Extract user from Authorization header and add to request.state"""
    from config.security import decode_token
    
    auth_header = request.headers.get("Authorization")
    if auth_header and auth_header.startswith("Bearer "):
        token = auth_header.split(" ")[1]
        payload = decode_token(token)
        if payload and payload.get("type") == "access":
            # Create a simple object with id attribute
            class UserIdentifier:
                def __init__(self, user_id):
                    self.id = user_id
            request.state.user = UserIdentifier(payload.get("sub"))
    
    response = await call_next(request)
    return response

app.add_exception_handler(AppException, app_exception_handler)
app.add_exception_handler(RequestValidationError, validation_exception_handler)
app.add_exception_handler(Exception, generic_exception_handler)

app.include_router(auth.router, prefix="/api/v1")
app.include_router(users.router, prefix="/api/v1")
app.include_router(generation.router, prefix="/api/v1")
app.include_router(payment_packages.router, prefix="/api/v1")
app.include_router(payment_packages.public_router, prefix="/api/v1")
app.include_router(settings_api.router, prefix="/api/v1")
app.include_router(credits.router, prefix="/api/v1")
app.include_router(payments.router, prefix="/api/v1")
app.include_router(admin_dashboard.router, prefix="/api/v1")


@app.on_event("startup")
async def check_database_connection():
    """Kiểm tra kết nối database khi backend khởi động."""
    try:
        async with engine.connect() as connection:
            await connection.execute(text("SELECT 1"))
        print("Ket noi database thanh cong")
    except Exception as error:
        print(f"Ket noi database chua thanh cong: {error}")
    # Video jobs live in-process; anything still 'processing' belongs to a
    # previous run and must be failed + refunded before users poll forever.
    from controller.v1.endpoints.generation import reconcile_stale_video_jobs

    try:
        await reconcile_stale_video_jobs()
    except Exception as error:
        print(f"Stale video job reconcile failed: {error}")


@app.get("/health")
async def health():
    return {"status": "ok"}
