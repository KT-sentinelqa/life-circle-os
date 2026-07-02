from datetime import datetime
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.auth.models import RefreshToken


class AuthRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create_refresh_token(
        self,
        token_hash: str,
        user_id: UUID,
        expires_at: datetime,
        jti: str,
        device_info: str | None = None,
    ) -> RefreshToken:
        db_token = RefreshToken(
            token_hash=token_hash,
            user_id=user_id,
            expires_at=expires_at,
            jti=jti,
            device_info=device_info,
        )
        self.session.add(db_token)
        await self.session.flush()
        return db_token

    async def get_refresh_token(self, token_hash: str) -> RefreshToken | None:
        result = await self.session.execute(
            select(RefreshToken).filter(RefreshToken.token_hash == token_hash)
        )
        return result.scalars().first()

    async def delete_refresh_token(self, token_hash: str) -> None:
        token = await self.get_refresh_token(token_hash)
        if token:
            await self.session.delete(token)
            await self.session.flush()
