from uuid import UUID

from fastapi import HTTPException, status

from src.organizations.models import Organization
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.organizations.schemas import OrganizationCreate, OrganizationUpdate


class OrganizationService:
    def __init__(
        self,
        org_repo: OrganizationRepository,
        member_repo: OrganizationMemberRepository,
    ):
        self.org_repo = org_repo
        self.member_repo = member_repo

    async def create_organization(self, org_in: OrganizationCreate, user_id: UUID) -> Organization:
        existing = await self.org_repo.get_by_slug(org_in.slug)
        if existing:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Organization with this slug already exists",
            )

        org = await self.org_repo.create(org_in, user_id)
        # The creator becomes the OWNER automatically
        from src.rbac.roles import OWNER_ROLE_ID

        await self.member_repo.add_member(org.id, user_id, OWNER_ROLE_ID)
        await self.org_repo.session.commit()
        return org

    async def get_organization(self, org_id: UUID) -> Organization:
        org = await self.org_repo.get_by_id(org_id)
        if not org:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Organization not found"
            )
        return org

    async def get_user_organizations(self, user_id: UUID) -> list[Organization]:
        memberships = await self.member_repo.get_organizations_by_user(user_id)
        orgs = []
        for membership in memberships:
            org = await self.org_repo.get_by_id(membership.organization_id)
            if org:
                orgs.append(org)
        return orgs

    async def update_organization(self, org_id: UUID, org_in: OrganizationUpdate) -> Organization:
        org = await self.get_organization(org_id)
        if org_in.slug and org_in.slug != org.slug:
            existing = await self.org_repo.get_by_slug(org_in.slug)
            if existing:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Organization with this slug already exists",
                )
        updated = await self.org_repo.update(org, org_in)
        await self.org_repo.session.commit()
        return updated
