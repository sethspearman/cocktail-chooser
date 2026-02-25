# Backlog Triage (Current `issues.json`)

Purpose: apply the scope guard and keep the backlog focused on the casual home bartender decision loop.

Legend:
- `Core`: directly improves the decision loop
- `Neutral`: useful, but not central to decision-making
- `Scope-Risk`: likely to add complexity or drift unless reframed

## Triage Summary

### Core (Prioritize)

- `#45` Define Product Persona & Scope Boundaries
  - Why: Sets the guardrails that prevent scope creep across the backlog.
  - Status note: docs alignment is mostly done; remaining work is governance/triage adoption.

- `#44` Improve "Surprise Me" & Decision Flow
  - Why: Directly improves fast decision-making and repeat avoidance.
  - Suggested scope: repeat-exclusion first, weighting later.

- `#43` Support Non-Alcoholic Cocktails & Filtering
  - Why: Expands useful choices for real-world home use while preserving the same decision flow.
  - Dependency: ingredient filtering should remain compatible.

- `#40` Ingredient Canonicalization & Matching Strategy
  - Why: Core reliability for ingredient filtering and future substitutions.
  - Risk to avoid: over-modeling too early (brands/strict hierarchies before practical rules).

- `#38` Amount Handling Strategy
  - Why: Recipe clarity is part of the core loop.
  - Suggested scope: data model + display consistency, not advanced scaling yet.

## Neutral (Do if Time / Bundle with Related Work)

- `#46` Cosmetic Changes web page tab.
  - Why: UX polish, but not core decision logic.
  - Note: tab icon/title work has been implemented locally.

- `#19` Error warning being shown in UI console...
  - Why: Technical cleanup. Good hygiene, but not user-facing core flow unless causing breakage.

- `#37` Add your own cocktails part 2.
  - Why: Useful for expansion, but not required for the core choose-a-drink loop.
  - Scope note: keep parser improvements incremental.

## Scope-Risk (Reframe Before Prioritizing)

- `#41` Add a Novice Mode...tooltips/training/tools
  - Risk: creates a parallel UX mode and broad educational scope.
  - Reframe recommendation:
    - on-demand tooltips for a few confusing terms
    - better defaults/labels
    - small contextual help text
  - Avoid: long-form training content and "mixology tools" as a separate product direction.

- `#39` Cocktail Grouping Strategy
  - Risk: can become a taxonomy/organization system instead of a decision tool.
  - Reframe recommendation:
    - start with simple user lists (Favorites / Party List)
    - avoid complex cross-source taxonomy and advanced grouping logic initially
  - Keep out of MVP core unless it clearly improves decision speed.

- `#36` Change amount display from decimal points to ascii 3/4 1/2 etc.
  - Risk: UX polish can expand into full amount formatting/parsing redesign.
  - Reframe recommendation:
    - treat as a follow-on UX task under `#38`
    - implement only display formatting for common fractions first

## Suggested Execution Order (Current Backlog)

1. `#45` (strategy guardrails + triage policy)
2. `#40` (ingredient matching reliability)
3. `#44` (repeat avoidance / surprise flow)
4. `#43` (non-alcoholic filter)
5. `#38` (amount handling strategy)
6. `#19` (warning cleanup, if noisy)
7. `#46` (done locally; close/verify)
8. `#37` (parser improvements)
9. `#36` (as a scoped follow-on to `#38`)
10. `#39` (reframed small lists/favorites first)
11. `#41` (only as narrow UX help, not a separate mode)

## Issue Reframing Notes (Ready to Copy into GitHub)

### `#41` Novice Mode

Proposed rewrite:
- Replace "Novice Mode" with lightweight onboarding/help improvements.
- Add optional tooltips for a small set of terms where confusion is common.
- Improve labels/defaults first.
- Defer long-form training content and broader mixology tools.

### `#39` Cocktail Grouping

Proposed rewrite:
- Start with simple user-created lists (Favorites, Party List, Themed List).
- Optimize for quick save/filter, not full taxonomy.
- Defer complex cross-source linking UI and advanced grouping behavior.

### `#36` Amount Display

Proposed rewrite:
- Implement display formatting for common fractions while preserving stored values.
- Keep parsing/storage changes tracked under `#38`.
- Do not expand into a full amount-system redesign in this issue.
