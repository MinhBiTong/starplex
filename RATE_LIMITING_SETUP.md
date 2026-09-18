# Rate Limiting Setup Guide

## Overview
Hệ thống đã implement rate limiting để prevent abuse và ensure fair usage của API resources, đặc biệt là generation endpoint (tốn GPU resources).

## Implementation

### Technology Stack
- **slowapi**: Flask-limiter port cho FastAPI
- **Storage**: In-memory (development) / Redis (production recommended)
- **Identification**: User ID (authenticated) / IP Address (anonymous)

## Rate Limits Applied

### 1. Image Generation Endpoint
```python
POST /api/v1/generate/image
Rate Limit: 10 requests/minute per user
```

**Rationale:**
- Image generation tốn GPU resources
- Prevent spam và abuse
- Ensure fair access cho tất cả users

### 2. Authentication Endpoints

#### Register
```python
POST /api/v1/auth/register
Rate Limit: 5 requests/minute per IP
```

**Rationale:**
- Prevent mass account creation
- Anti-bot protection

#### Login
```python
POST /api/v1/auth/login
Rate Limit: 10 requests/minute per IP
```

**Rationale:**
- Prevent brute-force password attacks
- Slow down credential stuffing

### 3. Default API Limit
```python
All other endpoints: 100 requests/minute per IP
```

## Configuration

### File Structure
```
AI_Server/
├── config/
│   └── rate_limit.py          # Rate limiter configuration
├── main.py                     # Middleware integration
└── requirements.txt            # Added slowapi
```

### Rate Limit Config (`config/rate_limit.py`)

```python
from slowapi import Limiter
from slowapi.util import get_remote_address

def _get_user_identifier(request: Request) -> str:
    """Smart identification: user_id if authenticated, else IP"""
    user = getattr(request.state, "user", None)
    if user and hasattr(user, "id"):
        return f"user:{user.id}"
    return get_remote_address(request)

limiter = Limiter(
    key_func=_get_user_identifier,
    default_limits=["100/minute"],
    storage_uri="memory://",  # Change to Redis for production
)
```

### Main App Integration (`main.py`)

1. **Limiter State**:
```python
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)
```

2. **User Injection Middleware**:
```python
@app.middleware("http")
async def inject_user_for_rate_limit(request: Request, call_next):
    """Extract user from JWT and inject into request.state"""
    # Parses Authorization header
    # Creates UserIdentifier object with id
    # Attached to request.state.user
```

### Endpoint Decorators

```python
# Generation endpoint
@router.post("/image")
@limiter.limit("10/minute")
async def generate_image(request: Request, ...):
    ...

# Auth endpoints
@router.post("/register")
@limiter.limit("5/minute")
async def register(request: Request, ...):
    ...
```

## Rate Limit Response

### Headers Returned
```http
X-RateLimit-Limit: 10          # Max requests per window
X-RateLimit-Remaining: 7       # Requests remaining
X-RateLimit-Reset: 1234567890  # Unix timestamp when limit resets
```

### Error Response (429 Too Many Requests)
```json
{
  "error": "Rate limit exceeded: 10 per 1 minute"
}
```

## Production Setup with Redis

### Why Redis?
- **Distributed**: Works across multiple workers/servers
- **Persistent**: Survives app restarts
- **Fast**: In-memory performance
- **Accurate**: Atomic operations

### Installation
```bash
# Install Redis
sudo apt-get install redis-server  # Ubuntu/Debian
brew install redis                 # macOS

# Install Python client
pip install redis
```

### Configuration Update
```python
# config/rate_limit.py
import os

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379")

limiter = Limiter(
    key_func=_get_user_identifier,
    default_limits=["100/minute"],
    storage_uri=REDIS_URL,  # Use Redis instead of memory://
)
```

### Environment Variable (.env)
```bash
REDIS_URL=redis://localhost:6379
# For Redis with password:
# REDIS_URL=redis://:password@localhost:6379
```

## Testing Rate Limits

### Manual Testing
```bash
# Test generation limit (10/minute)
for i in {1..11}; do
  curl -X POST http://localhost:8000/api/v1/generate/image \
    -H "Authorization: Bearer YOUR_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"prompt": "test", "aspect_ratio": "16:9", "style": "Cinematic", "type": "image"}'
  echo "Request $i"
done

# 11th request should return 429
```

### Python Testing Script
```python
import requests
import time

url = "http://localhost:8000/api/v1/generate/image"
headers = {"Authorization": "Bearer YOUR_TOKEN"}
data = {"prompt": "test", "aspect_ratio": "16:9", "style": "Cinematic", "type": "image"}

for i in range(12):
    response = requests.post(url, json=data, headers=headers)
    print(f"Request {i+1}: {response.status_code}")
    print(f"  Remaining: {response.headers.get('X-RateLimit-Remaining')}")
    print(f"  Limit: {response.headers.get('X-RateLimit-Limit')}")
    if response.status_code == 429:
        print(f"  Rate limited! Message: {response.json()}")
        break
    time.sleep(1)
```

