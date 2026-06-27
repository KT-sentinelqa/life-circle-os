from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lifecircle_frontend.main import app


@pytest.fixture
def client() -> TestClient:
    """Fixture to provide a clean TestClient instance for every test."""
    return TestClient(app)
