# ADR-028: Device Registration

## Context
We must ensure that only authorized physical hardware can connect to the Cloud Trust Platform.

## Decision
We will implement an **Asymmetric Device Binding Protocol**.

### The Flow
1. Upon login, the device generates an RSA/EC keypair in its Secure Enclave.
2. The device sends the **Public Key** to the Cloud, registering a `DeviceId`.
3. The Cloud issues a temporary JWT session.
4. For all future sensitive API calls (e.g., retrieving the Sync Inbox), the device must sign the request payload with its Private Key.
5. The Cloud verifies the signature using the stored Public Key.

## Consequences
* Passwords or stolen JWTs are insufficient to steal data. An attacker must possess the physical device (or exploit the Secure Enclave) to mimic a valid sync client.
* Integrates perfectly with `SEC-019` (Remote Wipe): The Cloud simply deletes the Public Key to revoke a stolen device's access permanently.
