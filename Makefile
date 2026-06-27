# LifeCircle OS — Root Makefile
# Governed by: docs/sprint-zero-plan.md | docs/developer-workflow.md
# Status: Locked v1.0

.DEFAULT_GOAL := help
SHELL := /bin/bash
.ONESHELL:

# ── Configuration ─────────────────────────────────────────────────────────────
COMPOSE_FILE := infrastructure/docker/docker-compose.yml
BACKEND_DIR  := apps/backend
MOBILE_DIR   := apps/mobile
PYTHON       := poetry run python
ALEMBIC      := poetry run alembic
PYTEST       := poetry run pytest
RUFF         := poetry run ruff
MYPY         := poetry run mypy

# ── Environment ───────────────────────────────────────────────────────────────
ENV_LOAD := if [ -f infrastructure/docker/.env.local ]; then set -a; . infrastructure/docker/.env.local; set +a; fi;

# ── Colours ───────────────────────────────────────────────────────────────────
BOLD  := \033[1m
GREEN := \033[0;32m
CYAN  := \033[0;36m
RED   := \033[0;31m
RESET := \033[0m

##@ ── Help ────────────────────────────────────────────────────────────────────

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\n$(BOLD)Usage:$(RESET)\n  make $(CYAN)<target>$(RESET)\n"} \
	  /^[a-zA-Z_0-9-]+:.*?##/ { printf "  $(CYAN)%-22s$(RESET) %s\n", $$1, $$2 } \
	  /^##@/ { printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ ── Local Infrastructure ────────────────────────────────────────────────────

.PHONY: dev-up
dev-up: ## Start all local Docker services (Postgres, Redis, RabbitMQ, MailHog)
	@echo "$(GREEN)▶ Starting local infrastructure…$(RESET)"
	@cp -n infrastructure/docker/.env.local.example infrastructure/docker/.env.local 2>/dev/null || true
	docker compose -f $(COMPOSE_FILE) --env-file infrastructure/docker/.env.local up -d --wait
	@echo "$(GREEN)✓ Infrastructure ready. Run 'make migrate' to apply DB migrations.$(RESET)"

.PHONY: dev-down
dev-down: ## Stop all local Docker services
	@echo "$(RED)▶ Stopping local infrastructure…$(RESET)"
	docker compose -f $(COMPOSE_FILE) down

.PHONY: dev-reset
dev-reset: ## Destroy and recreate all local Docker services (⚠ data loss)
	@echo "$(RED)⚠ This will destroy all local data. Ctrl+C to abort.$(RESET)"
	@sleep 3
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	$(MAKE) dev-up

.PHONY: dev-logs
dev-logs: ## Tail logs from all local Docker services
	docker compose -f $(COMPOSE_FILE) logs -f

##@ ── Database Migrations ─────────────────────────────────────────────────────

.PHONY: migrate
migrate: ## Apply all pending Alembic migrations (upgrade head)
	@echo "$(GREEN)▶ Running Alembic migrations…$(RESET)"
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(ALEMBIC) upgrade head )
	@echo "$(GREEN)✓ Migrations applied.$(RESET)"

.PHONY: migrate-down
migrate-down: ## Rollback one Alembic migration step (verify rollback path)
	@echo "$(RED)▶ Rolling back one Alembic migration step…$(RESET)"
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(ALEMBIC) downgrade -1 )

.PHONY: migrate-base
migrate-base: ## Rollback ALL Alembic migrations to base (⚠ data loss)
	@echo "$(RED)⚠ Rolling back ALL migrations. Ctrl+C to abort.$(RESET)"
	@sleep 3
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(ALEMBIC) downgrade base )

.PHONY: migrate-new
migrate-new: ## Generate a new Alembic migration — usage: make migrate-new MSG="add column"
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(ALEMBIC) revision --autogenerate -m "$(MSG)" )

##@ ── Backend (FastAPI) ───────────────────────────────────────────────────────

.PHONY: backend-install
backend-install: ## Install backend Python dependencies via Poetry
	@( cd $(BACKEND_DIR) && poetry install --with dev )

.PHONY: backend-dev
backend-dev: ## Run FastAPI development server with auto-reload
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(PYTHON) -m uvicorn lifecircle.main:app --reload --port 8000 )

.PHONY: backend-test
backend-test: ## Run backend unit tests with >90% coverage gate and generate reports
	@echo "$(GREEN)▶ Running backend tests…$(RESET)"
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && $(PYTEST) tests/ --cov=src --cov-report=term-missing --cov-report=xml:coverage.xml --junitxml=junit.xml --cov-fail-under=90 -v )

.PHONY: backend-lint
backend-lint: ## Run Ruff linter + mypy type checker on backend
	@( cd $(BACKEND_DIR) && $(RUFF) check src/ tests/ )
	@( cd $(BACKEND_DIR) && $(MYPY) src/ )

