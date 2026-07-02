from datetime import UTC, datetime, timedelta

from fastapi import HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm

from src.audit.service import publish_audit_event
from src.auth.repository import AuthRepository
from src.auth.schemas import Token
from src.core.config import settings
from src.core.security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    get_token_hash,
    verify_password,
)
from src.core.token_blacklist import TokenBlacklistProtocol
from src.users.repository import UserRepository


class AuthService:
    def __init__(
        self,
        user_repo: UserRepository,
        auth_repo: AuthRepository,
        token_blacklist: TokenBlacklistProtocol,
    ):
        self.user_repo = user_repo
        self.auth_repo = auth_repo
        self.token_blacklist = token_blacklist

    async def login(self, form_data: OAuth2PasswordRequestForm) -> Token:
        user = await self.user_repo.get_by_email(form_data.username)
        if not user or not verify_password(form_data.password, user.hashed_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect email or password",
                headers={"WWW-Authenticate": "Bearer"},
            )
        if not user.is_active:
            raise HTTPException(status_code=400, detail="Inactive user")

        access_token = create_access_token(subject=user.id, role=user.role.value)
        raw_refresh_token = create_refresh_token(subject=user.id)

        # Store hashed refresh token
        expires_at = datetime.now(UTC) + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        payload = decode_token(raw_refresh_token)
        jti_obj = payload.get("jti")
        if not isinstance(jti_obj, str):
            raise HTTPException(
                status_code=401,
                detail="Invalid token",
            )
        jti = jti_obj

        await self.auth_repo.create_refresh_token(
            token_hash=get_token_hash(raw_refresh_token),
            user_id=user.id,
            expires_at=expires_at,
            jti=jti,
        )
        publish_audit_event(self.auth_repo.session, "login", user_id=user.id)
        await self.auth_repo.session.commit()

        return Token(
            access_token=access_token,
            refresh_token=raw_refresh_token,
            token_type="bearer",
        )

    async def logout(self, user_id: str, access_token: str, refresh_token: str) -> None:
        # Revoke access token via Redis blacklist
        access_payload = decode_token(access_token)
        access_jti = access_payload.get("jti")
        access_exp = access_payload.get("exp")
        if access_jti and access_exp:
            expire_in = int(access_exp - datetime.now(UTC).timestamp())
            if expire_in > 0:
                await self.token_blacklist.blacklist_token(access_jti, expire_in)

        # Delete refresh token from DB
        await self.auth_repo.delete_refresh_token(get_token_hash(refresh_token))

        from uuid import UUID

        publish_audit_event(self.auth_repo.session, "logout", user_id=UUID(user_id))
        await self.auth_repo.session.commit()

    async def refresh(self, refresh_token: str) -> Token:
        # Validate refresh token structure and signature
        payload = decode_token(refresh_token)
        if payload.get("type") != "refresh":
            raise HTTPException(status_code=400, detail="Invalid token type")

        # Check if token exists in DB (revocation check)
        token_hash = get_token_hash(refresh_token)
        db_token = await self.auth_repo.get_refresh_token(token_hash)

        # We need the user
        from uuid import UUID

        user_id_str = payload.get("sub")
        if not user_id_str or not db_token:
            raise HTTPException(status_code=401, detail="Invalid or revoked refresh token")

        user = await self.user_repo.get_by_id(UUID(user_id_str))
        if not user or not user.is_active:
            raise HTTPException(status_code=401, detail="User inactive or not found")

        # Revoke old refresh token
        await self.auth_repo.delete_refresh_token(token_hash)

        # Issue new pair
        new_access_token = create_access_token(subject=user.id, role=user.role.value)
        new_refresh_token = create_refresh_token(subject=user.id)

        new_payload = decode_token(new_refresh_token)
        expires_at = datetime.now(UTC) + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)

        jti_obj = new_payload.get("jti")
        if not isinstance(jti_obj, str):
            raise HTTPException(
                status_code=401,
                detail="Invalid token",
            )
        new_jti = jti_obj

        await self.auth_repo.create_refresh_token(
            token_hash=get_token_hash(new_refresh_token),
            user_id=user.id,
            expires_at=expires_at,
            jti=new_jti,
        )
        publish_audit_event(self.auth_repo.session, "token_refresh", user_id=user.id)
        await self.auth_repo.session.commit()

        return Token(
            access_token=new_access_token,
            refresh_token=new_refresh_token,
            token_type="bearer",
        )

    async def verify_email(self, token: str) -> bool:
        # Stub for email verification
        return True

    async def reset_password(self, email: str) -> bool:
        # Stub for password reset flow initiation
        return True
