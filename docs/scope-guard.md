# CocktailChooser Scope Guard

Purpose: keep CocktailChooser focused on being a smart tool for casual home bartenders.

## Product Identity

CocktailChooser helps casual home bartenders decide what to drink quickly.

It prioritizes:
- Fast decisions
- Ingredient-first discovery
- Clear recipes
- Lightweight personalization (history, My Bar checklist)

## Target User

Primary user:
- Casual home bartender
- Mixes drinks occasionally
- Wants help choosing, not studying
- Thinks in ingredients more than cocktail taxonomy

Typical questions:
- "What can I make with what I have?"
- "Give me something different from last time."
- "Show me something with rum and lime."

## Explicit Non-Goals (For MVP / Current Product)

We are not building:
- Professional bartender workflows
- POS integrations
- Bar inventory management software
- Deep educational/training product
- Social network features

Note:
- `My Bar` is a lightweight checklist used to improve recommendations.
- It is not a stock-counting or purchasing system.

## Core Experience Loop (What Must Stay Strong)

1. Open app
2. Filter/browse or use "What Can I Drink"
3. Pick a cocktail (or "Surprise Me")
4. View/print recipe
5. Optionally log it
6. Get better decisions next time

If a feature makes this loop slower, noisier, or more complex, it should be questioned.

## Feature Decision Rubric

Use this before accepting or prioritizing a feature.

### Ship Soon (Strong Fit)

A feature is a strong fit if it:
- Helps users choose faster
- Improves ingredient-based discovery
- Improves recipe clarity or usability
- Improves lightweight personalization (avoid repeats, recommendations)
- Reduces confusion for first-time visitors

### Reframe First (Possible Fit, Wrong Shape)

A feature may fit, but should be simplified if it:
- Introduces a new "mode" instead of improving defaults
- Adds advanced terminology or taxonomy the target user will not use
- Adds management/admin complexity to solve a simple decision problem
- Expands scope when a smaller UX tweak would solve the same problem

Examples:
- "Novice Mode" -> better labels, tooltips on demand, onboarding hints
- "Inventory management" -> keep a simple My Bar checklist

### Defer / Reject (Scope Risk)

A feature is likely out of scope if it:
- Primarily serves pro bartenders
- Requires POS/operations/inventory workflows
- Optimizes for catalog completeness over decision speed
- Adds complex configuration without improving the core loop

## Decision Questions for Issues / PRs

Ask:
1. Does this help a casual home bartender decide what to drink faster?
2. Does it improve the core loop more than it increases UI complexity?
3. Could this be a smaller UX copy/defaults change instead?
4. Is this trying to make the app a pro tool, POS, or inventory system?
5. Is it MVP-critical, or can it wait until the core loop feels complete?

If answers are unclear, default to a smaller implementation.

## Suggested "Done" Criteria for Issue #45

Issue #45 can be considered complete when:
- Product identity and non-goals are documented (vision/overview/README/scope guard)
- Roadmap language aligns with the scope guard
- A feature decision rubric exists and is used for issue triage
- At least one backlog triage pass identifies scope-risk items and reframes
