import pytest

from src.core.security import create_access_token, get_password_hash, verify_password


@pytest.mark.anyio
async def test_password_hashing():
    password = "super_secret_password_123!"
    hashed = get_password_hash(password)
    assert hashed != password
    assert verify_password(password, hashed) is True
    assert verify_password("wrong_password", hashed) is False


@pytest.mark.anyio
async def test_create_access_token():
    subject = "user123"
    role = "USER"
    token = create_access_token(subject, role)
    assert isinstance(token, str)
    assert len(token) > 0