## Customizing Rate Limits

### Per-User Custom Limits (Future Enhancement)

```python
# Check user's subscription tier
async def get_user_limit(request: Request) -> str:
    user = request.state.user
    if hasattr(user, 'subscription_tier'):
        if user.subscription_tier == 'premium':
            return "50/minute"
        elif user.subscription_tier == 'pro':
            return "100/minute"
    return "10/minute"

# Apply dynamic limit
@router.post("/image")
@limiter.limit(get_user_limit)
async def generate_image(request: Request, ...):
    ...
```

### Exempt Specific Users (Admin)
```python
from slowapi.util import get_remote_address

def admin_exempt_key_func(request: Request) -> str:
    user = getattr(request.state, "user", None)
    if user and getattr(user, "role", None) == "admin":
        return "admin:unlimited"  # Separate bucket, no limit
    return _get_user_identifier(request)
```

## Monitoring

### Log Rate Limit Hits
```python
import logging

@app.exception_handler(RateLimitExceeded)
async def custom_rate_limit_handler(request: Request, exc: RateLimitExceeded):
    logging.warning(
        f"Rate limit exceeded: {request.url.path} "
        f"by {_get_user_identifier(request)}"
    )
    return JSONResponse(
        status_code=429,
        content={"error": str(exc.detail)}
    )
```

### Metrics to Track
- Rate limit hits per endpoint
- Top users hitting limits
- Peak usage times
- False positive rate (legitimate users hitting limits)

## Best Practices

### 1. ✅ Different Limits for Different Resources
- Heavy operations (generation): Strict (10/min)
- Authentication: Moderate (5-10/min)
- Read operations: Lenient (100/min)

### 2. ✅ User-based vs IP-based
- **Authenticated endpoints**: Rate limit by user_id (fairer, prevents multi-account abuse)
- **Public endpoints**: Rate limit by IP (prevents anonymous abuse)

### 3. ✅ Graceful Degradation
- Return clear error messages
- Include `Retry-After` header
- Suggest upgrading subscription

### 4. ✅ Whitelist Internal Services
```python
INTERNAL_IPS = ["127.0.0.1", "10.0.0.0/8"]

def is_internal(request: Request) -> bool:
    return get_remote_address(request) in INTERNAL_IPS
```

### 5. ⚠️ Be Cautious With Distributed Systems
- Use Redis for accurate counting across instances
- Avoid memory:// in production with multiple workers

## Troubleshooting

### Issue: Rate limit not working
**Check:**
- Limiter added to app.state
- RateLimitExceeded handler registered
- Decorator applied to endpoint
- Request parameter included in endpoint signature

### Issue: All requests counted as same IP
**Check:**
- Behind reverse proxy? Enable `trust_proxy=True`
- Check X-Forwarded-For header handling

### Issue: Legitimate users hitting limits
**Solution:**
- Increase limits for that endpoint
- Implement tier-based limits
- Whitelist specific users
- Use longer time windows (per hour vs per minute)

### Issue: Rate limit persists after restart
**Cause:** Using Redis storage (this is expected)
**Solution:** Clear Redis keys or wait for TTL expiry

## Security Considerations

1. **Don't rely solely on rate limiting for security**
   - Still validate inputs
   - Still authenticate and authorize
   - Still protect against injection attacks

2. **Rate limits should be part of defense-in-depth**
   - Combined with WAF
   - Combined with authentication
   - Combined with input validation

3. **Be aware of distributed attacks**
   - Attacker using multiple IPs can bypass IP-based limits
   - Consider implementing account-level bans

## Future Enhancements

1. **Adaptive Rate Limiting**
   - Adjust limits based on system load
   - Increase during low-traffic periods

2. **Credit-based System**
   - Users consume credits instead of count-based limits
   - Different operations cost different credits

3. **Grace Periods**
   - Allow occasional bursts above limit
   - Penalize sustained abuse

4. **Dashboard**
   - Real-time rate limit monitoring
   - User consumption analytics
   - Alert on suspicious patterns

## Files Modified

### Backend
- ✅ `AI_Server/requirements.txt` - Added slowapi
- ✅ `AI_Server/config/rate_limit.py` - NEW: Limiter configuration
- ✅ `AI_Server/main.py` - Added middleware and exception handler
- ✅ `AI_Server/controller/v1/endpoints/generation.py` - Applied @limiter.limit
- ✅ `AI_Server/controller/v1/endpoints/auth.py` - Applied @limiter.limit

### Documentation
- ✅ `RATE_LIMITING_SETUP.md` - This file
