# Disaster Recovery Plan

## 1. Cloud Infrastructure (Sync Engine)
LifeCircle OS operates a thin cloud layer. The primary datastores (PostgreSQL) contain encrypted CRDT events. 
- **Backups:** Full encrypted snapshots are taken every 6 hours and stored in an isolated, multi-region AWS S3 bucket with Object Lock (immutable) enabled for 30 days to prevent ransomware deletion.
- **Recovery Time Objective (RTO):** 4 Hours.
- **Recovery Point Objective (RPO):** 6 Hours.

## 2. Client-Side Resilience (The Ultimate Backup)
The true resilience of LifeCircle OS lies in its offline-first architecture. If the entire cloud infrastructure is destroyed, the data is not lost. The data lives on the family's devices in their local Isar databases.
- Upon restoring a blank cloud infrastructure, devices will naturally re-sync their local state to the cloud, rapidly rebuilding the collective household state without intervention.

## 3. Key Management Infrastructure
The encrypted Fastlane Match repository (holding iOS provisioning profiles and signing certificates) is backed up offline on YubiKey-secured physical drives stored in a bank safety deposit box. Loss of these keys prevents us from publishing app updates.
