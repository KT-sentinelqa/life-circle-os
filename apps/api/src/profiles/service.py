from uuid import UUID

from src.profiles.models import UserProfile
from src.profiles.repository import UserProfileRepository
from src.profiles.schemas import UserProfileCreate, UserProfileUpdate


class UserProfileService:
    def __init__(self, profile_repo: UserProfileRepository):
        self.profile_repo = profile_repo

    async def get_profile(self, user_id: UUID) -> UserProfile:
        profile = await self.profile_repo.get_by_user_id(user_id)
        if not profile:
            # Auto-create empty profile if it doesn't exist
            profile = await self.profile_repo.create(UserProfileCreate(user_id=user_id))
            await self.profile_repo.session.commit()
        return profile

    async def update_profile(self, user_id: UUID, profile_in: UserProfileUpdate) -> UserProfile:
        profile = await self.get_profile(user_id)
        updated = await self.profile_repo.update(profile, profile_in)
        await self.profile_repo.session.commit()
        return updated
