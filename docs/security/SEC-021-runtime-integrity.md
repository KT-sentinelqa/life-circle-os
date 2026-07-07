# SEC-021: Runtime Integrity & Anti-Tampering

## 1. Objective
To comply with MASVS-RESILIENCE by ensuring the application runs in a trusted environment and has not been maliciously modified.

## 2. Root & Jailbreak Detection
Upon `main()` execution, LifeCircle OS will perform environmental checks (e.g., using `freerasp` or similar enterprise-grade RASP tools).
* If a rooted (Android) or jailbroken (iOS) environment is detected, the application **must refuse to decrypt the Isar database**.
* The user is shown a hard-stop screen explaining that the trust infrastructure cannot operate in compromised environments.

## 3. Application Hooking Detection
The app must detect if frameworks like Frida or Xposed are attached to the runtime process. If hooking is detected, execution halts immediately to protect cryptographic keys in memory.
