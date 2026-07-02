from uuid import UUID

from fastapi import HTTPException, status

from src.organizations.models import OrganizationMember
from src.organizations.repository import OrganizationMemberRepository


class MembershipService:
    def __init__(self, member_repo: OrganizationMemberRepository):
        self.member_repo = member_repo

    async def invite_member(self, org_id: UUID, user_id: UUID, role_id: UUID) -> OrganizationMember:
        existing = await self.member_repo.get_membership(org_id, user_id)
        if existing:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="User is already a member of this organization",
            )

        member = await self.member_repo.add_member(org_id, user_id, role_id)
        await self.member_repo.session.commit()
        return member

    async def get_organization_members(self, org_id: UUID) -> list[OrganizationMember]:
        return await self.member_repo.get_members_by_organization(org_id)

    async def get_membership(self, org_id: UUID, user_id: UUID) -> OrganizationMember:
        membership = await self.member_repo.get_membership(org_id, user_id)
        if not membership:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User is not a member of this organization",
            )
        return membership

    async def remove_member(self, org_id: UUID, target_user_id: UUID) -> None:
        membership = await self.member_repo.get_membership(org_id, target_user_id)
        if not membership:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User is not a member of this organization",
            )

        # Don't allow removing the last owner? (Business logic for later, but good practice)
        if membership.role.name == "Owner":
            owners = [
                m for m in await self.get_organization_members(org_id) if m.role.name == "Owner"
            ]
            if len(owners) <= 1:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Cannot remove the last owner of the organization",
                )

        await self.member_repo.remove_member(org_id, target_user_id)
        await self.member_repo.session.commit()
