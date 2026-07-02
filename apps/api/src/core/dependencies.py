from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.ext.asyncio import AsyncSession

from src.core.database import get_db
from src.core.redis_blacklist import RedisTokenBlacklist
from src.core.security import decode_token
from src.core.token_blacklist import TokenBlacklistProtocol
from src.organizations.invitations.email_protocol import EmailSenderProtocol
from src.organizations.invitations.email_senders import ConsoleEmailSender
from src.organizations.invitations.repository import InvitationRepository
from src.organizations.invitations.service import InvitationService
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.rbac.evaluator import PermissionEvaluator, PermissionRepository
from src.users.models import User
from src.users.repository import UserRepository
from src.users.service import UserService

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login")


def get_user_repository(session: AsyncSession = Depends(get_db)) -> UserRepository:
    return UserRepository(session)


def get_user_service(
    repository: UserRepository = Depends(get_user_repository),
) -> UserService:
    return UserService(repository)


def get_token_blacklist() -> TokenBlacklistProtocol:
    return RedisTokenBlacklist()


def get_email_sender() -> EmailSenderProtocol:
    return ConsoleEmailSender()


def get_invitation_repository(
    session: AsyncSession = Depends(get_db),
) -> InvitationRepository:
    return InvitationRepository(session)


def get_invitation_service(
    invitation_repo: InvitationRepository = Depends(get_invitation_repository),
    org_repo: OrganizationRepository = Depends(lambda s=Depends(get_db): OrganizationRepository(s)),
    member_repo: OrganizationMemberRepository = Depends(
        lambda s=Depends(get_db): OrganizationMemberRepository(s)
    ),
    user_repo: UserRepository = Depends(get_user_repository),
) -> InvitationService:
    return InvitationService(invitation_repo, org_repo, member_repo, user_repo)


def get_permission_evaluator(
    session: AsyncSession = Depends(get_db),
) -> PermissionEvaluator:
    return PermissionEvaluator(PermissionRepository(session))


async def get_current_user(
    token: str = Depends(oauth2_scheme),
    user_service: UserService = Depends(get_user_service),
    token_blacklist: TokenBlacklistProtocol = Depends(get_token_blacklist),
) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    import uuid

    try:
        payload = decode_token(token)
        user_id_str = payload.get("sub")
        if user_id_str is None:
            raise credentials_exception
        user_id = uuid.UUID(user_id_str)

        jti = payload.get("jti")
        if jti and await token_blacklist.is_blacklisted(jti):
            raise credentials_exception
    except ValueError as e:
        raise credentials_exception from e

    user = await user_service.get_user(user_id)
    if not user:
        raise credentials_exception
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return user
