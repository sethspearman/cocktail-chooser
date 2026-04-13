## Overview

Convert Cocktail Chooser from a web application into a mobile application for:

- iOS (iPhone)
- Android

The first release should deliver a mobile-first experience that:

- Preserves core functionality from the existing web app
- Improves usability on small screens
- Reuses the current Vue frontend and .NET API as much as possible
- Establishes a path for future mobile-native enhancements

---

# Goals

1. Deliver a functional mobile app for iOS and Android
2. Reuse the existing backend/API and current Vue UI for the first release
3. Maintain practical feature parity with the current web app
4. Improve UX for mobile usage patterns
5. Prepare for future enhancements such as notifications, camera flows, and offline support

---

# Scope

## In Scope

- Cocktail browsing and filtering
- Ingredient / My Bar management
- Cocktail detail view
- Logging drinks
- Authentication flows
- Onboarding experience
- Native app packaging for iOS and Android

## Out of Scope (Initial Version)

- Push notifications
- Offline mode
- Background sync
- Advanced analytics
- Full native rewrite

---

# Technical Direction

Architecture decision:

- Use a **Capacitor wrapper around the existing Vue application**
- Continue using the existing `.NET API` as the backend
- Improve the current frontend for narrow-screen/mobile usage before adding deeper native features

Why:

- Fastest path to working iOS and Android apps
- Highest code reuse for the current codebase
- Lowest rewrite risk
- Preserves one main frontend codebase during v1 mobile delivery

---

# Deliverables

- Working iOS app shell
- Working Android app shell
- Mobile-ready Vue frontend experience
- Build/deploy pipeline for mobile packages
- App store readiness assets and metadata checklist

---

# Child Issues / Workstreams

- Finalize architecture decision and document tradeoffs
- Add Capacitor to the frontend and create iOS/Android host projects
- Add mobile environment configuration for API targets
- Audit and improve core phone-sized UX flows
- Define build and release workflow for mobile packages

---

# Success Criteria

- App successfully runs on iOS and Android devices/emulators
- Core features are usable and intuitive on mobile
- No major regressions versus the web app
- The team can continue mobile delivery without splitting into a second full frontend rewrite

---

# Labels

- EPIC
- Mobile
- P1 - High

