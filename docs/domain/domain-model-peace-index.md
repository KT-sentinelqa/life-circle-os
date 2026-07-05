# Domain Model: Peace Index

## Entity: `FamilyPeaceIndex`

This entity is a materialized view of the household's current state, designed to be instantly queryable without heavy computation on the UI thread.

### Schema Definition

```dart
@collection
class FamilyPeaceIndex {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String householdId;

  // The master score (0-100).
  late int overallScore;

  // Breakdown by category (allows granular UI indicators).
  late int healthScore;
  late int financeScore;
  late int householdScore;

  // The timestamp of the last computation.
  late DateTime lastCalculatedAt;
}
```

## Computation Rules (The Math of Anxiety)
The index is not a simple average. It uses a **Weighted Penalty System**.
* **Base Score**: 100
* **Penalty**: If a `HEALTH` responsibility escalates, it penalizes the overall score by 20 points.
* **Penalty**: If a `FINANCE` responsibility escalates, it penalizes by 10 points.
* **Recovery**: A resolved escalation restores the score, but introduces a 24-hour "cooling off" period where the score maxes at 95, reflecting residual anxiety.
