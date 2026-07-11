# Support Playbook

**Internal Document for Customer Success Representatives (CSRs)**

## Core Principles of Support
1. **Zero Trust Constraint:** You CANNOT see user data. You cannot see the contents of their responsibilities, their medical logs, or their emergency contacts. Do not ask for them.
2. **De-escalation First:** Families contacting us are likely stressed. Use calm, deterministic language. Do not use overly cheerful or casual slang.
3. **Never Ask for PII:** Do not ask for names, addresses, or medical conditions. Ask for the unique `DeviceID` or `HouseholdUUID` if diagnosing a sync issue.

## Scenario: "My app isn't syncing"
1. Ask the user to verify their device has network connectivity.
2. Ask the user to check the "Sync Queue" indicator on the Settings page.
3. If the queue is stuck, instruct the user to tap "Force Sync".
4. If it fails, escalate to Tier 2 Engineering with the `DeviceID`. Do NOT ask them to log out (this wipes their local, unsynced data).

## Scenario: "I lost my Passkey/Device"
1. Inform the user that LifeCircle OS does not use traditional passwords.
2. Instruct them to download the app on their new device.
3. They must ask another active Family Administrator in their household to generate a new Invite Code for them to rejoin the household. (Account recovery is social, not centralized).

## SLA Targets
- Initial Response Time: < 2 hours.
- Resolution Time: < 24 hours.
