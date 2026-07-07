# ADR-029: Event Contract Versioning

## Context
When LifeCircle OS introduces new features, the JSON payload of sync events will change. Older app versions still installed on a grandmother's phone might crash if they receive an unknown event shape.

## Decision
We will use **Strict Payload Versioning with Forward-Compatible Ignorance**.

### The Rules
* Every event has an explicit `version` integer (e.g., `v: 1`).
* If a v1 client receives a v2 event, it must safely ignore the unknown fields rather than crashing during deserialization.
* If a breaking change is required, the Cloud Backend acts as an **Event Translator**, down-casting v2 events into v1 shapes before serving them to outdated devices.

## Consequences
* Eliminates the "forced update" anxiety for elderly users.
* Increases backend complexity, as the API must know the client version and translate payloads on the fly.
