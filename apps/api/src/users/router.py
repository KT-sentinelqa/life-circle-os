from fastapi import APIRouter, Depends

from src.core.dependencies import get_current_user, get_user_service
from src.users.models import User
from src.users.schemas import UserRead, UserUpdate
from src.users.service import UserService

router = APIRouter(prefix="/users", tags=["Users"])


@router.get("/me", response_model=UserRead)
async def read_user_me(current_user: User = Depends(get_current_user)) -> UserRead:
    return UserRead(
        id=current_user.id,
        email=current_user.email,
        full_name=current_user.full_name,
        is_active=current_user.is_active,
        role=current_user.role,
        created_at=current_user.created_at,
        updated_at=current_user.updated_at,
    )


@router.patch("/me", response_model=UserRead)
async def update_user_me(
    user_in: UserUpdate,
    current_user: User = Depends(get_current_user),
    user_service: UserService = Depends(get_user_service),
) -> UserRead:
    user = await user_service.update_user(current_user.id, user_in)
    return UserRead(
        id=user.id,
        email=user.email,
        full_name=user.full_name,
        is_active=user.is_active,
        role=user.role,
        created_at=user.created_at,
        updated_at=user.updated_at,
    )


@router.delete("/me", status_code=204)
async def delete_user_me(
    current_user: User = Depends(get_current_user),
    user_service: UserService = Depends(get_user_service),
) -> None:
    await user_service.delete_user(current_user.id)
