## Overview

Finalize the architecture decision for the Cocktail Chooser mobile app.

The repo already has:

- a working `.NET 8` API and data layer
- an active `Vue 3` frontend
- an exploratory `MAUI` prototype that does not reuse the current Vue UI

This issue should record the final decision and align the team on the first mobile delivery path.

---

# Options Evaluated

1. WebView / PWA wrapper
2. React Native
3. Flutter
4. Native (Swift + Kotlin)
5. Continue with the existing MAUI prototype

---

# Final Decision

Choose **Capacitor wrapper around the existing Vue app** for v1 mobile delivery.

This means:

- Keep the current Vue frontend as the primary UI codebase
- Package the app for iOS and Android using a native shell
- Keep the existing `.NET API` as the system of record
- Delay any large client rewrite until real mobile constraints justify it

---

# Evaluation Criteria

- Code reuse from the existing app
- Development speed
- Delivery risk
- Maintainability
- Access to device features
- Long-term flexibility

---

# Rationale

Capacitor is the best fit for the current repo because:

- the current Vue frontend is a real product asset
- the current MAUI app is only a shell/prototype
- a wrapper-first approach gets to installable apps faster
- the team can learn from real user behavior before committing to a rewrite

Tradeoffs:

- mobile UX quality still depends on improving the current web UI
- some future native features may require plugins or a later architecture shift
- performance ceiling is lower than a fully native or purpose-built cross-platform client

---

# Deliverables

- Documented decision
- Rationale for chosen approach
- High-level architecture diagram
- Decision added to repo docs

---

# Acceptance Criteria

- Architecture decision is finalized
- Tradeoffs are clearly documented
- Team aligned on direction
- Existing MAUI prototype is explicitly marked as non-primary
- Follow-on implementation issues are defined

---

# Labels

- Mobile
- Type: Architecture
- P1 - High

