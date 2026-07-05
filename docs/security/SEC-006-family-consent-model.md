# SEC-006: Family Consent Model

The Family Consent Model dictates how data is shared between household members. It strictly prevents unauthorized monitoring and enforces Least Privilege.

## 1. Explicit Invitations
A user must explicitly invite another user to their "Household". The invitee must explicitly accept.

## 2. Granular Delegation
Consent is not all-or-nothing. 
When a parent delegates a responsibility (e.g., "Pay Electricity Bill") to a child, the child *only* gains visibility into that specific task, not the parent's entire financial history or health records.

## 3. The Elder Care Exception
An adult child cannot unilaterally access an aging parent's health records. The parent (or their legally authorized representative) must explicitly grant a "Caregiver" role.

## 4. Revocation
Consent can be revoked instantly at any time. Revocation triggers a hard sync that purges the delegated data from the former caregiver's local Isar database.
