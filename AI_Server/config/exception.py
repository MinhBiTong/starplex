# app/core/exceptions.py
from fastapi import HTTPException, status

class AppException(HTTPException):
    def __init__(self, status_code: int, code: str, message: str):
        super().__init__(status_code=status_code, detail={
            "code": code,
            "message": message
        })

# Các lỗi thường dùng
class UnauthorizedException(AppException):
    def __init__(self, message: str = "Không có quyền truy cập"):
        super().__init__(status.HTTP_401_UNAUTHORIZED, "UNAUTHORIZED", message)

class ForbiddenException(AppException):
    def __init__(self, message: str = "Bạn không có quyền thực hiện hành động này"):
        super().__init__(status.HTTP_403_FORBIDDEN, "FORBIDDEN", message)

class NotFoundException(AppException):
    def __init__(self, message: str = "Không tìm thấy dữ liệu"):
        super().__init__(status.HTTP_404_NOT_FOUND, "NOT_FOUND", message)

class BadRequestException(AppException):
    def __init__(self, message: str = "Dữ liệu không hợp lệ"):
        super().__init__(status.HTTP_400_BAD_REQUEST, "BAD_REQUEST", message)

class ConflictException(AppException):
    def __init__(self, message: str = "Dữ liệu đã tồn tại"):
        super().__init__(status.HTTP_409_CONFLICT, "CONFLICT", message)

class InsufficientCreditException(AppException):
    def __init__(self, message: str = "Bạn không đủ credit"):
        super().__init__(status.HTTP_402_PAYMENT_REQUIRED, "INSUFFICIENT_CREDIT", message)