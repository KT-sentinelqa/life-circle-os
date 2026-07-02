from sqlalchemy.ext.asyncio import AsyncSession

from src.rbac.models import PermissionType, Role, RolePermission
from src.rbac.roles import ADMIN_ROLE_ID, MEMBER_ROLE_ID, OWNER_ROLE_ID, VIEWER_ROLE_ID

SYSTEM_ROLES = [
    (
        OWNER_ROLE_ID,
        "Owner",
        "Organization Owner",
        [
            PermissionType.ORGANIZATION_READ,
            PermissionType.ORGANIZATION_UPDATE,
            PermissionType.ORGANIZATION_DELETE,
            PermissionType.MEMBERS_READ,
            PermissionType.MEMBERS_INVITE,
            PermissionType.MEMBERS_UPDATE,
            PermissionType.MEMBERS_REMOVE,
            PermissionType.BILLING_READ,
            PermissionType.BILLING_MANAGE,
            PermissionType.PROFILE_MANAGE,
        ],
    ),
    (
        ADMIN_ROLE_ID,
        "Admin",
        "Organization Administrator",
        [
            PermissionType.ORGANIZATION_READ,
            PermissionType.ORGANIZATION_UPDATE,
            PermissionType.MEMBERS_READ,
            PermissionType.MEMBERS_INVITE,
            PermissionType.MEMBERS_UPDATE,
            PermissionType.MEMBERS_REMOVE,
            PermissionType.BILLING_READ,
            PermissionType.PROFILE_MANAGE,
        ],
    ),
    (
        MEMBER_ROLE_ID,
        "Member",
        "Organization Member",
        [
            PermissionType.ORGANIZATION_READ,
            PermissionType.MEMBERS_READ,
            PermissionType.PROFILE_MANAGE,
        ],
    ),
    (
        VIEWER_ROLE_ID,
        "Viewer",
        "Organization Viewer",
        [PermissionType.ORGANIZATION_READ, PermissionType.MEMBERS_READ],
    ),
]


async def ensure_system_roles(session: AsyncSession) -> None:
    for role_id, name, description, permissions in SYSTEM_ROLES:
        existing = await session.get(Role, role_id)
        if existing is None:
            role = Role(
                id=role_id,
                name=name,
                description=description,
                is_system_default=True,
                organization_id=None,
            )
            session.add(role)
            for perm in permissions:
                session.add(RolePermission(role_id=role_id, permission=perm))
    await session.flush()
