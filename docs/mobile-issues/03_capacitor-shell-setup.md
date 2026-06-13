## Overview

Add Capacitor to the existing Vue frontend and create the initial native app shells for iOS and Android.

This is the first implementation issue after the architecture decision.

---

# Goals

1. Package the current frontend as an installable mobile app shell
2. Keep the Vue app as the primary UI
3. Prove the app can run inside native iOS and Android hosts

---

# Scope

## In Scope

- Add Capacitor dependencies to `cocktailchooser-frontend`
- Add base Capacitor configuration
- Create iOS host project
- Create Android host project
- Wire the built Vue app into native shells
- Verify app launches on both platforms

## Out of Scope

- Deep native feature integration
- Push notifications
- Offline mode
- Store submission polish

---

# Technical Notes

Expected implementation areas:

- `cocktailchooser-frontend/package.json`
- `cocktailchooser-frontend/capacitor.config.*`
- generated `ios/` host project
- generated `android/` host project
- build scripts for syncing web assets into native shells

---

# Acceptance Criteria

- Capacitor is installed and configured
- iOS host project exists
- Android host project exists
- The Vue app can be built and synced into both native shells
- Basic app launch works in simulator/emulator or equivalent local validation

---

# Labels

- Mobile
- Type: Architecture
- Type: Enhancement
- P1 - High

