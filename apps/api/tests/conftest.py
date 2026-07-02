import uuid

import pytest
from httpx import ASGITransport, AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.pool import NullPool

from src.core.database import Base, get_db
from src.core.dependencies import get_token_blacklist
from src.core.security import create_access_token, get_password_hash
from src.main import app
from src.users.models import User, UserRole
from tests.fakes.fake_blacklist import InMemoryTokenBlacklist
from src.organizations.repository import (
    OrganizationMemberRepository,
    OrganizationRepository,
)
from src.organizations.schemas import OrganizationCreate
from src.organizations.service import OrganizationService

# Test database URL - using a separate DB for tests
TEST_DATABASE_URL = "postgresql+asyncpg://lifecircle:lifecircle@localhost:5433/lifecircle_test"

engine = create_async_engine(TEST_DATABASE_URL, poolclass=NullPool)
TestingSessionLocal = async_sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
)


async def override_get_db():
    async with TestingSessionLocal() as session:
        yield session


app.dependency_overrides[get_db] = override_get_db


_fake_blacklist = InMemoryTokenBlacklist()


def override_get_token_blacklist():
    return _fake_blacklist


app.dependency_overrides[get_token_blacklist] = override_get_token_blacklist


@pytest.fixture(autouse=True)
async def setup_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    from src.rbac.bootstrap import ensure_system_roles

    async with TestingSessionLocal() as session:
        await ensure_system_roles(session)
        await session.commit()

    yield
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest.fixture
async def db_session() -> AsyncSession:
    async with TestingSessionLocal() as session:
        yield session


@pytest.fixture
async def client() -> AsyncClient:
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as ac:
        yield ac


@pytest.fixture
async def test_user(db_session: AsyncSession) -> User:
    user = User(
        id=uuid.uuid4(),
        email="test@example.com",
        hashed_password=get_password_hash("supersecret"),
        full_name="Test User",
        role=UserRole.USER,
        is_active=True,
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)
    return user


@pytest.fixture
async def test_user_token_headers(test_user: User) -> dict:
    access_token = create_access_token(subject=str(test_user.id), role=test_user.role.value)
    return {"Authorization": f"Bearer {access_token}"}


class FakeRedis:
    def __init__(self):
        self.store = {}

    async def get(self, key):
        return self.store.get(key)

    async def setex(self, key, ttl, value):
        self.store[key] = value

    async def delete(self, key):
        self.store.pop(key, None)


@pytest.fixture(autouse=True)
def patch_redis(monkeypatch):
    fake = FakeRedis()

    async def fake_get_redis():
        return fake

    # IMPORTANT: patch the reference in evaluator where it is used
    monkeypatch.setattr(
        "src.rbac.evaluator.get_redis",
        fake_get_redis,
    )
    return fake


@pytest.fixture
async def test_organization(
    db_session: AsyncSession,
    test_user: User,
):
    service = OrganizationService(
        OrganizationRepository(db_session),
        OrganizationMemberRepository(db_session),
    )
    return await service.create_organization(
        OrganizationCreate(
            name="Test Organization",
            slug="test-organization",
        ),
        test_user.id,
    )
