from fastapi.testclient import TestClient

from src.main import app

client = TestClient(app)


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "life-circle-api"}


def test_swagger_docs():
    response = client.get("/docs")
    assert response.status_code == 200
