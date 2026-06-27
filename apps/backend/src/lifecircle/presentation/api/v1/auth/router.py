"""
LifeCircle OS — Auth API router.

Endpoints:
  POST /api/v1/auth/register  — User registration
  POST /api/v1/families       — Family creation (authenticated)

Security:
  - Rate limiting: 5 req/min/IP via Redis sliding window (Epic 1 §4)
  - JWT: HMAC-SHA256, 15-minute expiry, keys from Doppler
  - Argon2id hashing delegated to RegisterUserUseCase

Governed by: docs/epic-1-user-registration.md | docs/golden-path/api-endpoint.md
"""

from __future__ import annotations

import time
import uuid
from datetime import UTC, datetime, timedelta
from typing import Annotated

import structlog
from fastapi import APIRouter, Depends, Header, HTTPException, Request, status
from fastapi.responses import JSONResponse
from jose import jwt
from sqlalchemy.ext.asyncio import AsyncSession

from lifecircle.application.auth.use_cases import (
    CreateFamilyCommand,
    CreateFamilyUseCase,
    RegisterUserCommand,
    RegisterUserUseCase,
    VerifyPasswordUseCase,
)
from lifecircle.config import Settings, get_settings
from lifecircle.domain.auth.repositories import (
    DuplicateEmailError,
    EventPublisher,
    UnauthorizedError,
)
from lifecircle.infrastructure.database.connection import get_db_session
from lifecircle.infrastructure.repositories.user_repository import (
    SqlAlchemyFamilyRepository,
    SqlAlchemyUserRepository,
)
from lifecircle.presentation.api.v1.auth.schemas import (
    ApiErrorResponse,
    ApiMeta,
    CreateFamilyRequest,
    CreateFamilyResponse,
    FamilyData,
    LoginData,
    LoginRequest,
    LoginResponse,
    RegisterData,
    RegisterRequest,
    RegisterResponse,
    build_error_response,
)

logger = structlog.get_logger(__name__)

router = APIRouter(prefix="/api/v1", tags=["auth"])

# ── JWT Helpers ────────────────────────────────────────────────────────────────


def _create_jwt(user_id: uuid.UUID, email: str, role: str, settings: Settings) -> str:
    """Create a signed JWT access token.

    Args:
        user_id:  The user's UUID.
        email:    The user's email.
        role:     The user's role string.
        settings: Application settings (provides JWT_SECRET).

    Returns:
        A signed JWT string.
    """
    expire = datetime.now(UTC) + timedelta(minutes=settings.jwt_expiry_minutes)
    payload = {
        "sub": str(user_id),
        "email": email,
        "role": role,
        "exp": int(expire.timestamp()),
        "iat": int(datetime.now(UTC).timestamp()),
        "jti": str(uuid.uuid4()),
    }
    return jwt.encode(
        payload,
        settings.jwt_secret.get_secret_value(),
        algorithm=settings.jwt_algorithm,
    )


def _decode_jwt(token: str, settings: Settings) -> dict[str, object]:
    """Decode and verify a JWT access token.

    Raises:
        HTTPException 401: If the token is invalid or expired.
    """
    from jose import ExpiredSignatureError, JWTError

    try:
        return jwt.decode(
            token,
            settings.jwt_secret.get_secret_value(),
            algorithms=[settings.jwt_algorithm],
        )
    except ExpiredSignatureError as err:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=build_error_response("TOKEN_EXPIRED", "Access token has expired."),
        ) from err
    except JWTError as err:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=build_error_response("TOKEN_INVALID", "Access token is invalid."),
        ) from err


# ── Rate Limiter (Redis Sliding Window) ───────────────────────────────────────


