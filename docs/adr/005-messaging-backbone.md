# ADR-005: Messaging Backbone Selection

## Status
Accepted

## Context
Life Circle OS employs an event-driven architecture to enforce strict isolation between bounded contexts. A messaging backbone is required to facilitate asynchronous communication, outbox pattern implementations, and reliable event routing between backend services. Previous design discussions considered Redis Streams and Kafka, but a definitive standard is needed to prevent architectural ambiguity and drift.

## Decision
We will use **RabbitMQ** as the canonical messaging backbone for Life Circle OS.

## Rationale
1. **Routing Flexibility:** RabbitMQ's exchange and routing key model provides superior flexibility for our domain event distribution compared to Redis Streams.
2. **Operational Simplicity:** While Kafka offers extremely high throughput and log replay, RabbitMQ is significantly easier to operate, host, and monitor at our current scale, aligning better with our early-phase platform engineering constraints.
3. **Reliability:** Built-in support for dead-letter queues, message acknowledgments, and durable queues natively fulfills our reliability and transactional outbox requirements.

## Consequences
- All cross-boundary asynchronous events must be published to RabbitMQ.
- The Platform Engineering team is responsible for managing the RabbitMQ infrastructure, including High Availability (HA) configurations.
- Engineering teams must implement appropriate retry and fallback logic assuming at-least-once delivery semantics.
- Redis will be strictly reserved for caching and ephemeral state management, not for message queuing or event routing.
