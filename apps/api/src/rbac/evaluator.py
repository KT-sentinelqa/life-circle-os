import json
from uuid import UUID

import redis.asyncio as redis
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.core.redis_blacklist import get_redis
from src.organizations.models import OrganizationMember
from src.rbac.models import RolePermission


class PermissionRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_user_permissions(self, org_id: UUID, user_id: UUID) -> list[str]:
        # 1. Get the user's role in the organization
        result = await self.session.execute(
            select(OrganizationMember).filter(
                OrganizationMember.organization_id == org_id,
                OrganizationMember.user_id == user_id,
            )
        )
        member = result.scalars().first()
        if not member:
            return []

        # 2. Get permissions for the role
        perm_result = await self.session.execute(
            select(RolePermission.permission).filter(RolePermission.role_id == member.role_id)
        )
        # Convert Enum values to strings
        permissions = [p.value for p in perm_result.scalars().all()]
        return permissions


class PermissionEvaluator:
    def __init__(self, repo: PermissionRepository):
        self.repo = repo
        self.cache_ttl = 300  # Cache for 5 minutes

    async def _get_redis_client(self) -> redis.Redis:
        return await get_redis()

    def _get_cache_key(self, org_id: UUID, user_id: UUID) -> str:
        return f"perms:{org_id}:{user_id}"

    async def get_permissions(self, org_id: UUID, user_id: UUID) -> list[str]:
        client = await self._get_redis_client()
        cache_key = self._get_cache_key(org_id, user_id)

        # 1. Try cache
        cached = await client.get(cache_key)
        if cached:
            from typing import cast

            return cast(list[str], json.loads(cached))

        # 2. Fallback to DB
        permissions = await self.repo.get_user_permissions(org_id, user_id)

        # 3. Update cache
        await client.setex(cache_key, self.cache_ttl, json.dumps(permissions))

        return permissions

    async def has_permission(self, org_id: UUID, user_id: UUID, permission: str) -> bool:
        permissions = await self.get_permissions(org_id, user_id)
        return permission in permissions

    async def invalidate_cache(self, org_id: UUID, user_id: UUID) -> None:
        client = await self._get_redis_client()
        await client.delete(self._get_cache_key(org_id, user_id))
