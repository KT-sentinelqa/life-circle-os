from fastapi import APIRouter, Depends, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.ext.asyncio import AsyncSession

from src.auth.repository import AuthRepository
from src.auth.schemas import (
    EmailVerification,
    MessageResponse,
    PasswordResetRequest,
    RefreshRequest,
    Token,
)
from src.auth.service import AuthService
from src.core.database import get_db
from src.core.dependencies import get_current_user, get_token_blacklist, oauth2_scheme
from src.core.token_blacklist import TokenBlacklistProtocol
from src.users.models import User
from src.users.repository import UserRepository
from src.users.schemas import UserCreate, UserRead
from src.users.service import UserService

router = APIRouter(prefix="/auth", tags=["Auth"])


def get_auth_service(
    session: AsyncSession = Depends(get_db),
    token_blacklist: TokenBlacklistProtocol = Depends(get_token_blacklist),
) -> AuthService:
    user_repo = UserRepository(session)
    auth_repo = AuthRepository(session)
    return AuthService(user_repo, auth_repo, token_blacklist)


def get_user_service(session: AsyncSession = Depends(get_db)) -> UserService:
    user_repo = UserRepository(session)
    return UserService(user_repo)


@router.post("/register", response_model=UserRead, status_code=status.HTTP_201_CREATED)
async def register(
    user_in: UserCreate, user_service: UserService = Depends(get_user_service)
) -> UserRead:
    user = await user_service.create_user(user_in)
    return UserRead(
        id=user.id,
        email=user.email,
        full_name=user.full_name,
        is_active=user.is_active,
        role=user.role,
        created_at=user.created_at,
        updated_at=user.updated_at,
    )


@router.post("/login", response_model=Token)
async def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    auth_service: AuthService = Depends(get_auth_service),
) -> Token:
    return await auth_service.login(form_data)


@router.post("/refresh", response_model=Token)
async def refresh(
    request: RefreshRequest,
    auth_service: AuthService = Depends(get_auth_service),
) -> Token:
    return await auth_service.refresh(request.refresh_token)


@router.post("/logout", status_code=status.HTTP_204_NO_CONTENT)
async def logout(
    request: RefreshRequest,
    current_user: User = Depends(get_current_user),
    access_token: str = Depends(oauth2_scheme),
    auth_service: AuthService = Depends(get_auth_service),
) -> None:
    await auth_service.logout(str(current_user.id), access_token, request.refresh_token)


@router.post("/verify-email", response_model=MessageResponse)
async def verify_email(
    request: EmailVerification,
    auth_service: AuthService = Depends(get_auth_service),
) -> MessageResponse:
    await auth_service.verify_email(request.token)
    return MessageResponse(message="Email verified successfully")


@router.post("/reset-password", response_model=MessageResponse)
async def reset_password(
    request: PasswordResetRequest,
    auth_service: AuthService = Depends(get_auth_service),
) -> MessageResponse:
    await auth_service.reset_password(request.email)
    return MessageResponse(message="Password reset instructions sent")
