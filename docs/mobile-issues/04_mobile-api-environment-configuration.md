## Overview

Define how the mobile app resolves API endpoints across local development, staging, and production.

The web app currently assumes browser-based development and proxy behavior. The mobile shell will need a clearer environment strategy.

---

# Goals

1. Support local mobile development against the API
2. Support staging and production mobile builds
3. Avoid hard-coded environment assumptions in the mobile app

---

# Requirements

- Define API base URL strategy for:
  - local iOS simulator/device
  - local Android emulator/device
  - staging
  - production
- Ensure the Vue app can consume environment-aware API configuration when packaged in Capacitor
- Document developer setup for mobile API connectivity

---

# Implementation Notes

Areas likely involved:

- `cocktailchooser-frontend/src/api.js`
- frontend environment config
- Capacitor runtime config or build-time environment variables
- developer documentation in `README.md` or mobile docs

Key concerns:

- localhost differences between browser, simulator, and physical device
- secure transport / mixed content concerns
- keeping production endpoints separate from local developer defaults

---

# Acceptance Criteria

- Local API connectivity strategy is documented and implemented
- Staging/production API target strategy is documented
- Mobile builds do not depend on the existing browser dev proxy
- Developer setup steps are clear enough for another contributor to run the mobile app

---

# Labels

- Mobile
- Type: Architecture
- Type: Enhancement
- P1 - High

