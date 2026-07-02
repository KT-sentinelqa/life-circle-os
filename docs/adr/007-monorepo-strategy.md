# ADR-007: Monorepo Strategy

## Status
Accepted

## Context
As Life Circle OS transitions into Phase 4 (Product Foundation Implementation), we must establish the physical repository structure that will house the Frontend (Next.js), Mobile (Flutter), Backend (FastAPI), and Shared libraries. 
We evaluated two primary organizational models:
- **Option A (Monorepo):** A single repository containing all applications, packages, configuration, and infrastructure code.
- **Option B (Polyrepo):** Separate repositories for each distinct deployable unit (e.g., `life-circle-web`, `life-circle-api`).

## Decision
We will adopt **Option A (Monorepo)** for the foundational years of Life Circle OS.

## Rationale
1. **Shared Governance:** A single repository guarantees that our Enterprise Bootstrap Contract (e.g., `OPERATING_AGREEMENT.md`, ADRs) applies universally to all codebases without synchronization drift.
2. **Unified CI/CD:** We can enforce cross-cutting quality gates (e.g., Playwright E2E tests spanning both frontend and backend) in a single GitHub Actions pipeline.
3. **Easier Onboarding:** Developers can spin up the entire ecosystem (database, backend, frontend) with a single command (`make up`) from one cloned repository.
4. **Consistent Security Controls:** Supply-chain security policies (SEC-001 through SEC-005) are enforced uniformly across all applications in one centralized configuration.
5. **Code Sharing:** Shared business logic, types, and design tokens can be extracted into a `packages/` directory and consumed locally without publishing to external package registries.

## Consequences
- The repository structure will be organized into `/apps`, `/packages`, `/docs`, `/infrastructure`, and `/enterprise-os`.
- Tooling like **Turborepo** or **Melos** will be leveraged to manage cross-project dependencies and optimize build caching.
- CI pipelines must use path-filtering to ensure that only the affected subsystems are built and deployed when a PR is merged.
- Cross-functional teams will collaborate in a single Git history, requiring strict CODEOWNERS enforcement to prevent accidental cross-boundary regressions.
