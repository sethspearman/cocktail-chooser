# Issue #39 --- Cocktail Collections + Tag System (Facet Architecture)

Labels: P2 - Medium\
Scope: MVP\
Type: Core Feature\
Type: Architecture\
Type: UX

------------------------------------------------------------------------

# Overview

The Cocktail Chooser catalog is evolving from a simple recipe list into
a **cocktail discovery engine**.

To support richer discovery, filtering, and curation, the system will
introduce two major capabilities:

1.  **Collections** -- user or admin curated cocktail lists
2.  **Tag Facets** -- structured metadata used for filtering and
    discovery

This architecture allows cocktails to be organized and explored in
multiple ways.

Examples:

• Show **fizzy summer cocktails**\
• Show **spirit-forward stirred classics**\
• Show cocktails for **brunch**\
• Show **equal-parts cocktails**

This issue implements the **core architecture and seeded taxonomy**.

------------------------------------------------------------------------

# Key Design Principle

Separate **three different concepts**:

## Collections

Curated lists of cocktails.

Examples:

-   Favorites
-   Party Lists
-   Holiday Drinks
-   Summer Patio
-   Super Bowl Party

Collections are manually curated by users or admins.

------------------------------------------------------------------------

## Tag Facets

Structured attributes used for filtering and discovery.

Examples:

-   Flavor Profile
-   Texture
-   Mood
-   Occasion
-   Strength
-   Cocktail Family
-   Build Method
-   Build Pattern

These are seeded metadata values assigned to cocktails.

------------------------------------------------------------------------

## Cocktail Relationships (Future Phase)

Examples:

-   variations
-   ancestors
-   flavor journeys
-   ingredient-based similarities

This graph model is out of scope for this issue.

------------------------------------------------------------------------

# Database Schema

## TagTypes

## TagTypes

Id Name Description IsSeeded CreatedUtc

------------------------------------------------------------------------

## Tags

## Tags

Id TagTypeId Name NormalizedName CreatedUtc

------------------------------------------------------------------------

## CocktailTags

## CocktailTags

CocktailId TagId CreatedUtc

Many-to-many relationship.

------------------------------------------------------------------------

## Collections

## Collections

Id Name Description OwnerUserId IsSystemCollection CreatedUtc

------------------------------------------------------------------------

## CollectionCocktails

## CollectionCocktails

CollectionId CocktailId CreatedUtc

------------------------------------------------------------------------

# Seeded Tag Types

## Flavor Profile

-   floral
-   fruity
-   herbal
-   smoky
-   sour
-   sweet
-   spicy
-   bitter
-   refreshing
-   fizzy
-   citrusy
-   tropical
-   creamy
-   savory
-   warming
-   coffee/chocolate

------------------------------------------------------------------------

## Texture

-   silky
-   creamy
-   frothy
-   light
-   effervescent
-   thick
-   icy

------------------------------------------------------------------------

## Cocktail Family

-   buck
-   cobbler
-   collins
-   cooler
-   crusta
-   daisy
-   fizz
-   flip
-   highball
-   julep
-   lowball
-   mist
-   pousse-café
-   puff
-   rickey
-   sangaree
-   sling
-   smash
-   sour
-   swizzle
-   tall drink

------------------------------------------------------------------------

## Mood

-   celebratory
-   romantic
-   flirty
-   chill
-   cozy
-   adventurous
-   sophisticated
-   playful
-   poolside
-   brunchy
-   late-night
-   festive
-   contemplative
-   bold

------------------------------------------------------------------------

## Occasion

-   brunch
-   aperitif
-   dinner-party
-   date-night
-   holiday
-   patio
-   game-day
-   after-dinner
-   nightcap
-   party
-   summer
-   winter

------------------------------------------------------------------------

## Strength

-   low-abv
-   sessionable
-   medium
-   spirit-forward
-   high-octane

------------------------------------------------------------------------

## Build Method

-   stirred
-   shaken
-   built
-   blended
-   layered
-   swizzled
-   muddled
-   rolled
-   dry shake

------------------------------------------------------------------------

## Aesthetic

-   classic
-   elegant
-   colorful
-   layered
-   tiki
-   festive
-   minimal
-   dramatic
-   photogenic

------------------------------------------------------------------------

## Build Pattern

### Ratio Patterns

-   equal parts
-   2:1:1
-   3:2:1

### Structural Patterns

-   spirit + citrus + sweet
-   spirit-forward
-   split base
-   fortified wine forward

### Complexity Patterns

-   simple 2-ingredient
-   simple 3-ingredient
-   simple 4-ingredient
-   complex spec
-   tiki multi-ingredient

### Service Patterns

-   long drink
-   short drink
-   served up
-   over crushed ice
-   topped with soda
-   egg white / foam
-   hot cocktail
-   frozen cocktail

------------------------------------------------------------------------

# Admin Management UI

Create an Admin Tag Management screen.

Features:

Tag Type selector

Tag assignment panel with:

☑ Negroni\
☑ Boulevardier\
☐ Margarita\
☐ Mai Tai

Bulk actions:

-   Add Selected
-   Remove Selected

Filters:

-   Show assigned
-   Show unassigned

------------------------------------------------------------------------

# Filtering UI

Tags appear in the Advanced Filters panel.

Example:

Flavor Profile ☐ Bitter ☐ Citrus

Build Method ☐ Stirred ☐ Shaken

Build Pattern ☐ Equal Parts

Filters combine with existing filters.

------------------------------------------------------------------------

# Acceptance Criteria

-   TagTypes table created
-   Tags table created
-   CocktailTags join table created
-   Collections feature implemented
-   Seeded taxonomy inserted via migration
-   Admin UI for assigning tags implemented
-   Filtering supports tag-based queries
-   Cocktails can have multiple tags

------------------------------------------------------------------------

# Future Enhancements

Cocktail Relationships Flavor Journey graphs

Ingredient Substitution Engine

Flavor Recommendation Engine

Cocktail Discovery Mode

Example query:

"Show refreshing citrus cocktails for summer."
