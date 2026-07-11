# Troubleshooting Guide

Before contacting support, please check these common scenarios.

### Issue: The Peace Index is not updating.
- **Cause:** The Peace Index is calculated locally on your device. If you are offline, it will update based on your local actions. It will sync the score to others once you are online.
- **Solution:** Verify your network connection if you expect to see someone else's updates.

### Issue: A responsibility disappeared.
- **Cause:** LifeCircle OS uses a "Conflict-Free Replicated Data Type" (CRDT) engine for offline syncing. If another family member deleted the responsibility on their device while you were offline, their deletion will take precedence when you reconnect.
- **Solution:** Check with your family members to see if they resolved or deleted the item.

### Issue: I am locked out of the app.
- **Cause:** For your security, the app locks automatically after 15 minutes of inactivity (per SEC-026).
- **Solution:** Use your device's biometrics (FaceID/Fingerprint) to unlock. If biometrics fail repeatedly, you will be prompted for your Passkey fallback.

### Issue: "Sync Queue" indicator is red.
- **Cause:** Your device cannot reach the secure cloud servers, or the backend is experiencing temporary maintenance.
- **Solution:** Do nothing. The app is offline-first. Continue using the app normally. It will silently and automatically retry syncing in the background until successful. Do NOT log out.
