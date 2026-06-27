"""
LifeCircle OS — Auth API Pydantic v2 request/response schemas.

All response bodies follow the standard JSON envelope defined in:
  docs/golden-path/api-endpoint.md

Success:  {"success": true,  "data": {...}, "meta": {}}
Error:    {"success": false, "error": {"code": "", "message": "", "trace_id": ""}}

Governed by: docs/epic-1-user-registration.md §5 | docs/api-guidelines.md
"""

from __future__ import annotations

import re
from datetime import datetime
from typing import Any, Generic, TypeVar
from uuid import UUID

from pydantic import BaseModel, EmailStr, Field, field_validator

from lifecircle.domain.auth.entities import UserRole

T = TypeVar("T")

# ── Standard Envelope Models ──────────────────────────────────────────────────


class ApiMeta(BaseModel):
    """Standard response metadata envelope."""

    request_id: str | None = None
    api_version: str = "1.0.0"


class ApiSuccess(BaseModel, Generic[T]):
    """Standard success response envelope.

    Example:
        {"success": true, "data": {...}, "meta": {"api_version": "1.0.0"}}
    """

    success: bool = True
    data: T
    meta: ApiMeta = Field(default_factory=ApiMeta)


class ApiError(BaseModel):
    """Standard error detail model."""

    code: str
    message: str
    trace_id: str | None = None


class ApiErrorResponse(BaseModel):
    """Standard error response envelope.

    Example:
        {"success": false, "error": {"code": "...", "message": "...", "trace_id": "..."}}
    """

    success: bool = False
    error: ApiError


# ── Registration Schemas ───────────────────────────────────────────────────────

_PASSWORD_PATTERN = re.compile(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+]).{12,}$")


class RegisterRequest(BaseModel):
    """Request body for POST /api/v1/auth/register."""

    email: EmailStr = Field(
        description="The user's email address. Must be unique.",
        examples=["guardian@example.com"],
    )
    password: str = Field(
        min_length=12,
        max_length=128,
        description="Password (≥12 chars, upper+lower+digit+symbol).",
        examples=["SecurePassword123!"],
    )
    full_name: str = Field(
        min_length=2,
        max_length=255,
        description="The user's display name.",
        examples=["Krishna Tiwari"],
    )
    role: UserRole = Field(
        default=UserRole.GUARDIAN,
        description="User role within a family unit.",
    )

    @field_validator("password")
    @classmethod
    def validate_password_complexity(cls, value: str) -> str:
        """Enforce password complexity at the presentation layer."""
        if not _PASSWORD_PATTERN.match(value):
            raise ValueError(
                "Password must contain at least one uppercase letter, "
                "one lowercase letter, one digit, and one special character "
                "(!@#$%^&*()_+)."
            )
        return value

    @field_validator("full_name")
    @classmethod
    def strip_full_name(cls, value: str) -> str:
        """Strip whitespace from full name."""
        return value.strip()


class RegisterData(BaseModel):
    """The 'data' payload returned in a successful registration response."""

    user_id: UUID
    email: str
    full_name: str
    role: UserRole
    token: str
    token_type: str = "Bearer"
    expires_in_minutes: int


RegisterResponse = ApiSuccess[RegisterData]


# ── Family Creation Schemas ────────────────────────────────────────────────────


class CreateFamilyRequest(BaseModel):
    """Request body for POST /api/v1/families."""

    name: str = Field(
        min_length=2,
        max_length=255,
        description="The family's display name.",
        examples=["Tiwari Family"],
    )

    @field_validator("name")
    @classmethod
    def strip_name(cls, value: str) -> str:
        return value.strip()


class FamilyData(BaseModel):
    """The 'data' payload returned in a successful family creation response."""

    family_id: UUID
    name: str
    owner_id: UUID
    created_at: datetime


CreateFamilyResponse = ApiSuccess[FamilyData]


# ── Login Schemas ─────────────────────────────────────────────────────────────


class LoginRequest(BaseModel):
    """Request body for POST /api/v1/auth/login."""

    email: EmailStr = Field(
        description="The user's email address.",
        examples=["guardian@example.com"],
    )
    password: str = Field(
        description="The user's password.",
        examples=["SecurePassword123!"],
    )


class LoginData(BaseModel):
    """The 'data' payload returned in a successful login response."""

    access_token: str
    token_type: str = "bearer"
    user: RegisterData


LoginResponse = ApiSuccess[LoginData]


# ── Token Schema (internal, used for JWT generation) ──────────────────────────


class TokenPayload(BaseModel):
    """JWT claims payload."""

    sub: str  # user_id as string
    email: str
    role: str
    exp: int  # Unix timestamp


def build_error_response(
    code: str,
    message: str,
    trace_id: str | None = None,
) -> dict[str, Any]:
    """Helper to construct a standard error response dict."""
    return ApiErrorResponse(
        error=ApiError(code=code, message=message, trace_id=trace_id)
    ).model_dump()
