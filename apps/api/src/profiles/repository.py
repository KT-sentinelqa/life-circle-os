from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.profiles.models import UserProfile
from src.profiles.schemas import UserProfileCreate, UserProfileUpdate


class UserProfileRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_by_user_id(self, user_id: UUID) -> UserProfile | None:
        result = await self.session.execute(
            select(UserProfile).filter(UserProfile.user_id == user_id)
        )
        return result.scalars().first()

    async def create(self, obj_in: UserProfileCreate) -> UserProfile:
        db_obj = UserProfile(
            user_id=obj_in.user_id,
            full_name=obj_in.full_name,
            avatar_url=obj_in.avatar_url,
            timezone=obj_in.timezone,
            locale=obj_in.locale,
        )
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj)
        return db_obj

    async def update(self, db_obj: UserProfile, obj_in: UserProfileUpdate) -> UserProfile:
        update_data = obj_in.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(db_obj, field, value)
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj)
        return db_obj
