from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    PROJECT_NAME: str = "Life Circle OS"
    API_V1_STR: str = "/api/v1"

    # Security
    SECRET_KEY: str = "super_secret_local_dev_key_change_in_prod_9999"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    REFRESH_TOKEN_EXPIRE_DAYS: int = 30

    # Database
    DATABASE_URL: str = (
        "postgresql+asyncpg://lifecircle:lifecircle_dev_secret@localhost:5432/lifecircle_db"
    )
    REDIS_URL: str = "redis://localhost:6379/0"

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")


settings = Settings()
