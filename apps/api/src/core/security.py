import hashlib
import uuid
from datetime import UTC, datetime, timedelta
from typing import Any

import jwt
from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

from src.core.config import settings

ph = PasswordHasher()


def verify_password(plain_password: str, hashed_password: str) -> bool:
    try:
        # Fallback for bcrypt hashes if testing/migration
        if hashed_password.startswith("$2b$") or hashed_password.startswith("$2a$"):
            import bcrypt

            return bcrypt.checkpw(plain_password.encode("utf-8"), hashed_password.encode("utf-8"))

        return ph.verify(hashed_password, plain_password)
    except VerifyMismatchError:
        return False
    except Exception:
        return False


def get_password_hash(password: str) -> str:
    return ph.hash(password)


def get_token_hash(token: str) -> str:
    return hashlib.sha256(token.encode("utf-8")).hexdigest()


def create_access_token(subject: str | Any, role: str) -> str:
    expire = datetime.now(UTC) + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    jti = str(uuid.uuid4())
    to_encode = {"exp": expire, "sub": str(subject), "role": role, "jti": jti}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt


def create_refresh_token(subject: str | Any) -> str:
    # A refresh token is also a JWT, but just longer-lived and stored/verified in DB
    expire = datetime.now(UTC) + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    jti = str(uuid.uuid4())
    to_encode = {"exp": expire, "sub": str(subject), "type": "refresh", "jti": jti}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt


def decode_token(token: str) -> dict[str, Any]:
    try:
        decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        return decoded_token
    except jwt.ExpiredSignatureError as e:
        raise ValueError("Token has expired") from e
    except jwt.InvalidTokenError as e:
        raise ValueError("Invalid token") from e