.PHONY: backend-fmt
backend-fmt: ## Auto-format backend code with Ruff
	@( cd $(BACKEND_DIR) && $(RUFF) format src/ tests/ )

##@ ── Mobile (Flutter) ───────────────────────────────────────────────────────

.PHONY: mobile-install
mobile-install: ## Install Flutter/Dart dependencies
	@( cd $(MOBILE_DIR) && flutter pub get )

.PHONY: mobile-test
mobile-test: ## Run Flutter widget and unit tests
	@( cd $(MOBILE_DIR) && flutter test --coverage )

.PHONY: mobile-analyze
mobile-analyze: ## Run Dart analyzer
	@( cd $(MOBILE_DIR) && flutter analyze )

.PHONY: mobile-fmt
mobile-fmt: ## Format Dart code
	@( cd $(MOBILE_DIR) && dart format --set-exit-if-changed . )

##@ ── Quality & Security ──────────────────────────────────────────────────────

.PHONY: lint
lint: backend-lint mobile-analyze ## Run all linters (backend + mobile)

.PHONY: test
test: backend-test mobile-test ## Run all tests (backend + mobile)

.PHONY: test-e2e
test-e2e: ## Run E2E tests against live local stack and generate reports (requires: make dev-up + make migrate + make backend-dev)
	@( $(ENV_LOAD) cd apps/backend && poetry run pytest tests/e2e/ -v --tb=short --junitxml=e2e-results.xml )

.PHONY: pre-commit
pre-commit: ## Run all pre-commit hooks across the repository
	pre-commit run --all-files

.PHONY: security-scan
security-scan: ## Run Trivy vulnerability scanner on Docker images
	trivy image --exit-code 1 --severity CRITICAL,HIGH postgres:17-alpine
	trivy image --exit-code 1 --severity CRITICAL,HIGH redis:8-alpine
	trivy image --exit-code 1 --severity CRITICAL,HIGH rabbitmq:4-management-alpine
##@ ── Verification & Reports ──────────────────────────────────────────────────

.PHONY: generate-reports
generate-reports: ## Run all quality gates and generate evidence reports (ruff, mypy, bandit, pytest unit + e2e)
	@echo "$(GREEN)▶ Generating all quality gate reports…$(RESET)"
	@mkdir -p verification-evidence
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && poetry run ruff check src/ tests/ > ../../verification-evidence/ruff-report.txt || true )
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && poetry run mypy src/ > ../../verification-evidence/mypy-report.txt || true )
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && poetry run bandit -r src/ -f json -o ../../verification-evidence/bandit-report.json || true )
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && poetry run pytest tests/ --cov=src --cov-report=xml:../../verification-evidence/coverage.xml --junitxml=../../verification-evidence/junit.xml --cov-fail-under=90 -v || true )
	@( $(ENV_LOAD) cd $(BACKEND_DIR) && poetry run pytest tests/e2e/ --junitxml=../../verification-evidence/e2e-results.xml -v || true )
	@echo "$(GREEN)✓ Reports generated in verification-evidence/ directory.$(RESET)"

##@ ── Onboarding ──────────────────────────────────────────────────────────────

.PHONY: bootstrap
bootstrap: ## Full developer bootstrap (install + dev-up + migrate) — SLA: <30 min
	@echo "$(BOLD)$(GREEN)▶ LifeCircle OS — Developer Bootstrap$(RESET)"
	@echo "$(CYAN)  Step 1/4: Installing backend dependencies…$(RESET)"
	$(MAKE) backend-install
	@echo "$(CYAN)  Step 2/4: Installing mobile dependencies…$(RESET)"
	$(MAKE) mobile-install
	@echo "$(CYAN)  Step 3/4: Starting local infrastructure…$(RESET)"
	$(MAKE) dev-up
	@echo "$(CYAN)  Step 4/4: Applying database migrations…$(RESET)"
	$(MAKE) migrate
	@echo ""
	@echo "$(BOLD)$(GREEN)✓ Bootstrap complete! You are ready to code.$(RESET)"
	@echo "  API:       http://localhost:8000"
	@echo "  Docs:      http://localhost:8000/docs"
	@echo "  RabbitMQ:  http://localhost:15672 (guest/guest)"
	@echo "  MailHog:   http://localhost:8025"

.PHONY: check-deps
check-deps: ## Verify all required tools are installed
	@echo "$(CYAN)Checking required tools…$(RESET)"
	@command -v docker    >/dev/null 2>&1 || (echo "$(RED)✗ docker not found$(RESET)";    exit 1)
	@command -v poetry    >/dev/null 2>&1 || (echo "$(RED)✗ poetry not found$(RESET)";    exit 1)
	@command -v flutter   >/dev/null 2>&1 || (echo "$(RED)✗ flutter not found$(RESET)";   exit 1)
	@command -v pre-commit>/dev/null 2>&1 || (echo "$(RED)✗ pre-commit not found$(RESET)";exit 1)
	@echo "$(GREEN)✓ All required tools present.$(RESET)"
