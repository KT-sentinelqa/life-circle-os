from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "LifeCircle OS Cloud Trust Platform"
    
    # In PRD, this is loaded via Vault/Secret Manager (ADR-030)
    DATABASE_URL: str = "postgresql+asyncpg://postgres:postgres@localhost:5432/lifecircle"
    REDIS_URL: str = "redis://localhost:6379"
    
    JWT_SECRET: str = "placeholder_secret_for_dev_only"
    
    class Config:
        env_file = ".env"

settings = Settings()
