# SEC-016: Peace Index Privacy Model

## 1. Objective
To prevent the `FamilyPeaceIndex` from inadvertently violating the Least Privilege principle. An aggregated score could mathematically expose information the user is not authorized to see.

## 2. The Threat of Inferred Disclosure
If a child has a `healthScore` of 100, but their overall `FamilyPeaceIndex` drops to 60 due to a parent's missed EMI payment, the child has inferred financial distress even without seeing the raw financial data. This violates the trust infrastructure.

## 3. Contextual Aggregation (The Rule)
The `FamilyPeaceIndex` is **not a global absolute**. It is contextually generated based *only* on the responsibilities the current `actorId` is authorized to view.

### Scenario:
* **Parent View**: Sees a score of 60 (aware of both Health and Finance escalations).
* **Child View**: Sees a score of 100 (only sees their assigned Household tasks, which are fine).

## 4. Implementation Requirement
The `peaceIndexProvider` (defined in ADR-022) must accept the current user's UUID and filter the `FamilyResponsibility` stream through the `SEC-006-family-consent-model` *before* applying the mathematical penalties.

## 5. Exemption
Caregivers (e.g., an NRI daughter monitoring elderly parents) will see an accurate index reflecting their parents' health responsibilities, as they hold explicit delegated authority.
