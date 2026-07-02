from uuid import UUID

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from src.core.database import get_db
from src.core.dependencies import get_current_user
from src.organizations.membership_service import MembershipService
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.organizations.schemas import (
    OrganizationCreate,
    OrganizationMemberCreate,
    OrganizationMemberRead,
    OrganizationRead,
)
from src.organizations.service import OrganizationService
from src.rbac.dependencies import require_permission
from src.rbac.models import PermissionType
from src.users.models import User

router = APIRouter(prefix="/organizations", tags=["Organizations"])


def get_org_service(session: AsyncSession = Depends(get_db)) -> OrganizationService:
    return OrganizationService(
        OrganizationRepository(session), OrganizationMemberRepository(session)
    )


def get_membership_service(
    session: AsyncSession = Depends(get_db),
) -> MembershipService:
    return MembershipService(OrganizationMemberRepository(session))


@router.post("", response_model=OrganizationRead, status_code=status.HTTP_201_CREATED)
async def create_organization(
    org_in: OrganizationCreate,
    current_user: User = Depends(get_current_user),
    org_service: OrganizationService = Depends(get_org_service),
) -> OrganizationRead:
    org = await org_service.create_organization(org_in, current_user.id)
    return OrganizationRead(
        id=org.id,
        name=org.name,
        slug=org.slug,
        owner_id=org.owner_id,
        created_at=org.created_at,
        updated_at=org.updated_at,
    )


@router.get("", response_model=list[OrganizationRead])
async def get_organizations(
    current_user: User = Depends(get_current_user),
    org_service: OrganizationService = Depends(get_org_service),
) -> list[OrganizationRead]:
    orgs = await org_service.get_user_organizations(current_user.id)
    return [
        OrganizationRead(
            id=org.id,
            name=org.name,
            slug=org.slug,
            owner_id=org.owner_id,
            created_at=org.created_at,
            updated_at=org.updated_at,
        )
        for org in orgs
    ]


@router.get("/{id}", response_model=OrganizationRead)
async def get_organization(
    id: UUID,
    current_user: User = Depends(get_current_user),
    has_perm: bool = Depends(require_permission(PermissionType.ORGANIZATION_READ)),
    org_service: OrganizationService = Depends(get_org_service),
) -> OrganizationRead:
    org = await org_service.get_organization(id)
    return OrganizationRead(
        id=org.id,
        name=org.name,
        slug=org.slug,
        owner_id=org.owner_id,
        created_at=org.created_at,
        updated_at=org.updated_at,
    )


@router.post(
    "/{id}/invite",
    response_model=OrganizationMemberRead,
    status_code=status.HTTP_201_CREATED,
)
async def invite_member(
    id: UUID,
    member_in: OrganizationMemberCreate,
    current_user: User = Depends(get_current_user),
    has_perm: bool = Depends(require_permission(PermissionType.MEMBERS_INVITE)),
    membership_service: MembershipService = Depends(get_membership_service),
) -> OrganizationMemberRead:
    member = await membership_service.invite_member(id, member_in.user_id, member_in.role_id)
    return OrganizationMemberRead(
        id=member.id,
        organization_id=member.organization_id,
        user_id=member.user_id,
        role_id=member.role_id,
        role_name=member.role.name if member.role else None,
        created_at=member.created_at,
    )


@router.delete("/{id}/members/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
async def remove_member(
    id: UUID,
    user_id: UUID,
    current_user: User = Depends(get_current_user),
    has_perm: bool = Depends(require_permission(PermissionType.MEMBERS_REMOVE)),
    membership_service: MembershipService = Depends(get_membership_service),
) -> None:
    await membership_service.remove_member(id, user_id)
