# SEC-007: Data Retention Policy

## 1. On-Device Retention
By default, historical data (e.g., completed household duties, past medicine logs) is retained locally indefinitely unless storage constraints require pruning, at which point data older than 1 year is purged.

## 2. Cloud Retention (If Opted-In)
Cloud servers operate as a synchronized reflection of the local database. 

## 3. Right to Delete
Users may request full account deletion via the application.
1. Local databases are wiped immediately.
2. An event is dispatched to the cloud infrastructure to hard-delete all associated records.
3. Automated cloud backups age out and are overwritten within 30 days, resulting in permanent eradication.

## 4. Tombstone Mechanism
Deleted records are replaced with a cryptographic tombstone to ensure synchronization nodes recognize the deletion without exposing the original data.
