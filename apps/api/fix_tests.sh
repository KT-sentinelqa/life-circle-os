#!/bin/bash
set -e

echo "========================================"
echo "LifeCircle Test Suite Fix"
echo "========================================"

echo
echo "1. Finding invalid UUID usage..."
grep -Rn "uuid.uuid4()" tests || true

echo
echo "2. Checking for missing User fixtures..."
grep -Rn "test_user" tests || true

echo
echo "========================================"
echo "MANUAL CODE CHANGES REQUIRED"
echo "========================================"

cat <<'MSG'

A) CREATE THIS FIXTURE IN tests/conftest.py

--------------------------------------------------

from src.users.models import User
import pytest

@pytest.fixture
async def test_user(db_session):
    user = User(
        email="test@example.com",
        hashed_password="dummy_hash",
    )

    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)

    return user

--------------------------------------------------


B) REPLACE ALL OF THESE:

owner_id = uuid.uuid4()
user_id = uuid.uuid4()

WITH:

owner_id = test_user.id


OR CREATE MULTIPLE USERS:

member = User(
    email="member@test.com",
    hashed_password="dummy_hash",
)

db_session.add(member)
await db_session.commit()
await db_session.refresh(member)

member_id = member.id


C) FIX RESPONSE MODEL FAILURES

Run:

poetry run pytest tests/integration/test_organizations.py::test_create_organization -vv -s

and inspect the 6 missing fields reported by FastAPI.

Most likely:
- created_at
- updated_at
- owner_id
- members
- role
- nested DTO fields

Ensure your router returns:

return OrganizationResponse.model_validate(entity)

or:

return OrganizationResponse.from_orm(entity)

depending on your Pydantic version.


D) FIX ASYNC FIXTURE WARNINGS

Add to pytest.ini:

---------------------------------

[pytest]
asyncio_mode = auto

---------------------------------

and convert sync tests using async fixtures into:

@pytest.mark.anyio
async def test_xxx(...):


E) FINAL VALIDATION

Run:

poetry run pytest --cov=src -vv

Target:

✅ 100% pass rate
✅ 80%+ coverage
✅ Zero FK violations
✅ Zero ResponseValidationErrors
✅ Zero Pytest 9 deprecation warnings

MSG

echo
echo "========================================"
echo "Done."
echo "========================================"

