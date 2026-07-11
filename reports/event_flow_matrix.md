# Event Flow Matrix (Phase 3B)

This matrix defines the strict routing topology of the LifeCircle OS Event-Driven Architecture.

| Domain Event | Publisher Domain | Route Interface | Active Subscribers |
| :--- | :--- | :--- | :--- |
| `MedicineAdded` | Medicines | `DomainEvent` | Outbox |
| `MedicineTaken` | Medicines | `TimelineRoutableEvent` | Timeline, Outbox |
| `MissedDoseRecorded` | Medicines | `TimelineRoutableEvent` | Timeline, Outbox, Reminder |
| `BillCreated` | Finance | `TimelineRoutableEvent` | Timeline, Outbox, Reminder |
| `BillPaid` | Finance | `TimelineRoutableEvent` | Timeline, Outbox |
| `InsuranceExpired` | Finance | `DomainEvent` | Outbox, Reminder |
| `DocumentUploaded` | Documents | `TimelineRoutableEvent` | Timeline, Outbox |
| `DocumentReplaced` | Documents | `TimelineRoutableEvent` | Timeline, Outbox |
| `DocumentExpired` | Documents | `DomainEvent` | Outbox, Reminder |
| `VehicleRegistered` | Vehicles | `TimelineRoutableEvent` | Timeline, Outbox |
| `ServiceRecorded` | Vehicles | `TimelineRoutableEvent` | Timeline, Outbox |
| `TrustedContactAdded` | Trust & Emergency | `TimelineRoutableEvent` | Timeline, Outbox |
| `EmergencyProfileActivated`| Trust & Emergency | `TimelineRoutableEvent` | Timeline, Outbox, Notification |

*Note: The `OutboxSubscriber` inherently catches EVERY event that implements `DomainEvent` to guarantee 100% offline sync capability.*
