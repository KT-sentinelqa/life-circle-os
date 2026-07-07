# SEC-020: Dependency Governance (The Allow-List)

## 1. Objective
To prevent supply chain attacks and ensure no third-party package introduces invisible telemetry, analytics, or licensing violations into LifeCircle OS.

## 2. Governance Policy
LifeCircle OS operates on a strict **Default Deny** policy for third-party packages. Developers cannot arbitrarily add dependencies to `pubspec.yaml`.

## 3. The Allow-List Register
The following core packages are explicitly approved. Any addition to this list requires CISO sign-off:
* `flutter_riverpod` (State Management)
* `isar`, `isar_flutter_libs` (Offline Persistence)
* `uuid` (Identifier Generation)
* `freezed_annotation` (Immutability)
* `go_router` (Navigation)

## 4. The Block-List Register
The following categories of packages are permanently rejected:
* Proprietary Analytics SDKs (Mixpanel, Amplitude)
* Unverified third-party UI libraries
* Packages last updated > 18 months ago
