from slowapi import Limiter
from slowapi.util import get_remote_address
from fastapi import Request


def _get_user_identifier(request: Request) -> str:
    """
    Get unique identifier for rate limiting.
    Use user_id if authenticated, otherwise use IP address.
    """
    # Try to get user from request state (set by auth dependency)
    user = getattr(request.state, "user", None)
    if user and hasattr(user, "id"):
        return f"user:{user.id}"

    # Fallback to IP address
    return get_remote_address(request)


def _get_ip_identifier(request: Request) -> str:
    """Strict per-IP key used for unauthenticated endpoints.

    Public endpoints such as ``/auth/forgot-password`` must be keyed by
    IP only — using the user identifier here would let an unauthenticated
    caller bypass the limit by simply not sending an Authorization header.
    """
    return get_remote_address(request)


# Create limiter instance
# Storage backend:
#   * "memory://" — in-process, resets on restart. Suitable for development
#     and single-worker deployments only.
#   * Redis       — recommended for production. Configure via env:
#       REDIS_URL=redis://host:6379/0
#     and switch storage_uri to f"{REDIS_URL}" so limits persist across
#     restarts and workers.
limiter = Limiter(
    key_func=_get_user_identifier,
    default_limits=["100/minute"],  # Default rate limit
    storage_uri="memory://",  # In-memory; set to REDIS_URL for production
)


# Separate limiter instance used strictly for anonymous, IP-keyed limits.
# Sharing the user-keyed limiter would force those endpoints to use the
# same key_func, which is exactly what we want to avoid here.
ip_limiter = Limiter(
    key_func=_get_ip_identifier,
    storage_uri="memory://",
)


# Common rate limit decorators
def generation_limit():
    """Rate limit for generation endpoints: 10 requests per minute per user"""
    return limiter.limit("10/minute")


def auth_limit():
    """Rate limit for auth endpoints: 5 requests per minute per IP"""
    return limiter.limit("5/minute")


def api_limit():
    """Standard API rate limit: 60 requests per minute"""
    return limiter.limit("60/minute")


def forgot_password_limit():
    """Per-IP rate limit for the password reset request endpoint.

    3 requests per 5 minutes per IP — strict enough to discourage
    email-enumeration and token-spam, lenient enough not to lock out
    a legitimate user who mistypes their address a few times.
    """
    return ip_limiter.limit("3/5minute")


def login_limit():
    """Per-IP rate limit for ``/auth/login``.

    10 attempts per 5 minutes per IP. Login is anonymous (we haven't
    authenticated the caller yet), so the limit must be keyed by IP
    only — otherwise an attacker without an Authorization header
    would simply dodge the user-keyed bucket.
    """
    return ip_limiter.limit("10/5minute")


def register_limit():
    """Per-IP rate limit for ``/auth/register``.

    5 sign-ups per 5 minutes per IP. Pairs with the SMTP rate limit
    (when SMTP is wired up) to keep automated account creation in check.
    """
    return ip_limiter.limit("5/5minute")
