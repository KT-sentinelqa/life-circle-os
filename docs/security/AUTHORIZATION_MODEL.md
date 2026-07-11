# Canonical Authorization Model
**Status:** Locked | **Scope:** Global | **Review Board:** ARB

## Philosophy
LifeCircle OS does not implement generic enterprise Role-Based Access Control (RBAC). The authorization model is fundamentally **Family-Centric**, mirroring real-world relational dynamics, caregiving boundaries, and medical delegation.

---

## 1. Actors
An **Actor** is any authenticated entity operating within the system.
- **Human Actor:** A user logged into the application.
- **System Actor:** A background sync daemon, push notification orchestrator, or telemetry service.
- **Medical Delegate:** A temporary or restricted actor (e.g., a visiting nurse).

---

## 2. Roles
Roles are strictly scoped to a `FamilyId`. An actor may hold different roles in different families (e.g., `Family Owner` in their own family, but `Emergency Delegate` in their parents' family).

| Role | Definition | Max per Family |
|---|---|---|
| **Family Owner** | The cryptographic and legal owner of the family data vault. Can delete the family and revoke any access. | 1 |
| **Parent / Administrator** | Full read/write access to all family operations, scheduling, and medical records. Cannot delete the family vault. | Unlimited |
| **Adult Member** | Can view general family schedules and manage their own responsibilities. Cannot view private medical records of others unless explicitly delegated. | Unlimited |
| **Child** | Restricted view. Can see their own tasks and general family events. Blocked from viewing financial/medical escalations (SEC-016 Contextual Privacy). | Unlimited |
| **Caregiver** | External or internal member with explicit Read/Write access to specific medical entities (e.g., Medicine Logs, Prescriptions) for specific members. | Unlimited |
| **Emergency Delegate** | Dormant role. Has ZERO access until an explicit "Break Glass" event is triggered, at which point they gain Caregiver + Administrator privileges. | 3 |
| **Read-Only Delegate** | Can view non-sensitive schedules (e.g., "Is Dad taking his medicine?") but cannot modify records or view financial context. | Unlimited |

---

## 3. Resource Boundaries & Ownership
All data belongs to the **Family Vault** (`FamilyId`), not the individual user. 
- **Vault Ownership:** Cryptographically tied to the Family Owner.
- **Entity Ownership:** Within the vault, individual entities (e.g., `Responsibility`, `Medicine`) have a `primaryOwnerId`.
- **Partitioning:** Sync engines strictly partition data by `FamilyId`. A user token *cannot* retrieve data for a `FamilyId` where the user lacks an active role.

---

## 4. Permission Matrix
This matrix acts as the canonical source of truth for all authorization policies.

| Resource | Owner | Parent | Adult | Child | Caregiver | Emergency Delegate | Read-Only Delegate |
|---|---|---|---|---|---|---|---|
| **Family Settings** | ✔ Full | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| **Member Invites** | ✔ | ✔ | ✖ | ✖ | ✖ | ✖ | ✖ |
| **Medicines** | ✔ | ✔ | ✔ | View | ✔ | Emergency Only | View |
| **Responsibilities** | ✔ | ✔ | ✔ | Assigned Only | View | ✖ | View |
| **Emergency Contacts** | ✔ | ✔ | View | ✖ | ✔ | ✔ | View |
| **Financial Data** | ✔ | Optional | ✖ | ✖ | ✖ | Emergency Only | ✖ |
| **Medical Logs** | ✔ | ✔ | Own Only | Own Only | Assigned Only | Emergency Only | View |

---

## 5. Permissions (The ACL)
Permissions are implicit based on Roles and Ownership, evaluated at the repository layer.

- `read:family:global` (Parents, Owners)
- `read:family:restricted` (Adults, Children)
- `write:responsibility:own` (All)
- `write:responsibility:any` (Parents, Owners)
- `read:medical:own` (All)
- `read:medical:delegated` (Caregivers, Parents, Owners)

---

## 5. Family-Scoped Access
A user's JWT or Session Object must embed the `FamilyId` and `Role` as claims. 
When navigating the app, the Authorization Engine evaluates:
`assert(currentUser.activeFamilyId == resource.familyId)`
If the actor switches families (e.g., looking at their parents' dashboard), the context entirely resets.

---

## 6. Emergency Override Rules ("Break Glass")
1. **Trigger:** The Family Owner or Parent triggers a medical emergency, OR a trusted heartbeat monitor fails for 24 hours.
2. **Elevation:** All users holding the `Emergency Delegate` role are instantly elevated to `Administrator` + `Caregiver` permissions.
3. **Notification:** All adult members are immediately notified via immutable out-of-band channels (SMS/Push) that the glass was broken.
4. **Revocation:** The Family Owner can manually revoke the emergency state, reverting delegates to dormant status.

---

## 7. Audit Requirements
Every authorization failure and every sensitive authorization success (e.g., Medical Read, Break Glass) must be logged to a durable, append-only `AuditLog`.
- **Required fields:** `timestamp`, `actorId`, `actorRole`, `targetResource`, `targetAction`, `granted`, `reason`
- Audit logs cannot be deleted, even by the Family Owner, ensuring cryptographic repudiation protection.
