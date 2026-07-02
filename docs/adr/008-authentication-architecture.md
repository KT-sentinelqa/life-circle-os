# ADR-008: Authentication & Authorization Architecture

## Status
Accepted

## Context
As we begin Phase 2 (Domain Modelling), the Life Circle OS backend requires a robust identity and access management foundation. We must establish how users authenticate, how sessions are maintained across web and mobile clients, and how permissions are enforced at the API level.

## Decision
We will implement an **OAuth2 with JWT Bearer Token** architecture.

### Technical Implementation Details:
1. **Access Tokens**: Short-lived JWTs (15 minutes). Contains minimal payload (`sub` = user_id, `role` = user_role).
2. **Refresh Tokens**: Long-lived cryptographic tokens (30 days).
3. **Storage**: Access tokens are purely stateless. Refresh tokens are hashed using bcrypt and stored in the PostgreSQL database (`refresh_tokens` table) to allow for remote revocation.
4. **Token Rotation**: Every time a refresh token is used to obtain a new access token, a *new* refresh token is also issued, and the old one is invalidated. This mitigates token theft replay attacks.
5. **RBAC Roles**: 
   - `SUPER_ADMIN`
   - `ADMIN`
   - `FAMILY_OWNER`
   - `FAMILY_MEMBER`
   - `CHILD`
   - `GUEST`

## Rationale
- **Stateless Verification**: JWTs allow the backend to verify API requests without querying the database for every single HTTP request, drastically improving P95 latency (enforcing the <200ms SLO).
- **Security**: Storing only hashed refresh tokens ensures that a database leak does not immediately grant an attacker valid persistent sessions. Refresh token rotation forces attackers to compete with legitimate users, quickly exposing token theft.
- **Client Flexibility**: Bearer tokens are a universally supported standard across Next.js and Flutter ecosystems.

## Consequences
- The API gateway or reverse proxy must pass the `Authorization: Bearer <token>` header unmodified.
- Clients (Next.js, Flutter) must handle 401 Unauthorized responses by securely executing the refresh token flow before retrying the failed request.
- The backend must maintain a persistent PostgreSQL connection to validate refresh token hashes during the rotation flow.
