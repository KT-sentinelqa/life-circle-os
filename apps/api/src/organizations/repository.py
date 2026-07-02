from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

from src.organizations.models import Organization, OrganizationMember
from src.organizations.schemas import OrganizationCreate, OrganizationUpdate


class OrganizationRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_by_id(self, org_id: UUID) -> Organization | None:
        result = await self.session.execute(select(Organization).filter(Organization.id == org_id))
        return result.scalars().first()

    async def get_by_slug(self, slug: str) -> Organization | None:
        result = await self.session.execute(select(Organization).filter(Organization.slug == slug))
        return result.scalars().first()

    async def create(self, obj_in: OrganizationCreate, owner_id: UUID) -> Organization:
        db_obj = Organization(name=obj_in.name, slug=obj_in.slug, owner_id=owner_id)
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj)
        return db_obj

    async def update(self, db_obj: Organization, obj_in: OrganizationUpdate) -> Organization:
        update_data = obj_in.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(db_obj, field, value)
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj)
        return db_obj

    async def delete(self, org_id: UUID) -> None:
        org = await self.get_by_id(org_id)
        if org:
            await self.session.delete(org)
            await self.session.flush()


class OrganizationMemberRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_membership(self, org_id: UUID, user_id: UUID) -> OrganizationMember | None:
        result = await self.session.execute(
            select(OrganizationMember)
            .options(selectinload(OrganizationMember.role))
            .filter(OrganizationMember.organization_id == org_id)
            .filter(OrganizationMember.user_id == user_id)
        )
        return result.scalars().first()

    async def get_members_by_organization(self, org_id: UUID) -> list[OrganizationMember]:
        result = await self.session.execute(
            select(OrganizationMember)
            .options(selectinload(OrganizationMember.role))
            .filter(OrganizationMember.organization_id == org_id)
        )
        return list(result.scalars().all())

    async def get_organizations_by_user(self, user_id: UUID) -> list[OrganizationMember]:
        result = await self.session.execute(
            select(OrganizationMember)
            .options(selectinload(OrganizationMember.role))
            .filter(OrganizationMember.user_id == user_id)
        )
        return list(result.scalars().all())

    async def add_member(self, org_id: UUID, user_id: UUID, role_id: UUID) -> OrganizationMember:
        db_obj = OrganizationMember(organization_id=org_id, user_id=user_id, role_id=role_id)
        self.session.add(db_obj)
        await self.session.flush()
        await self.session.refresh(db_obj, ["role"])
        return db_obj

    async def remove_member(self, org_id: UUID, user_id: UUID) -> None:
        membership = await self.get_membership(org_id, user_id)
        if membership:
            await self.session.delete(membership)
            await self.session.flush()