async def _check_rate_limit(
    request: Request,
    settings: Settings,
) -> None:
    """Enforce sliding window rate limit using Redis.

    Limit: settings.rate_limit_register_per_minute requests per IP per 60 seconds.

    Raises:
        HTTPException 429: If the rate limit is exceeded.
    """
    # Rate limiter is applied only if Redis is available.
    # Fails open (allows request) if Redis is not connected, to prevent
    # infrastructure failures from blocking legitimate users.
    try:
        import redis.asyncio as aioredis

        client_ip = request.client.host if request.client else "unknown"
        redis_key = f"rl:register:{client_ip}"

        # mypy: redis.asyncio.from_url is untyped in redis-py library
        redis_client = aioredis.from_url(str(settings.redis_url))  # type: ignore[no-untyped-call]
        async with redis_client as r:
            pipeline = r.pipeline()
            now = int(time.time())
            window_start = now - 60

            # Sliding window: ZREMRANGEBYSCORE + ZADD + ZCARD
            pipeline.zremrangebyscore(redis_key, "-inf", window_start)
            pipeline.zadd(redis_key, {str(uuid.uuid4()): now})
            pipeline.zcard(redis_key)
            pipeline.expire(redis_key, 60)
            results = await pipeline.execute()

            request_count = results[2]
            if request_count > settings.rate_limit_register_per_minute:
                raise HTTPException(
                    status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                    detail=build_error_response(
                        "RATE_LIMIT_EXCEEDED",
                        f"Maximum {settings.rate_limit_register_per_minute} "
                        "registration attempts per minute exceeded. Please try again later.",
                    ),
                    headers={"Retry-After": "60"},
                )
    except HTTPException:
        raise
    except Exception:
        # Fail open — log warning but don't block request
        logger.warning("Rate limiter unavailable — allowing request", exc_info=True)


# ── Dependency: Current User from JWT ─────────────────────────────────────────


async def get_current_user_id(
    settings: Annotated[Settings, Depends(get_settings)],
    authorization: Annotated[str | None, Header(alias="Authorization")] = None,
) -> uuid.UUID:
    """FastAPI dependency extracting and validating the JWT bearer token.

    Returns:
        The authenticated user's UUID.

    Raises:
        HTTPException 401: If the Authorization header is missing or token is invalid.
    """
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=build_error_response(
                "MISSING_TOKEN", "Authorization header must be 'Bearer <token>'."
            ),
        )
    token = authorization.removeprefix("Bearer ")
    claims = _decode_jwt(token, settings)
    return uuid.UUID(str(claims["sub"]))


# ── Route: POST /api/v1/auth/register ─────────────────────────────────────────


class _InMemoryEventPublisher(EventPublisher):
    """Synchronous in-process event publisher stub.

    Used until the full RabbitMQ publisher is wired in infrastructure.
    Events are logged at INFO level. Replace with aio-pika adapter in follow-on PR.
    """

    async def publish(self, event_type: str, payload: dict[str, object]) -> None:
        logger.info("Event published", event_type=event_type, payload=payload)


@router.post(
    "/auth/register",
    status_code=status.HTTP_201_CREATED,
    response_model=RegisterResponse,
    summary="Register a new user",
    description=(
        "Creates a new user account. Password is hashed with Argon2id. "
        "Returns a JWT access token valid for 15 minutes."
    ),
    responses={
        400: {"model": ApiErrorResponse, "description": "Validation error"},
        409: {"model": ApiErrorResponse, "description": "Email already registered"},
        422: {"description": "Request body schema error"},
        429: {"model": ApiErrorResponse, "description": "Rate limit exceeded"},
    },
)
async def register_user(
    request: Request,
    body: RegisterRequest,
    db: Annotated[AsyncSession, Depends(get_db_session)],
    settings: Annotated[Settings, Depends(get_settings)],
    x_api_version: Annotated[str | None, Header(alias="X-API-Version")] = None,
    x_correlation_id: Annotated[str | None, Header(alias="X-Correlation-ID")] = None,
) -> JSONResponse:
    """POST /api/v1/auth/register — User registration endpoint."""
    correlation_id = x_correlation_id or str(uuid.uuid4())

    await _check_rate_limit(request, settings)

    user_repo = SqlAlchemyUserRepository(db)
    publisher = _InMemoryEventPublisher()
    use_case = RegisterUserUseCase(user_repo, publisher)

    try:
        user = await use_case.execute(
            RegisterUserCommand(
                email=str(body.email),
                plaintext_password=body.password,
                full_name=body.full_name,
                role=body.role,
            )
        )
    except ValueError as exc:
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content=build_error_response("VALIDATION_FAILED", str(exc), trace_id=correlation_id),
        )
    except DuplicateEmailError:
        return JSONResponse(
            status_code=status.HTTP_409_CONFLICT,
            content=build_error_response(
                "EMAIL_ALREADY_REGISTERED",
                "An account with this email address already exists.",
                trace_id=correlation_id,
            ),
        )

    token = _create_jwt(user.id, user.email, user.role.value, settings)

    response_data = RegisterResponse(
        data=RegisterData(
            user_id=user.id,
            email=user.email,
            full_name=user.full_name,
            role=user.role,
            token=token,
            expires_in_minutes=settings.jwt_expiry_minutes,
        ),
        meta=ApiMeta(request_id=correlation_id),
    )

    logger.info(
        "Registration successful",
        user_id=str(user.id),
        correlation_id=correlation_id,
    )

    return JSONResponse(
        status_code=status.HTTP_201_CREATED,
        content=response_data.model_dump(mode="json"),
        headers={"X-Correlation-ID": correlation_id},
    )


