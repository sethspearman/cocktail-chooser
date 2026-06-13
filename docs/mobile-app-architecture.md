# Mobile App Architecture Decision

This document closes the decision requested by issue `#102` and defines the first delivery path for issue `#101`.

## Decision

Ship the first mobile app as a **Capacitor-based wrapper around the existing Vue app and .NET API**, then evolve targeted mobile-native features inside that shell as needed.

This means:

- Keep the current backend/API as the system of record
- Keep the current Vue frontend as the primary UI codebase for v1 mobile
- Package the web app for iOS and Android using a native shell
- Add mobile-specific polish inside the existing frontend before considering a larger rewrite

## Why This Is The Best Starting Point

For this repo today, the main constraint is not backend reuse. That part is already strong. The main constraint is **frontend reuse and delivery speed**.

Current repo state:

- API and data layer are already in `.NET 8`
- The web client is a real `Vue 3` application in `cocktailchooser-frontend`
- The existing `CocktailChooser.Maui` project is still a stock prototype and does not reuse the Vue UI

Because of that, wrapping the current app is the fastest path to:

- working iPhone and Android builds
- highest feature parity
- lowest rewrite risk
- the ability to learn from real mobile usage before committing to a full re-platform

## Options Evaluated

### 1. PWA / WebView wrapper

Pros:

- Highest reuse of the current product
- Fastest route to App Store / Play Store candidates
- Lowest implementation risk for issue `#101`
- Keeps one main frontend codebase during the first mobile release

Cons:

- Mobile UX still depends on web UI quality
- Some device integrations will be less ergonomic than a full native app
- Performance ceiling is lower than a purpose-built native UI

### 2. React Native

Pros:

- Strong mobile ecosystem
- Better long-term access to native patterns and device capabilities

Cons:

- Current Vue UI is not reusable
- Requires a second major frontend codebase
- Slower path to feature parity

### 3. Flutter

Pros:

- Good cross-platform performance
- Strong UI control

Cons:

- Full UI rewrite
- New language and framework for the team
- Lowest reuse of current frontend investment

### 4. Native iOS + Android

Pros:

- Best platform fidelity
- Best access to device capabilities

Cons:

- Highest cost
- Slowest delivery
- Two mobile codebases plus the existing web app

### 5. Existing MAUI prototype in this repo

Pros:

- Reuses .NET team familiarity
- Existing project already exists

Cons:

- Does not reuse the current Vue frontend
- Current MAUI app is only template-level, so it does not materially reduce rewrite cost
- Would still create another UI stack to maintain

## Final Recommendation

Use **Capacitor wrapper first** for v1 mobile.

Revisit a larger rewrite only if one of these becomes true:

- mobile usage materially outgrows the responsive web model
- performance becomes a real user problem
- offline, heavy background processing, or deeper native integrations become a near-term priority
- the team intentionally decides to consolidate on a different client stack

## High-Level Architecture

```text
 iOS App (Capacitor)      Android App (Capacitor)
          |                         |
          +----------- Vue Mobile Shell -----------+
                              |
                        Shared Web UI
                    (cocktailchooser-frontend)
                              |
                          HTTP / JSON
                              |
                      CocktailChooser.API
                              |
                     CocktailChooser.Data
                              |
                            SQLite
```

## Delivery Phases

### Phase 0: Mobile readiness in the current web app

- Audit layouts for narrow screens
- Improve tap targets, spacing, and sticky actions
- Verify auth, My Bar, filtering, cocktail detail, and logging flows on phone-sized viewports
- Remove desktop-only assumptions from the current UI

### Phase 1: Native shell packaging

- Add Capacitor to `cocktailchooser-frontend`
- Create iOS and Android host projects
- Configure API base URL strategy for local, staging, and production
- Validate app icon, splash screen, orientation, safe areas, and deep-link behavior

### Phase 2: Mobile-specific enhancements

- Native keyboard and scroll polish
- Share sheet / open-in-app support where useful
- Camera or image upload features if needed later
- Notification and offline planning after the v1 app is stable

## Near-Term Repo Work

The next implementation tasks should be:

1. Add Capacitor to the frontend project
2. Define mobile environment configuration for API endpoints
3. Create a mobile QA checklist for the existing core flows
4. Tackle the highest-friction phone UX issues in the Vue app

## Explicit Non-Goals For V1

- Full native rewrite
- Offline-first architecture
- Push notifications
- Background sync
- Separate mobile-only business logic layer

## Impact On Existing MAUI Project

`CocktailChooser.Maui` should be treated as an exploratory prototype, not the active delivery path for issue `#101`.

We can keep it in the repo for now, but new mobile implementation work should target the Vue app plus native packaging flow unless the team makes a later architecture change.
