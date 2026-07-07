# SEC-023: API Authentication & Mutual Trust

## 1. Objective
To guarantee that the Cloud Backend only accepts commands from legitimately registered LifeCircle OS physical devices, and devices only talk to the legitimate Cloud.

## 2. Authentication Strategy
LifeCircle OS rejects static API keys for client-to-server communication. 

### The Protocol (DPoP / Asymmetric Binding)
1. Devices register a Public Key generated in their Secure Enclave (`ADR-028`).
2. The Cloud issues a JWT access token.
3. Every sensitive API request must include the JWT **AND** a cryptographic signature over the payload + timestamp using the device's Private Key.
4. The backend verifies both the JWT validity and the signature against the registered Public Key.

## 3. Rate Limiting
All authenticated endpoints must be aggressively rate-limited per `FamilyId` to prevent denial-of-wallet or brute-force synchronization attacks.
