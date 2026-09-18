# app/core/exception_handlers.py
from fastapi import Request, status
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from jose import JWTError
from config.exception import AppException

async def app_exception_handler(request: Request, exc: AppException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "success": False,
            "error": {
                "code": exc.detail["code"],
                "message": exc.detail["message"]
            }
        }
    )

async def validation_exception_handler(request: Request, exc: RequestValidationError):
    # Lấy lỗi đầu tiên cho gọn
    first_error = exc.errors()[0]
    field = " → ".join(str(loc) for loc in first_error["loc"])
    msg = first_error["msg"]

    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={
            "success": False,
            "error": {
                "code": "VALIDATION_ERROR",
                "message": f"Lỗi dữ liệu ở trường '{field}': {msg}"
            }
        }
    )

async def generic_exception_handler(request: Request, exc: Exception):
    # Production thì log lỗi, đừng trả traceback ra client
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={
            "success": False,
            "error": {
                "code": "INTERNAL_ERROR",
                "message": "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau."
            }
        }
    )
