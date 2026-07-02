from uuid import UUID

from fastapi import HTTPException

from src.users.models import User
from src.users.repository import UserRepository
from src.users.schemas import UserCreate, UserUpdate


class UserService:
    def __init__(self, repository: UserRepository):
        self.repository = repository

    async def create_user(self, user_in: UserCreate) -> User:
        user = await self.repository.get_by_email(user_in.email)
        if user:
            raise HTTPException(
                status_code=400,
                detail="The user with this email already exists in the system.",
            )
        user = await self.repository.create(user_in)
        await self.repository.session.commit()
        return user

    async def get_user(self, user_id: UUID) -> User:
        user = await self.repository.get_by_id(user_id)
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        return user

    async def update_user(self, user_id: UUID, user_in: UserUpdate) -> User:
        user = await self.repository.get_by_id(user_id)
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        if user_in.email and user_in.email != user.email:
            existing_user = await self.repository.get_by_email(user_in.email)
            if existing_user:
                raise HTTPException(
                    status_code=400, detail="The user with this email already exists."
                )

        updated = await self.repository.update(user, user_in)
        await self.repository.session.commit()
        return updated

    async def delete_user(self, user_id: UUID) -> None:
        user = await self.repository.get_by_id(user_id)
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        await self.repository.delete(user_id)
        await self.repository.session.commit()