@router.post(
    "/auth/login",
    status_code=status.HTTP_200_OK,
    response_model=LoginResponse,
    summary="Login a user",
    description="Authenticates a user and returns a signed JWT access token.",
    responses={
        400: {"model": ApiErrorResponse, "description": "Validation error"},
        401: {"model": ApiErrorResponse, "description": "Invalid credentials"},
        422: {"description": "Request body schema error"},
    },
)
async def login_user(
    body: LoginRequest,
    db: Annotated[AsyncSession, Depends(get_db_session)],
    settings: Annotated[Settings, Depends(get_settings)],
    x_correlation_id: Annotated[str | None, Header(alias="X-Correlation-ID")] = None,
) -> JSONResponse:
    """POST /api/v1/auth/login — User login endpoint."""
    correlation_id = x_correlation_id or str(uuid.uuid4())

    user_repo = SqlAlchemyUserRepository(db)
    user = await user_repo.find_by_email(str(body.email))
    if not user:
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content=build_error_response(
                "UNAUTHORIZED",
                "Invalid email or password.",
                trace_id=correlation_id,
            ),
        )

    if not VerifyPasswordUseCase.verify(body.password, user.password_hash):
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content=build_error_response(
                "UNAUTHORIZED",
                "Invalid email or password.",
                trace_id=correlation_id,
            ),
        )

    token = _create_jwt(user.id, user.email, user.role.value, settings)

    response_data = LoginResponse(
        data=LoginData(
            access_token=token,
            token_type="bearer",  # noqa: S106
            user=RegisterData(
                user_id=user.id,
                email=user.email,
                full_name=user.full_name,
                role=user.role,
                token=token,
                expires_in_minutes=settings.jwt_expiry_minutes,
            ),
        ),
        meta=ApiMeta(request_id=correlation_id),
    )

    logger.info(
        "Login successful",
        user_id=str(user.id),
        correlation_id=correlation_id,
    )

    return JSONResponse(
        status_code=status.HTTP_200_OK,
        content=response_data.model_dump(mode="json"),
        headers={"X-Correlation-ID": correlation_id},
    )


# ── Route: POST /api/v1/families ──────────────────────────────────────────────


@router.post(
    "/families",
    status_code=status.HTTP_201_CREATED,
    response_model=CreateFamilyResponse,
    summary="Create a new family",
    description="Creates a new family unit. Requires an authenticated Guardian JWT.",
    responses={
        401: {"model": ApiErrorResponse, "description": "Missing or invalid JWT"},
        403: {"model": ApiErrorResponse, "description": "Caller is not a guardian"},
        422: {"description": "Request body schema error"},
    },
)
async def create_family(
    body: CreateFamilyRequest,
    db: Annotated[AsyncSession, Depends(get_db_session)],
    settings: Annotated[Settings, Depends(get_settings)],
    owner_id: Annotated[uuid.UUID, Depends(get_current_user_id)],
    x_correlation_id: Annotated[str | None, Header(alias="X-Correlation-ID")] = None,
) -> JSONResponse:
    """POST /api/v1/families — Family creation endpoint."""
    correlation_id = x_correlation_id or str(uuid.uuid4())

    user_repo = SqlAlchemyUserRepository(db)
    family_repo = SqlAlchemyFamilyRepository(db)
    publisher = _InMemoryEventPublisher()
    use_case = CreateFamilyUseCase(user_repo, family_repo, publisher)

    try:
        family = await use_case.execute(CreateFamilyCommand(name=body.name, owner_id=owner_id))
    except UnauthorizedError as exc:
        return JSONResponse(
            status_code=status.HTTP_403_FORBIDDEN,
            content=build_error_response("UNAUTHORIZED", str(exc), trace_id=correlation_id),
        )

    response_data = CreateFamilyResponse(
        data=FamilyData(
            family_id=family.id,
            name=family.name,
            owner_id=family.owner_id,
            created_at=family.created_at,
        ),
        meta=ApiMeta(request_id=correlation_id),
    )

    logger.info(
        "Family created",
        family_id=str(family.id),
        owner_id=str(owner_id),
        correlation_id=correlation_id,
    )

    return JSONResponse(
        status_code=status.HTTP_201_CREATED,
        content=response_data.model_dump(mode="json"),
        headers={"X-Correlation-ID": correlation_id},
    )
