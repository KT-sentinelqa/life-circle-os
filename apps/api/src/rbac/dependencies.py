from collections.abc import Callable
from typing import Any
from uuid import UUID

from fastapi import Depends, HTTPException, Path, status

from src.core.dependencies import get_current_user, get_permission_evaluator
from src.rbac.evaluator import PermissionEvaluator
from src.rbac.models import PermissionType
from src.users.models import User


def require_permission(required_permission: PermissionType) -> Callable[..., Any]:
    """Dependency generator that enforces a specific permission"""

    async def permission_checker(
        org_id: UUID = Path(..., alias="id", description="The ID of the organization"),
        current_user: User = Depends(get_current_user),
        evaluator: PermissionEvaluator = Depends(get_permission_evaluator),
    ) -> bool:
        has_perm = await evaluator.has_permission(
            org_id, current_user.id, required_permission.value
        )
        if not has_perm:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"You do not have the required permission: {required_permission.value}",
            )
        return True

    return permission_checker
