# Domain Model: Responsibility Engine

## Entity: `FamilyResponsibility`

This is the core entity stored in the local Isar database. It represents a recurring or one-off task (e.g., Medicine, Bill Payment) that carries a significant mental load.

### Schema Definition

```dart
@collection
class FamilyResponsibility {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid; // Unique identifier for cloud synchronization

  late String name; // e.g., "Dad's Evening BP Medicine"
  
  @Enumerated(EnumType.name)
  late ResponsibilityCategory category; // HEALTH, FINANCE, HOUSEHOLD, EVENT

  @Index()
  late String primaryOwnerId; // UUID of the family member primarily responsible

  @Index()
  String? backupOwnerId; // UUID of the fallback family member (triggers on escalation)

  @Enumerated(EnumType.name)
  late ResponsibilityStatus status; // PENDING, DUE_SOON, ESCALATED, COMPLETED, VERIFIED, SKIPPED

  late DateTime dueDate; // The strict deadline
  
  // Escalation Policy: Defines the SLA (in minutes) before the backupOwnerId is notified.
  // 0 means immediately upon missing the dueDate.
  int escalationDelayMinutes = 30; 

  // Trust Infrastructure: Proof of completion
  String? completionEvidenceUri; // Path to local photo or cryptographic signature

  // Gamification & Peace of Mind Metric
  int confidenceScore = 100; // Decreases on escalation, increases on verified completion

  late DateTime createdAt;
  late DateTime updatedAt;
}
```

## Immutable Invariants
1. `primaryOwnerId` cannot be the same as `backupOwnerId`.
2. A responsibility cannot transition to `COMPLETED` if `dueDate` is in the future (no premature completions for medicines).
3. Modifying the `escalationDelayMinutes` requires the consent of both the Primary and Backup owners if the category is `HEALTH`.
