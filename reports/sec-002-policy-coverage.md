# SEC-002 Policy Coverage Report

**Status:** Completed
**Scope:** Family-Centric Authorization Engine
**Date:** 2026-07-11

## 1. Roles Implemented
The canonical Family-Centric roles have been successfully modeled in `FamilyRole`:
- Owner
- Parent
- Adult
- Child
- Caregiver
- Emergency Delegate
- Read-Only Delegate

*(Enterprise RBAC logic has been correctly excluded).*

## 2. Permissions Implemented
Actions map to `PermissionAction`:
- `read`
- `write`

Responses map to `AuthorizationDecisionStatus`:
- `allow`
- `allowWithAudit`
- `allowTemporarily`
- `deny`
- `denyDeviceUntrusted`
- `denySessionExpired`
- `denyPermission`
- `denyBreakGlassRequired`

## 3. Policies Implemented
The `PolicyEngine` enforces the exact matrix defined in `AUTHORIZATION_MODEL.md`. All bounded contexts are now enforced:
- Family Settings
- Member Invites
- Medicines
- Responsibilities
- Emergency Contacts
- Financial Data
- Medical Logs

## 4. Decision Paths Tested
`test/unit/authorization/policy_engine_test.dart` achieves critical path coverage, including:
- Owner edits medicine (PASS)
- Parent edits child medicine (PASS)
- Child edits owner medicine (FAIL)
- Caregiver edits finance (FAIL)
- Emergency delegate accesses emergency contacts (PASS)
- Untrusted device (FAIL)
- Expired session (FAIL)
- Adult assigns responsibility (PASS)
- Child edits own responsibility (PASS)
- Child edits other responsibility (FAIL)
- Parent edits financial data (PASS)
- Emergency Break Glass elevations (FAIL when not active, PASS with Audit when active).

## 5. Untested / Future Policies
- **Cross-Family Context Switching**: The engine does not yet prevent a valid token from accessing another family if the backend allows it. This must be solved in the Backend/Sync layers (`assert(activeFamilyId == resource.familyId)`).
- **Time-bound Caregiver Grants**: Temporary delegation expiry logic is not yet modeled in the `AuthorizationContext` (pending feature implementation).
- **Audit Interceptor**: While `allowWithAudit` is returned, the actual interception to write to an immutable audit log is pending SEC-006 (Sync/Backend integration).
