# CocktailChooser Roadmap

Scope guard: This roadmap is for a smart tool for casual home bartenders. It prioritizes fast drink decisions, recipe clarity, and lightweight personalization. It excludes pro bartender workflows, POS, and inventory management.

## Phase 1 -- Core Decision Engine

**Outcome:** Users can quickly find a drink based on ingredients and get a clear, usable recipe.

- [ ] Define ingredient canonicalization strategy (#40)
- [ ] Normalize quantity storage (#38)
- [ ] Implement ingredient-first filtering / "I Feel Like Using..." (#42)
- [ ] Improve Surprise Me logic (#44)

---

## Phase 2 -- Personalization & Coverage

**Outcome:** The app feels more personal and useful across common home-bartender scenarios.

- [ ] Support non-alcoholic filtering (#43)
- [ ] Improve exclusion of recently logged drinks (repeat avoidance) (new / map existing issue)
- [ ] Improve user-added cocktail parsing (#37)
- [ ] Clarify and implement cocktail grouping only if it improves decisions (not taxonomy for its own sake) (#39)

---

## Phase 3 -- Polish

**Outcome:** The experience is easier to read, smoother to use, and more welcoming for casual users.

- [ ] Improve recipe quantity readability (Unicode quantity display) (#36)
- [ ] Remove UI deprecation warnings (#19)
- [ ] Replace/reshape "Novice Mode" into lightweight onboarding or better defaults, if still needed (#41)

---

## Phase 4 -- Mobile App

**Outcome:** CocktailChooser ships as an installable iPhone and Android app without splitting the product across multiple frontend codebases too early.

- [ ] Finalize wrapper-first mobile architecture decision (#102)
- [ ] Package the Vue app for iOS and Android via Capacitor (#101)
- [ ] Add mobile environment configuration for API targets
- [ ] Audit and improve core phone-sized flows: browse, My Bar, detail, logging, onboarding
- [ ] Define post-v1 criteria for deeper native features before considering a rewrite
