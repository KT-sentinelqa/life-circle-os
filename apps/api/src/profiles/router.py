from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from src.core.database import get_db
from src.core.dependencies import get_current_user
from src.profiles.repository import UserProfileRepository
from src.profiles.schemas import UserProfileRead, UserProfileUpdate
from src.profiles.service import UserProfileService
from src.users.models import User

router = APIRouter(prefix="/profile", tags=["Profiles"])


def get_profile_service(session: AsyncSession = Depends(get_db)) -> UserProfileService:
    return UserProfileService(UserProfileRepository(session))


@router.get("", response_model=UserProfileRead)
async def get_my_profile(
    current_user: User = Depends(get_current_user),
    profile_service: UserProfileService = Depends(get_profile_service),
) -> UserProfileRead:
    profile = await profile_service.get_profile(current_user.id)
    return UserProfileRead(
        id=profile.id,
        user_id=profile.user_id,
        full_name=profile.full_name,
        avatar_url=profile.avatar_url,
        timezone=profile.timezone,
        locale=profile.locale,
        created_at=profile.created_at,
        updated_at=profile.updated_at,
    )


@router.put("", response_model=UserProfileRead)
async def update_my_profile(
    profile_in: UserProfileUpdate,
    current_user: User = Depends(get_current_user),
    profile_service: UserProfileService = Depends(get_profile_service),
) -> UserProfileRead:
    profile = await profile_service.update_profile(current_user.id, profile_in)
    return UserProfileRead(
        id=profile.id,
        user_id=profile.user_id,
        full_name=profile.full_name,
        avatar_url=profile.avatar_url,
        timezone=profile.timezone,
        locale=profile.locale,
        created_at=profile.created_at,
        updated_at=profile.updated_at,
    )
