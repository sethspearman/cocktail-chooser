<template>
  <div class="app-shell">
    <div class="top-nav-row">
      <div class="app-menu" :class="{ open: accountMenuOpen }">
        <button
          class="menu-trigger"
          type="button"
          aria-label="Open navigation menu"
          @click="toggleAccountMenu">
          <span class="hamburger-icon" aria-hidden="true">
            <span></span>
            <span></span>
            <span></span>
          </span>
          <span class="menu-trigger-text">Menu</span>
        </button>

        <div v-if="accountMenuOpen" class="app-menu-dropdown">
          <div class="menu-user-summary">
            <span class="user-icon">{{ currentUser ? currentUser.displayName.slice(0, 1).toUpperCase() : 'U' }}</span>
            <div>
              <strong>{{ currentUser ? currentUser.displayName : 'Guest' }}</strong>
              <div class="subtle">{{ currentUser ? 'Signed in' : 'Sign in or create an account to save My Bar' }}</div>
            </div>
          </div>
          <div class="menu-actions">
            <button type="button" class="menu-button" @click="openAccountModal(currentUser ? 'overview' : 'login')">
              {{ currentUser ? 'Account' : 'Log in / Create account' }}
            </button>
            <button v-if="isAdminUser" type="button" class="menu-button" @click="openAdminModal">Admin</button>
            <button type="button" class="menu-button" @click="openAddCocktailModal">Add a Cocktail</button>
            <button type="button" class="menu-button" @click="openMyBarModal">My Bar Checklist</button>
            <a v-if="developerContactAction" :href="developerContactAction.href" class="menu-button menu-link-button">
              {{ developerContactAction.label }}
            </a>
          </div>
        </div>
      </div>
    </div>

    <section class="info-bar">
      <div class="info-chip">
        <span class="label">You Can Make</span>
        <strong>{{ makeableCocktails.length }}</strong>
      </div>
      <div class="info-chip">
        <span class="label">Showing</span>
        <strong>{{ displayedCocktails.length }}</strong>
      </div>
      <div class="info-chip wide-chip">
        <span class="label">Last Tried</span>
        <strong>{{ lastTriedSummary }}</strong>
      </div>
      <div class="info-chip wide-chip">
        <span class="label">Try Adding</span>
        <strong>{{ nextIngredientRecommendationSummary }}</strong>
      </div>
    </section>

    <div class="my-bar-inline-hint">
      <span class="inline-hint-text">{{ myBarGuidanceMessage }}</span>
      <button type="button" class="inline-link-button" @click="openMyBarModal">
        {{ selectedUserId ? 'Update My Bar!' : 'Open My Bar!' }}
      </button>
      <button
        v-if="!selectedUserId"
        type="button"
        class="inline-link-button secondary-link"
        @click="openAccountModal('login')">
        Log in
      </button>
    </div>

    <header class="hero">
      <div class="hero-top">
        <div>
          <h1>Cocktail Chooser</h1>
          <p>Use My Bar to find what you can make, discover something new, and keep track of what you try.</p>
        </div>
      </div>
    </header>

    <p v-if="userSuccessMessage" class="success floating-message">{{ userSuccessMessage }}</p>

    <section v-if="isMyCocktailsRoute" class="grid">
      <article class="panel wide">
        <div class="panel-title">My Cocktails</div>
        <div class="toolbar">
          <input v-model.trim="myCocktailSearch" placeholder="Search my cocktails" />
          <select v-model="myCocktailStatusFilter">
            <option value="all">All statuses</option>
            <option value="approved">Approved</option>
            <option value="pending">Pending</option>
            <option value="rejected">Rejected</option>
          </select>
          <button type="button" class="menu-button" @click="navigateTo('/')">Back to Browse</button>
        </div>
        <p v-if="!selectedUserId" class="subtle">Log in to view your submitted cocktails.</p>
        <p v-else-if="!filteredMyCocktailsForPage.length" class="subtle">No cocktails match these filters.</p>
        <ul v-else class="match-list">
          <li v-for="cocktail in filteredMyCocktailsForPage" :key="`mine-page-${cocktail.id}`">
            <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
            <span class="pill" :class="moderationStatusClass(cocktail.moderationStatus)">
              {{ moderationStatusLabel(cocktail.moderationStatus) }}
            </span>
          </li>
        </ul>
      </article>
    </section>

    <section v-else class="grid">
      <article class="panel wide">
        <div class="toolbar">
          <button
            type="button"
            class="menu-button advanced-toggle-button"
            :title="advancedFiltersOpen ? 'Advanced Filters (Hide)' : 'Advanced Filters (Show)'"
            :aria-label="advancedFiltersOpen ? 'Hide Advanced Filters' : 'Show Advanced Filters'"
            @click="toggleAdvancedFilters">
            <span class="advanced-toggle-chevron" aria-hidden="true">{{ advancedFiltersOpen ? '❮❮' : '❯❯' }}</span>
            <svg class="advanced-toggle-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
              <path d="M3 5h18l-7 8v5l-4 2v-7L3 5z" />
            </svg>
          </button>
          <label class="toolbar-checkbox">
            <input v-model="onlyCocktailsICanMake" type="checkbox" />
            Only Cocktails I Can Make
          </label>
          <div class="search-input-wrap">
            <input v-model.trim="cocktailSearch" placeholder="Search cocktails" />
            <button
              v-if="cocktailSearch"
              type="button"
              class="search-clear-btn"
              aria-label="Clear cocktail search"
              @click="cocktailSearch = ''">
              ×
            </button>
          </div>
          <select v-model="selectedSpirit">
            <option value="">All spirits</option>
            <option v-for="spirit in spirits" :key="spirit" :value="spirit">{{ spirit }}</option>
          </select>
          <input
            v-model.trim="ingredientFilterSearch"
            list="cocktail-ingredient-filter-options"
            @change="addSelectedIngredientFilter"
            @keyup.enter.prevent="addSelectedIngredientFilter"
            placeholder="Find Ingredient..." />
          <button
            :disabled="cocktailListMode !== 'makeable' || filteredMakeableCocktails.length === 0"
            @click="pickRandomMakeableCocktail">
            Pick One for Me
          </button>
          <label class="toolbar-checkbox">
            <input v-model="popularOnly" type="checkbox" />
            Popular only
          </label>
          <label class="toolbar-checkbox">
            <input v-model="myDrinksOnly" type="checkbox" :disabled="!selectedUserId" />
            My drinks only
          </label>
          <datalist id="cocktail-ingredient-filter-options">
            <option
              v-for="ingredient in ingredientFilterOptions"
              :key="`filter-ing-${ingredient.id}`"
              :value="ingredient.name">
            </option>
          </datalist>
          <label class="toolbar-checkbox">
            <input v-model="showUntriedOnly" type="checkbox" :disabled="cocktailListMode !== 'makeable'" />
            Show Untried Only
          </label>
          <label class="toolbar-checkbox">
            <input v-model="virginOnly" type="checkbox" />
            Virgin drinks only
          </label>
        </div>
        <div v-if="selectedIngredientFilters.length" class="toolbar">
          <span class="subtle">Ingredient filter ({{ ingredientFilterMode === 'all' ? 'ALL' : 'ANY' }}):</span>
          <span v-for="ingredient in selectedIngredientFilters" :key="`selected-filter-${ingredient.id}`" class="pill">
            {{ ingredient.name }}
            <button type="button" class="inline-link-button secondary-link" @click="removeSelectedIngredientFilter(ingredient.id)">
              ×
            </button>
          </span>
          <button
            type="button"
            class="inline-link-button secondary-link"
            @click="clearSelectedIngredientFilters">
            Reset
          </button>
        </div>
        <div v-if="combinedCocktailListEmptyMessage" class="empty">{{ combinedCocktailListEmptyMessage }}</div>
        <ul v-else class="match-list">
          <li v-for="cocktail in displayedCocktails" :key="`match-${cocktail.id}`">
            <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
            <span v-if="isMyDrink(cocktail)" class="pill" :class="moderationStatusClass(cocktail.moderationStatus)">
              {{ moderationStatusLabel(cocktail.moderationStatus) }}
            </span>
            <span v-if="isPopularCocktail(cocktail)" class="pill">Popular</span>
            <span v-if="isVirginCocktail(cocktail.id)" class="virgin-pill">Virgin</span>
            <span v-if="cocktailListMode === 'all' && canMakeById(cocktail.id)" class="pill">Can make</span>
            <span v-if="hasTriedCocktail(cocktail.id)" class="tried-pill" title="Tried / logged">Tried</span>
          </li>
        </ul>
      </article>
    </section>

    <section class="panel detail" v-if="selectedCocktail">
      <div class="detail-header">
        <div class="panel-title">{{ selectedCocktail.name }}</div>
        <button type="button" class="menu-button" @click="openRecipeModal">Print</button>
      </div>
      <p class="subtle">Source: {{ sourceNameFor(selectedCocktail.cocktailSourceId) }}</p>
      <div v-if="selectedCocktail.tags && selectedCocktail.tags.length" class="tag-pill-row">
        <span v-for="tag in selectedCocktail.tags" :key="`detail-tag-${tag.id}`" class="pill">
          {{ tag.tagTypeName }}: {{ tag.name }}
        </span>
      </div>

      <div class="missing-panel">
        <strong>Missing Ingredients:</strong>
        <span v-if="missingIngredientsForSelected.length === 0" class="pill">You have everything</span>
        <ul v-else>
          <li v-for="ingredient in missingIngredientsForSelected" :key="`missing-${ingredient.id}`">
            {{ ingredient.name }}
          </li>
        </ul>
      </div>

      <div class="detail-grid">
        <div>
          <h3>Ingredients</h3>
          <ul>
            <li v-for="item in selectedCocktailIngredients" :key="`ing-${item.id}`">
              {{ item.ingredientName }}
              <span v-if="item.displayAmount || item.amountName || item.amountText" class="subtle">({{ displayAmount(item) }})</span>
            </li>
          </ul>

          <h3>Steps</h3>
          <ol>
            <li v-for="step in selectedCocktailSteps" :key="`step-${step.stepNumber}`">{{ step.instruction }}</li>
          </ol>
        </div>

        <div>
          <h3>Log This Cocktail</h3>
          <div class="log-form">
            <select v-model.number="newLog.rating">
              <option :value="null">No rating</option>
              <option v-for="n in [1,2,3,4,5]" :key="`r-${n}`" :value="n">{{ n }} / 5</option>
            </select>
            <input type="datetime-local" v-model="newLog.triedOnLocal" />
            <textarea v-model.trim="newLog.comment" placeholder="Comment"></textarea>
            <button :disabled="!selectedUserId" @click="submitTryLog">Save Log</button>
          </div>

          <h3>Recent Logs</h3>
          <ul>
            <li v-for="log in selectedCocktailLogs" :key="`log-${log.id}`">
              {{ formatDate(log.triedOnUtc) }}
              <span v-if="log.rating"> · {{ log.rating }}/5</span>
              <span v-if="log.comment"> · {{ log.comment }}</span>
            </li>
          </ul>
        </div>
      </div>
    </section>

    <p v-if="error" class="error">{{ error }}</p>

    <div v-if="advancedFiltersOpen && !isMyCocktailsRoute" class="advanced-filters-overlay" @click="closeAdvancedFilters"></div>
    <aside v-if="advancedFiltersOpen && !isMyCocktailsRoute" class="advanced-filters-drawer open" aria-label="Advanced Filters" @click.stop>
      <div class="advanced-filters-header">
        <button
          type="button"
          class="advanced-collapse-hitarea"
          title="Advanced Filters (Hide)"
          aria-label="Hide Advanced Filters"
          @click="closeAdvancedFilters">
          <span class="menu-button advanced-collapse-button" aria-hidden="true">❮❮</span>
          <strong>Advanced Filters</strong>
        </button>
        <div class="menu-actions advanced-header-actions">
          <button type="button" class="menu-button" @click="resetAllFilters">Reset All Filters</button>
        </div>
      </div>
      <div class="advanced-filters-body">
        <p class="subtle">Core advanced filters are now wired into the main display pipeline.</p>

        <div class="advanced-group">
          <div class="subheading">Main Filters</div>
          <div class="auth-stack">
            <div class="search-input-wrap advanced-ingredient-search">
              <input v-model.trim="cocktailSearch" placeholder="Search cocktails" />
              <button
                v-if="cocktailSearch"
                type="button"
                class="search-clear-btn"
                aria-label="Clear cocktail search"
                @click="cocktailSearch = ''">
                ×
              </button>
            </div>
            <label class="toolbar-checkbox">
              <input v-model="onlyCocktailsICanMake" type="checkbox" />
              Only Cocktails I Can Make
            </label>
            <select v-model="selectedSpirit">
              <option value="">All spirits</option>
              <option v-for="spirit in spirits" :key="`adv-spirit-${spirit}`" :value="spirit">{{ spirit }}</option>
            </select>
            <label class="toolbar-checkbox">
              <input v-model="virginOnly" type="checkbox" />
              Virgin drinks only
            </label>
            <label class="toolbar-checkbox">
              <input v-model="popularOnly" type="checkbox" />
              Popular only
            </label>
            <label class="toolbar-checkbox">
              <input v-model="showUntriedOnly" type="checkbox" :disabled="filterState.mode !== 'CAN_MAKE'" />
              Show Untried Only
            </label>
            <label class="toolbar-checkbox">
              <input v-model="myDrinksOnly" type="checkbox" :disabled="!selectedUserId" />
              My drinks only
            </label>
          </div>
        </div>

        <div class="advanced-group">
          <div class="subheading">My</div>
          <label class="toolbar-checkbox">
            <input v-model="filterState.mySubmissionsOnly" type="checkbox" />
            My drinks only
          </label>
          <label class="toolbar-checkbox">
            <input v-model="filterState.myApprovedOnly" type="checkbox" disabled />
            My Approved (next slice)
          </label>
        </div>

        <div class="advanced-group">
          <div class="subheading">Cocktail Time Period</div>
          <div v-if="!timePeriodOptions.length" class="subtle">No time periods loaded.</div>
          <label v-for="timePeriod in timePeriodOptions" :key="`adv-time-${timePeriod.id}`" class="toolbar-checkbox">
            <input
              :checked="filterState.selectedTimePeriodIds.includes(timePeriod.id)"
              type="checkbox"
              @change="toggleAdvancedTimePeriod(timePeriod.id)" />
            {{ timePeriod.name }}
          </label>
        </div>

        <div class="advanced-group">
          <div class="subheading">Source</div>
          <div v-if="!sources.length" class="subtle">No sources loaded.</div>
          <label v-for="source in sources" :key="`adv-source-${source.id}`" class="toolbar-checkbox">
            <input
              :checked="filterState.selectedSourceIds.includes(source.id)"
              type="checkbox"
              @change="toggleAdvancedSource(source.id)" />
            {{ source.name }}
          </label>
        </div>

        <div class="advanced-group">
          <div class="subheading">Tags</div>
          <select v-model="tagFilterMode" class="advanced-ingredient-mode-select">
            <option value="all">Tag filter mode: All selected tags</option>
            <option value="any">Tag filter mode: Any selected tag</option>
          </select>
          <p v-if="!advancedTagGroups.length" class="subtle">No tags loaded.</p>
          <div v-for="group in advancedTagGroups" :key="`tag-group-${group.id}`" class="advanced-tag-group">
            <strong>{{ group.name }}</strong>
            <label
              v-for="tag in group.tags"
              :key="`adv-tag-${tag.id}`"
              class="toolbar-checkbox">
              <input
                :checked="selectedTagNameSet.has(tag.normalizedName)"
                type="checkbox"
                @change="toggleAdvancedTag(tag.normalizedName)" />
              {{ tag.name }}
            </label>
          </div>
        </div>

        <div class="advanced-group">
          <div class="subheading">Ingredients</div>
          <select v-model="ingredientFilterMode" class="advanced-ingredient-mode-select">
            <option value="all">Ingredient filter mode: All selected ingredients</option>
            <option value="any">Ingredient filter mode: Any selected ingredient</option>
          </select>
          <div class="search-input-wrap advanced-ingredient-search">
            <input v-model.trim="advancedIngredientSearch" placeholder="Search ingredients" />
            <button
              v-if="advancedIngredientSearch"
              type="button"
              class="search-clear-btn"
              aria-label="Clear advanced ingredient search"
              @click="advancedIngredientSearch = ''">
              ×
            </button>
          </div>
          <p class="subtle">Selected ingredients stay pinned to top. Showing top {{ advancedIngredientPreviewCount }} more by default.</p>
          <label
            v-for="ingredient in advancedSelectedIngredientOptions"
            :key="`adv-selected-ing-${ingredient.id}`"
            class="toolbar-checkbox advanced-selected-ingredient">
            <input
              :checked="true"
              type="checkbox"
              @change="toggleAdvancedIngredient(ingredient.id)" />
            {{ ingredient.name }}
          </label>
          <div
            v-if="advancedSelectedIngredientOptions.length > 0 && advancedUnselectedIngredientOptions.length > 0"
            class="advanced-ingredient-divider">
            Other Ingredients
          </div>
          <label
            v-for="ingredient in advancedUnselectedIngredientOptions"
            :key="`adv-ing-${ingredient.id}`"
            class="toolbar-checkbox">
            <input
              :checked="false"
              type="checkbox"
              @change="toggleAdvancedIngredient(ingredient.id)" />
            {{ ingredient.name }}
          </label>
          <button
            v-if="!advancedIngredientsExpanded && advancedIngredientRemainderCount > 0"
            type="button"
            class="inline-link-button secondary-link advanced-ingredient-expand"
            @click="advancedIngredientsExpanded = true">
            See More ({{ advancedIngredientRemainderCount }})
          </button>
          <button
            v-if="advancedIngredientsExpanded && advancedIngredientRemainderCount > 0"
            type="button"
            class="inline-link-button secondary-link advanced-ingredient-expand"
            @click="advancedIngredientsExpanded = false">
            Show Less
          </button>
        </div>
      </div>
    </aside>

    <div
      v-if="activeModal === 'recipe' && selectedCocktail"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="recipe-modal-title"
      @click.self="closeActiveModal">
      <div class="modal-card modal-card-xl">
        <div class="modal-header">
          <h2 id="recipe-modal-title">{{ selectedCocktail.name }}</h2>
          <div class="menu-actions">
            <button type="button" class="menu-button" @click="printSelectedRecipe">Print</button>
            <button type="button" class="menu-button" @click="closeActiveModal">Close</button>
          </div>
        </div>

        <div ref="recipePrintContent" class="recipe-print-content">
          <p class="subtle">Source: {{ sourceNameFor(selectedCocktail.cocktailSourceId) }}</p>

          <div class="missing-panel">
            <strong>Missing Ingredients:</strong>
            <span v-if="missingIngredientsForSelected.length === 0" class="pill">You have everything</span>
            <ul v-else>
              <li v-for="ingredient in missingIngredientsForSelected" :key="`print-missing-${ingredient.id}`">
                {{ ingredient.name }}
              </li>
            </ul>
          </div>

          <div class="detail-grid recipe-modal-grid">
            <div>
              <h3>Ingredients</h3>
              <ul>
                <li v-for="item in selectedCocktailIngredients" :key="`print-ing-${item.id}`">
                  {{ item.ingredientName }}
                  <span v-if="item.displayAmount || item.amountName || item.amountText" class="subtle">({{ displayAmount(item) }})</span>
                </li>
              </ul>
            </div>

            <div>
              <h3>Steps</h3>
              <ol>
                <li v-for="step in selectedCocktailSteps" :key="`print-step-${step.stepNumber}`">
                  {{ step.instruction }}
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="activeModal === 'addCocktail'"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="add-cocktail-modal-title"
      @click.self="closeActiveModal">
      <div class="modal-card modal-card-wide add-cocktail-modal">
        <div class="modal-header">
          <h2 id="add-cocktail-modal-title">Add a Cocktail</h2>
          <button type="button" class="menu-button" @click="closeActiveModal">Close</button>
        </div>

        <div class="auth-stack">
          <div class="subtle">
            Current mode:
            <strong>{{ newCocktailForm.mode === 'paste' ? 'Paste Mode' : 'Structured Mode' }}</strong>
          </div>
          <div class="toolbar">
            <button
              type="button"
              class="menu-button"
              :class="{ active: newCocktailForm.mode === 'paste' }"
              @click="newCocktailForm.mode = 'paste'">
              {{ newCocktailForm.mode === 'paste' ? '✓ Paste Mode' : 'Paste Mode' }}
            </button>
            <button
              type="button"
              class="menu-button"
              :class="{ active: newCocktailForm.mode === 'structured' }"
              @click="newCocktailForm.mode = 'structured'">
              {{ newCocktailForm.mode === 'structured' ? '✓ Structured Mode' : 'Structured Mode' }}
            </button>
          </div>
          <select v-model.number="newCocktailForm.cocktailSourceId">
            <option :value="0">Select source</option>
            <option v-for="source in sources" :key="`src-${source.id}`" :value="source.id">
              {{ source.name }}
            </option>
          </select>

          <template v-if="newCocktailForm.mode === 'paste'">
            <textarea
              v-model="newCocktailForm.rawText"
              rows="14"
              placeholder="Name:
Description:
Ingredients:
- 2 oz gin
- 1 oz lemon juice
Steps:
1. Add ingredients to shaker with ice
2. Shake and strain"
            ></textarea>
            <div class="toolbar">
              <select v-model="newCocktailForm.timePeriodId">
                <option value="">Time period override (optional)</option>
                <option v-for="timePeriod in timePeriodOptions" :key="`time-${timePeriod.id}`" :value="timePeriod.id">
                  {{ timePeriod.name }}
                </option>
              </select>
            </div>
            <div v-if="addCocktailPreview" ref="addCocktailPreviewSection" class="structured-list">
              <div class="subheading">Preview</div>
              <p><strong>Name:</strong> {{ addCocktailPreview.name || 'Missing' }}</p>
              <p><strong>Description:</strong> {{ addCocktailPreview.description || 'Missing' }}</p>
              <p v-if="addCocktailPreview.timePeriodName"><strong>Time Period:</strong> {{ addCocktailPreview.timePeriodName }}</p>
              <p v-if="addCocktailPreview.errors && addCocktailPreview.errors.length">
                <strong>Validation:</strong> {{ addCocktailPreview.errors.join(' ') }}
              </p>
              <div class="subheading">Ingredients</div>
              <ul>
                <li
                  v-for="(ingredient, index) in addCocktailPreview.ingredients || []"
                  :key="`preview-ingredient-${index}`">
                  {{ ingredient.name }}
                  <small v-if="ingredient.isNew">(new)</small>
                </li>
              </ul>
              <div class="subheading">Steps</div>
              <ol>
                <li v-for="(step, index) in addCocktailPreview.steps || []" :key="`preview-step-${index}`">
                  {{ step }}
                </li>
              </ol>
              <p v-if="!selectedUserId" class="subtle">Log in to submit for approval.</p>
            </div>
            <div class="menu-actions add-cocktail-actions">
              <button
                type="button"
                :disabled="!canReviewCocktailPaste || addCocktailPreviewLoading || (addCocktailPreview && addCocktailPreview.isValid && !pasteNeedsReview)"
                @click="reviewNewCocktailPaste">
                {{ addCocktailPreviewLoading ? 'Reviewing...' : (addCocktailPreview && addCocktailPreview.isValid && !pasteNeedsReview ? 'Reviewed' : 'Review') }}
              </button>
              <button type="button" :disabled="!canSubmitCocktailPaste || addCocktailSubmitLoading" @click="submitNewCocktailFromPaste">
                {{ addCocktailSubmitLoading ? 'Submitting...' : 'Submit for Approval' }}
              </button>
              <button type="button" class="menu-button" @click="closeActiveModal">Cancel</button>
            </div>
            <p v-if="submitFromPasteDisabledReason" class="subtle">{{ submitFromPasteDisabledReason }}</p>
          </template>

          <template v-else>
            <input v-model.trim="newCocktailForm.name" placeholder="Cocktail name" />
            <textarea v-model.trim="newCocktailForm.description" placeholder="Description (optional)"></textarea>
            <div class="toolbar">
              <select v-model="newCocktailForm.glassTypeId">
                <option value="">Glass type (optional)</option>
                <option v-for="glassType in glassTypeOptions" :key="`glass-${glassType.id}`" :value="glassType.id">
                  {{ glassType.name }}
                </option>
              </select>
              <select v-model="newCocktailForm.timePeriodId">
                <option value="">Time period (optional)</option>
                <option v-for="timePeriod in timePeriodOptions" :key="`time-${timePeriod.id}`" :value="timePeriod.id">
                  {{ timePeriod.name }}
                </option>
              </select>
            </div>

            <div class="subheading">Ingredients</div>
            <div class="structured-list">
              <div
                v-for="(row, index) in newCocktailForm.ingredientEntries"
                :key="`new-ing-${index}`"
                class="structured-row">
                <input
                  v-model.trim="row.amountText"
                  list="amount-options"
                  placeholder="Amount (e.g. 2 oz)" />
                <input
                  v-model.trim="row.ingredientName"
                  list="ingredient-options"
                  placeholder="Ingredient (choose one or type a new one)" />
                <button type="button" class="menu-button row-remove" @click="removeIngredientEntry(index)">Remove</button>
              </div>
              <button type="button" class="menu-button add-row-button" @click="addIngredientEntry">Add Another Ingredient</button>
            </div>

            <div class="subheading">Steps</div>
            <div class="structured-list">
              <div
                v-for="(row, index) in newCocktailForm.stepEntries"
                :key="`new-step-${index}`"
                class="structured-row structured-step-row">
                <input v-model.trim="row.instruction" :placeholder="`Step ${index + 1}`" />
                <button type="button" class="menu-button row-remove" @click="removeStepEntry(index)">Remove</button>
              </div>
              <button type="button" class="menu-button add-row-button" @click="addStepEntry">Add Another Step</button>
            </div>

            <div class="menu-actions add-cocktail-actions">
              <button type="button" :disabled="!canCreateCocktailEntry" @click="submitNewCocktail">Save Cocktail Recipe</button>
              <button type="button" class="menu-button" @click="closeActiveModal">Cancel</button>
            </div>
          </template>
        </div>

        <datalist id="ingredient-options">
          <option v-for="ingredient in ingredients" :key="`ing-opt-${ingredient.id}`" :value="ingredient.name"></option>
        </datalist>
        <datalist id="amount-options">
          <option v-for="amount in amountOptions" :key="`amt-opt-${amount.id}`" :value="amount.name"></option>
        </datalist>

        <p v-if="newCocktailForm.mode === 'structured'" class="subtle account-help">
          Defaults to <strong>User Added</strong> when available. Choose existing ingredients/amounts or type new ones.
        </p>
      </div>
    </div>

    <div
      v-if="activeModal === 'account'"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="account-modal-title"
      @click.self="closeActiveModal">
      <div class="modal-card modal-card-wide">
        <div class="modal-header">
          <h2 id="account-modal-title">Account</h2>
          <button type="button" class="menu-button" @click="closeActiveModal">Close</button>
        </div>

        <template v-if="currentUser">
          <div class="account-summary">
            <strong>{{ currentUser.displayName }}</strong>
            <span v-if="currentUser.email" class="subtle">{{ currentUser.email }}</span>
          </div>
          <div class="subheading">My Cocktails</div>
          <p v-if="!myCocktails.length" class="subtle">No submitted cocktails yet.</p>
          <ul v-else>
            <li v-for="cocktail in myCocktails" :key="`mine-${cocktail.id}`">
              {{ cocktail.name }}
              <span class="pill" :class="moderationStatusClass(cocktail.moderationStatus)">
                {{ moderationStatusLabel(cocktail.moderationStatus) }}
              </span>
            </li>
          </ul>
          <div class="menu-actions">
            <button type="button" class="menu-button" @click="showNotImplementedModal('Change password')">Change password</button>
            <button type="button" class="menu-button" @click="logout">Log out</button>
          </div>
        </template>

        <template v-else>
          <div class="menu-actions">
            <button type="button" class="menu-button" @click="openAccountView('login')">Log in</button>
            <button type="button" class="menu-button" @click="openAccountView('register')">Create account</button>
          </div>

          <div v-if="accountMenuView === 'login'" class="account-pane">
            <div class="subheading">Log in</div>
            <div class="auth-stack">
              <input v-model.trim="loginForm.email" type="email" placeholder="Email" />
              <input v-model="loginForm.password" type="password" placeholder="Password" />
              <button :disabled="!canLogin" @click="loginUser">Log in</button>
            </div>
          </div>

          <div v-if="accountMenuView === 'register'" class="account-pane">
            <div class="subheading">Create account</div>
            <div class="auth-stack">
              <input v-model.trim="registerForm.displayName" placeholder="Display name" />
              <input v-model.trim="registerForm.email" type="email" placeholder="Email" />
              <input v-model="registerForm.password" type="password" placeholder="Password (8+ chars)" />
              <button :disabled="!canRegister" @click="registerUser">Create account</button>
            </div>
          </div>

          <p v-if="authValidationMessage" class="subtle account-help">{{ authValidationMessage }}</p>
        </template>
      </div>
    </div>

    <div
      v-if="activeModal === 'mybar'"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="my-bar-modal-title"
      @click.self="closeActiveModal">
      <div class="modal-card modal-card-xl">
        <div class="modal-header">
          <h2 id="my-bar-modal-title">My Bar Checklist</h2>
          <button type="button" class="menu-button" @click="closeActiveModal">Close</button>
        </div>
        <p class="subtle">
          {{ selectedUserId ? myBarGuidanceMessage : 'Log in to update My Bar and unlock personalized cocktail matches.' }}
        </p>
        <template v-if="selectedUserId">
          <div class="toolbar">
            <input v-model.trim="ingredientSearch" placeholder="Search ingredients" />
            <select v-model="inventorySpiritFilter">
              <option value="">All</option>
              <option v-for="spirit in spirits" :key="`inv-${spirit}`" :value="spirit">{{ spirit }}</option>
            </select>
          </div>
          <div class="inventory modal-inventory">
            <label v-for="ingredient in filteredInventoryIngredients" :key="ingredient.id" class="inventory-row">
              <input
                type="checkbox"
                :checked="isIngredientInStock(ingredient.id)"
                @change="toggleIngredientStock(ingredient.id, $event.target.checked)" />
              <span>{{ ingredient.name }}</span>
              <small v-if="ingredient.primarySpirit">{{ ingredient.primarySpirit }}</small>
            </label>
          </div>
        </template>
        <template v-else>
          <div class="menu-actions">
            <button type="button" @click="openAccountModal('login')">Log in</button>
            <button type="button" class="menu-button" @click="openAccountModal('register')">Create account</button>
          </div>
        </template>
      </div>
    </div>

    <div
      v-if="notImplementedModalOpen"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="not-implemented-title"
      @click.self="closeNotImplementedModal">
      <div class="modal-card">
        <h2 id="not-implemented-title">Coming Soon</h2>
        <p>
          {{ notImplementedFeatureName }} is not implemented yet, but the menu item is in place so it is easy to add later.
        </p>
        <p class="subtle">You can add it to the issue list and keep moving.</p>
        <div class="modal-actions">
          <button type="button" @click="closeNotImplementedModal">Close</button>
        </div>
      </div>
    </div>

    <div
      v-if="activeModal === 'admin' && isAdminUser"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="admin-modal-title"
      @click.self="closeActiveModal">
      <div class="modal-card modal-card-xl">
        <div class="modal-header">
          <h2 id="admin-modal-title">Admin</h2>
          <div class="menu-actions">
            <button type="button" class="menu-button" :disabled="adminBusy || adminMaintenanceBusy || adminTaxonomyBusy" @click="refreshAdminActiveView">
              {{ (adminBusy || adminMaintenanceBusy || adminTaxonomyBusy) ? 'Working...' : 'Refresh' }}
            </button>
            <button type="button" class="menu-button" :disabled="adminBusy || adminMaintenanceBusy || adminTaxonomyBusy" @click="closeActiveModal">Close</button>
          </div>
        </div>
        <div class="menu-actions admin-tab-row">
          <button
            type="button"
            class="menu-button"
            :class="{ active: adminView === 'importExport' }"
            @click="adminView = 'importExport'">
            {{ adminView === 'importExport' ? '✓ Import / Export' : 'Import / Export' }}
          </button>
          <button
            type="button"
            class="menu-button"
            :class="{ active: adminView === 'taxonomy' }"
            @click="adminView = 'taxonomy'">
            {{ adminView === 'taxonomy' ? '✓ Taxonomy' : 'Taxonomy' }}
          </button>
          <button
            type="button"
            class="menu-button"
            :class="{ active: adminView === 'maintenance' }"
            @click="adminView = 'maintenance'">
            {{ adminView === 'maintenance' ? '✓ Maintenance' : 'Maintenance' }}
          </button>
        </div>
        <div v-if="adminView === 'importExport'" class="detail-grid recipe-modal-grid">
          <div class="admin-block">
            <h3>Moderation Queue</h3>
            <p v-if="!adminPendingCocktails.length" class="subtle">No pending user submissions.</p>
            <ul v-else class="match-list">
              <li v-for="cocktail in adminPendingCocktails" :key="`admin-pending-${cocktail.id}`">
                <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
                <span class="subtle">by User #{{ cocktail.submittedByUserId || '?' }}</span>
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminModerationBusy" @click="approvePendingCocktail(cocktail.id)">
                    Approve
                  </button>
                  <button type="button" class="menu-button" :disabled="adminModerationBusy" @click="rejectPendingCocktail(cocktail.id)">
                    Reject
                  </button>
                </div>
              </li>
            </ul>
          </div>
          <div class="admin-export-panel">
            <h3>Export JSON</h3>
            <textarea v-model="adminExportJson" rows="16" spellcheck="false"></textarea>
            <div class="modal-actions admin-export-actions">
              <button
                type="button"
                class="menu-button"
                :disabled="!adminExportJson || adminBusy"
                @click="downloadAdminExportJson">
                Download Export JSON
              </button>
            </div>
          </div>
          <div>
            <h3>Import JSON</h3>
            <textarea v-model="adminImportJson" rows="16" spellcheck="false"></textarea>
            <div class="modal-actions">
              <button type="button" class="menu-button" :disabled="adminBusy" @click="openAdminImportFilePicker">
                Load from File
              </button>
              <button type="button" :disabled="adminBusy" @click="importAdminPayload">
                {{ adminBusy ? 'Importing...' : 'Run Import' }}
              </button>
              <button
                type="button"
                class="menu-button"
                :disabled="!adminImportSummary || !adminImportSummary.items || !adminImportSummary.items.length"
                @click="downloadAdminImportCsv">
                Download CSV
              </button>
            </div>
            <input
              ref="adminImportFileInput"
              type="file"
              accept=".json,application/json"
              class="admin-hidden-file-input"
              @change="handleAdminImportFileSelected" />
            <p v-if="adminImportSummary" class="subtle">
              Created: {{ adminImportSummary.created }},
              Updated: {{ adminImportSummary.updated }},
              Failed: {{ adminImportSummary.failed }}
            </p>
            <div v-if="adminImportSummary && adminImportSummary.items && adminImportSummary.items.length" class="admin-import-results">
              <h4>Import Item Results</h4>
              <table class="admin-import-table">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Action</th>
                    <th>Cocktail ID</th>
                    <th>Canonical Key</th>
                    <th>Error</th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="item in adminImportSummary.items"
                    :key="`admin-import-${item.inputIndex}`"
                    :class="`admin-import-row-${item.action || 'unknown'}`">
                    <td>{{ item.inputIndex }}</td>
                    <td>{{ item.action || '-' }}</td>
                    <td>{{ item.cocktailId || '-' }}</td>
                    <td><code>{{ item.canonicalKey || '-' }}</code></td>
                    <td class="admin-import-error">{{ item.error || '' }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div v-else-if="adminView === 'maintenance'" class="auth-stack">
          <p class="subtle">Run a dry-run first, then apply merge when results look correct.</p>
          <div class="detail-grid recipe-modal-grid">
            <div class="admin-block">
              <h3>Ingredient Duplicates</h3>
              <p class="subtle">Click a row to auto-fill merge IDs (keep first, then remove).</p>
              <p v-if="!ingredientDuplicateGroups.length" class="subtle">No duplicate ingredient groups found.</p>
              <div v-else class="admin-duplicate-groups">
                <div v-for="group in ingredientDuplicateGroups" :key="`ing-dup-${group.normalizedName}`" class="admin-duplicate-group">
                  <div class="subheading">{{ group.normalizedName }}</div>
                  <table class="admin-duplicate-table">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Cocktails</th>
                        <th>My Bar</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr
                        v-for="candidate in group.candidates"
                        :key="`ing-cand-${candidate.ingredientId}`"
                        class="admin-duplicate-row"
                        @click="selectIngredientMergeCandidate(candidate.ingredientId)">
                        <td>{{ candidate.ingredientId }}</td>
                        <td>{{ candidate.name }}</td>
                        <td>{{ candidate.cocktailUsageCount }}</td>
                        <td>{{ candidate.userUsageCount }}</td>
                        <td class="menu-actions">
                          <button type="button" class="menu-button" @click.stop="ingredientMergeForm.keepIngredientId = String(candidate.ingredientId)">
                            Keep
                          </button>
                          <button type="button" class="menu-button" @click.stop="ingredientMergeForm.removeIngredientId = String(candidate.ingredientId)">
                            Remove
                          </button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div class="admin-block">
              <h3>Ingredient Merge</h3>
              <div class="auth-stack">
                <input v-model.trim="ingredientMergeForm.keepIngredientId" placeholder="Keep ingredient ID" />
                <input v-model.trim="ingredientMergeForm.removeIngredientId" placeholder="Remove ingredient ID" />
                <input v-model.trim="ingredientMergeForm.reason" placeholder="Reason (optional)" />
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminMaintenanceBusy" @click="runIngredientMergeDryRun">
                    Dry Run
                  </button>
                  <button type="button" :disabled="adminMaintenanceBusy" @click="runIngredientMergeApply">
                    Merge Ingredient
                  </button>
                </div>
              </div>
              <pre v-if="ingredientMergePreview" class="admin-preview">{{ JSON.stringify(ingredientMergePreview, null, 2) }}</pre>
              <pre v-if="ingredientMergeResult" class="admin-result">{{ JSON.stringify(ingredientMergeResult, null, 2) }}</pre>
            </div>
            <div class="admin-block">
              <h3>Cocktail Duplicates</h3>
              <p class="subtle">Click a row to auto-fill merge IDs (keep first, then remove).</p>
              <p v-if="!cocktailDuplicateGroups.length" class="subtle">No duplicate cocktail groups found.</p>
              <div v-else class="admin-duplicate-groups">
                <div v-for="group in cocktailDuplicateGroups" :key="`cocktail-dup-${group.normalizedName}`" class="admin-duplicate-group">
                  <div class="subheading">{{ group.normalizedName }}</div>
                  <table class="admin-duplicate-table">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Source</th>
                        <th>Approved</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr
                        v-for="candidate in group.candidates"
                        :key="`cocktail-cand-${candidate.cocktailId}`"
                        class="admin-duplicate-row"
                        @click="selectCocktailMergeCandidate(candidate.cocktailId)">
                        <td>{{ candidate.cocktailId }}</td>
                        <td>{{ candidate.name }}</td>
                        <td>{{ candidate.cocktailSourceId || '-' }}</td>
                        <td>{{ Number(candidate.isApproved) === 1 ? 'Yes' : 'No' }}</td>
                        <td class="menu-actions">
                          <button type="button" class="menu-button" @click.stop="cocktailMergeForm.keepCocktailId = String(candidate.cocktailId)">
                            Keep
                          </button>
                          <button type="button" class="menu-button" @click.stop="cocktailMergeForm.removeCocktailId = String(candidate.cocktailId)">
                            Remove
                          </button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div class="admin-block">
              <h3>Cocktail Merge</h3>
              <div class="auth-stack">
                <input v-model.trim="cocktailMergeForm.keepCocktailId" placeholder="Keep cocktail ID" />
                <input v-model.trim="cocktailMergeForm.removeCocktailId" placeholder="Remove cocktail ID" />
                <input v-model.trim="cocktailMergeForm.reason" placeholder="Reason (optional)" />
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminMaintenanceBusy" @click="runCocktailMergeDryRun">
                    Dry Run
                  </button>
                  <button type="button" :disabled="adminMaintenanceBusy" @click="runCocktailMergeApply">
                    Merge Cocktail
                  </button>
                </div>
              </div>
              <pre v-if="cocktailMergePreview" class="admin-preview">{{ JSON.stringify(cocktailMergePreview, null, 2) }}</pre>
              <pre v-if="cocktailMergeResult" class="admin-result">{{ JSON.stringify(cocktailMergeResult, null, 2) }}</pre>
            </div>
          </div>
        </div>
        <div v-else class="auth-stack">
          <p class="subtle">Manage seeded tags and system collections for discovery.</p>
          <div class="detail-grid recipe-modal-grid">
            <div class="admin-block">
              <h3>Tag Management</h3>
              <div class="auth-stack">
                <select v-model="adminTagTypeId">
                  <option value="">Select tag type</option>
                  <option v-for="tagType in tagTypes" :key="`admin-tag-type-${tagType.id}`" :value="String(tagType.id)">
                    {{ tagType.name }}
                  </option>
                </select>
                <select v-model="adminTagId" :disabled="!adminTagsForSelectedType.length">
                  <option value="">Select tag</option>
                  <option v-for="tag in adminTagsForSelectedType" :key="`admin-tag-${tag.id}`" :value="String(tag.id)">
                    {{ tag.name }}
                  </option>
                </select>
                <input v-model.trim="adminTagCocktailSearch" placeholder="Search cocktails for tag assignment" />
                <select v-model="adminTagAssignmentFilter">
                  <option value="all">Show all cocktails</option>
                  <option value="assigned">Show assigned</option>
                  <option value="unassigned">Show unassigned</option>
                </select>
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !selectedAdminTag || !adminTagSelectedCocktailIds.length" @click="applyAdminTagSelection('assign')">
                    Add Selected
                  </button>
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !selectedAdminTag || !adminTagSelectedCocktailIds.length" @click="applyAdminTagSelection('remove')">
                    Remove Selected
                  </button>
                </div>
              </div>
              <p v-if="!selectedAdminTag" class="subtle">Choose a tag type and tag to manage assignments.</p>
              <div v-else class="admin-selection-list">
                <label
                  v-for="cocktail in filteredAdminTagCocktails"
                  :key="`admin-tag-cocktail-${cocktail.id}`"
                  class="admin-selection-row">
                  <input
                    :checked="adminTagSelectedCocktailIds.includes(Number(cocktail.id))"
                    type="checkbox"
                    @change="toggleAdminTagCocktailSelection(cocktail.id)" />
                  <span>{{ cocktail.name }}</span>
                  <span class="pill" :class="cocktailHasTag(cocktail, selectedAdminTag.normalizedName) ? 'pill-assigned' : 'pill-unassigned'">
                    {{ cocktailHasTag(cocktail, selectedAdminTag.normalizedName) ? 'Assigned' : 'Unassigned' }}
                  </span>
                </label>
              </div>
            </div>

            <div class="admin-block">
              <h3>System Collections</h3>
              <div class="auth-stack">
                <select v-model="adminSelectedCollectionId">
                  <option value="">New system collection</option>
                  <option v-for="collection in systemCollections" :key="`admin-collection-${collection.id}`" :value="String(collection.id)">
                    {{ collection.name }}
                  </option>
                </select>
                <input v-model.trim="adminCollectionForm.name" placeholder="Collection name" />
                <textarea v-model.trim="adminCollectionForm.description" rows="3" placeholder="Collection description"></textarea>
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy" @click="startNewAdminCollection">
                    New
                  </button>
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !adminCollectionForm.name.trim()" @click="saveAdminCollection">
                    {{ Number(adminCollectionForm.id || 0) > 0 ? 'Save' : 'Create' }}
                  </button>
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !adminSelectedCollectionId" @click="deleteAdminCollection">
                    Delete
                  </button>
                </div>
              </div>
              <div class="auth-stack">
                <input v-model.trim="adminCollectionCocktailSearch" placeholder="Search cocktails for collection membership" />
                <select v-model="adminCollectionMembershipFilter">
                  <option value="all">Show all cocktails</option>
                  <option value="members">Show members</option>
                  <option value="nonmembers">Show non-members</option>
                </select>
                <div class="menu-actions">
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !adminSelectedCollectionId || !adminCollectionSelectedCocktailIds.length" @click="applyAdminCollectionSelection('add')">
                    Add Selected
                  </button>
                  <button type="button" class="menu-button" :disabled="adminTaxonomyBusy || !adminSelectedCollectionId || !adminCollectionSelectedCocktailIds.length" @click="applyAdminCollectionSelection('remove')">
                    Remove Selected
                  </button>
                </div>
              </div>
              <div v-if="!adminSelectedCollectionId" class="subtle">Create or select a system collection to manage membership.</div>
              <div v-else class="admin-selection-list">
                <label
                  v-for="cocktail in filteredAdminCollectionCocktails"
                  :key="`admin-collection-cocktail-${cocktail.id}`"
                  class="admin-selection-row">
                  <input
                    :checked="adminCollectionSelectedCocktailIds.includes(Number(cocktail.id))"
                    type="checkbox"
                    @change="toggleAdminCollectionCocktailSelection(cocktail.id)" />
                  <span>{{ cocktail.name }}</span>
                  <span class="pill" :class="selectedAdminCollectionCocktailIds.has(Number(cocktail.id)) ? 'pill-assigned' : 'pill-unassigned'">
                    {{ selectedAdminCollectionCocktailIds.has(Number(cocktail.id)) ? 'In Collection' : 'Not in Collection' }}
                  </span>
                </label>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="reviewSubmittedModalOpen"
      class="modal-backdrop"
      role="dialog"
      aria-modal="true"
      aria-labelledby="review-submitted-title"
      @click.self="closeReviewSubmittedModal">
      <div class="modal-card">
        <h2 id="review-submitted-title">Submitted for Review</h2>
        <p>Your cocktail recipe has been submitted for review.</p>
        <div class="modal-actions">
          <button type="button" @click="closeReviewSubmittedModal">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {
  addCocktailToCollection,
  approveCocktail,
  assignTagToCocktail,
  createCocktail,
  createCollection,
  createCocktailTryLog,
  deleteCollection,
  exportAdminCocktails,
  getAdminCocktailDuplicates,
  getAdminIngredientDuplicates,
  getAdminPendingCocktails,
  getMyCocktails,
  getAmounts,
  getCocktailIngredients,
  getCocktailSources,
  getCocktailSteps,
  getCocktailTimePeriods,
  getCollectionCocktails,
  getCollections,
  getCurrentUser,
  getCocktailTryLogs,
  getTags,
  getTagTypes,
  getUserCocktailTryLogs,
  getCocktails,
  getGlassTypes,
  getIngredients,
  getUserInventory,
  getStoredAuthToken,
  importAdminCocktails,
  login,
  mergeAdminCocktail,
  mergeAdminIngredient,
  previewAdminCocktailMerge,
  previewAdminIngredientMerge,
  previewCocktailFromText,
  register,
  rejectCocktail,
  removeCocktailFromCollection,
  removeTagFromCocktail,
  setAuthToken,
  submitCocktailFromText,
  updateCollection,
  upsertUserInventory
} from './api';

const POPULAR_ONLY_STORAGE_KEY = 'cocktailchooser.popularOnly';
const ADVANCED_INGREDIENT_PREVIEW_COUNT = 15;
const DEVELOPER_CONTACT_MODE = String(process.env.VUE_APP_DEVELOPER_CONTACT_MODE || '').trim().toLowerCase();
const DEVELOPER_CONTACT_EMAIL = String(process.env.VUE_APP_DEVELOPER_CONTACT_EMAIL || '').trim();
const DEVELOPER_CONTACT_PHONE = String(process.env.VUE_APP_DEVELOPER_CONTACT_PHONE || '').trim();
const DEVELOPER_CONTACT_SUBJECT = String(process.env.VUE_APP_DEVELOPER_CONTACT_SUBJECT || 'CocktailChooser admin note').trim();
const DEVELOPER_CONTACT_BODY = String(process.env.VUE_APP_DEVELOPER_CONTACT_BODY || 'Hi, I have a note from the CocktailChooser admin panel.').trim();

function createDefaultFilterState() {
  return {
    mode: 'SHOW_ALL',
    searchText: '',
    selectedTimePeriodIds: [],
    selectedSourceIds: [],
    selectedFlavorProfiles: [],
    selectedTagNames: [],
    selectedIngredientIds: [],
    includeUnapproved: false,
    mySubmissionsOnly: false,
    myApprovedOnly: false
  };
}

const ALCOHOLIC_INGREDIENT_TOKENS = [
  'vodka',
  'gin',
  'rum',
  'tequila',
  'mezcal',
  'whiskey',
  'whisky',
  'bourbon',
  'scotch',
  'brandy',
  'cognac',
  'liqueur',
  'liquor',
  'vermouth',
  'amaro',
  'aperol',
  'campari',
  'chartreuse',
  'cointreau',
  'triple sec',
  'absinthe',
  'port',
  'wine',
  'champagne',
  'prosecco',
  'kahlua',
  'bitters',
  'creme de'
];

function buildMailtoHref(email, subject, body) {
  if (!email) {
    return '';
  }

  const query = new URLSearchParams();
  if (subject) {
    query.set('subject', subject);
  }
  if (body) {
    query.set('body', body);
  }

  const suffix = query.toString() ? `?${query.toString()}` : '';
  return `mailto:${email}${suffix}`;
}

function buildSmsHref(phone, body) {
  if (!phone) {
    return '';
  }

  const encodedBody = body ? encodeURIComponent(body) : '';
  return encodedBody ? `sms:${phone}?&body=${encodedBody}` : `sms:${phone}`;
}

export default {
  name: 'App',
  data() {
    return {
      cocktails: [],
      allCocktails: [],
      ingredients: [],
      cocktailIngredients: [],
      inventory: [],
      sources: [],
      tagTypes: [],
      tags: [],
      systemCollections: [],
      collectionCocktailsByCollectionId: {},
      amountOptions: [],
      glassTypeOptions: [],
      timePeriodOptions: [],
      userCocktailLogs: [],
      currentUser: null,

      selectedUserId: 0,
      selectedCocktailId: 0,

      selectedCocktailSteps: [],
      selectedCocktailLogs: [],

      cocktailSearch: '',
      ingredientSearch: '',
      selectedSpirit: '',
      virginOnly: false,
      popularOnly: false,
      ingredientFilterMode: 'all',
      tagFilterMode: 'all',
      ingredientFilterSearch: '',
      selectedIngredientIds: [],
      cocktailListMode: 'all',
      filterState: createDefaultFilterState(),
      advancedFiltersOpen: false,
      advancedIngredientsExpanded: false,
      advancedIngredientSearch: '',
      myDrinksOnly: false,
      myCocktailSearch: '',
      myCocktailStatusFilter: 'all',
      inventorySpiritFilter: '',
      showUntriedOnly: false,

      loginForm: {
        email: '',
        password: ''
      },
      registerForm: {
        displayName: '',
        email: '',
        password: ''
      },
      newCocktailForm: {
        mode: 'paste',
        rawText: '',
        name: '',
        description: '',
        method: '',
        glassTypeId: '',
        timePeriodId: '',
        ingredientEntries: [
          { amountText: '', ingredientName: '' }
        ],
        stepEntries: [
          { instruction: '' }
        ],
        cocktailSourceId: 0
      },
      addCocktailPreview: null,
      addCocktailPreviewLoading: false,
      addCocktailSubmitLoading: false,
      lastReviewedRawText: '',
      myCocktails: [],
      adminPendingCocktails: [],
      reviewSubmittedModalOpen: false,
      newLog: {
        rating: null,
        comment: '',
        triedOnLocal: ''
      },

      userSuccessMessage: '',
      error: '',
      accountMenuOpen: false,
      accountMenuView: '',
      activeModal: '',
      currentPath: '/',
      adminExportJson: '',
      adminImportJson: '',
      adminImportSummary: null,
      adminView: 'importExport',
      adminBusy: false,
      adminModerationBusy: false,
      adminMaintenanceBusy: false,
      adminTaxonomyBusy: false,
      adminTagTypeId: '',
      adminTagId: '',
      adminTagCocktailSearch: '',
      adminTagAssignmentFilter: 'all',
      adminTagSelectedCocktailIds: [],
      adminSelectedCollectionId: '',
      adminCollectionForm: {
        id: 0,
        name: '',
        description: ''
      },
      adminCollectionCocktailSearch: '',
      adminCollectionMembershipFilter: 'all',
      adminCollectionSelectedCocktailIds: [],
      ingredientDuplicateGroups: [],
      cocktailDuplicateGroups: [],
      ingredientMergeForm: {
        keepIngredientId: '',
        removeIngredientId: '',
        reason: ''
      },
      cocktailMergeForm: {
        keepCocktailId: '',
        removeCocktailId: '',
        reason: ''
      },
      ingredientMergePreview: null,
      ingredientMergeResult: null,
      cocktailMergePreview: null,
      cocktailMergeResult: null,
      notImplementedModalOpen: false,
      notImplementedFeatureName: 'This feature'
    };
  },
  computed: {
    onlyCocktailsICanMake: {
      get() {
        return this.cocktailListMode === 'makeable';
      },
      set(value) {
        this.cocktailListMode = value ? 'makeable' : 'all';
      }
    },
    advancedIngredientPreviewCount() {
      return ADVANCED_INGREDIENT_PREVIEW_COUNT;
    },
    advancedSelectedIngredientIdSet() {
      return new Set(this.selectedIngredientIds.map((id) => Number(id)));
    },
    selectedTagNameSet() {
      return new Set((this.filterState.selectedTagNames || []).map((name) => String(name)));
    },
    tagsByType() {
      const grouped = {};
      this.tagTypes.forEach((tagType) => {
        grouped[tagType.name] = [];
      });
      this.tags.forEach((tag) => {
        if (!grouped[tag.tagTypeName]) {
          grouped[tag.tagTypeName] = [];
        }
        grouped[tag.tagTypeName].push(tag);
      });

      Object.keys(grouped).forEach((key) => {
        grouped[key] = grouped[key].slice().sort((a, b) => (a.name || '').localeCompare(b.name || ''));
      });

      return grouped;
    },
    advancedTagGroups() {
      return this.tagTypes
        .map((tagType) => ({
          ...tagType,
          tags: this.tagsByType[tagType.name] || []
        }))
        .filter((group) => group.tags.length > 0);
    },
    spirits() {
      return [...new Set(this.ingredients.map((x) => x.primarySpirit).filter(Boolean))].sort();
    },
    rankedIngredientsForAdvancedFilters() {
      if (!this.ingredients.length) {
        return [];
      }

      return [...this.ingredients]
        .sort((a, b) => {
          const byName = (a.name || '').localeCompare(b.name || '');
          if (byName !== 0) {
            return byName;
          }

          return Number(a.id || 0) - Number(b.id || 0);
        });
    },
    filteredRankedIngredientsForAdvancedFilters() {
      const search = (this.advancedIngredientSearch || '').trim().toLowerCase();
      if (!search) {
        return this.rankedIngredientsForAdvancedFilters;
      }

      return this.rankedIngredientsForAdvancedFilters
        .filter((ingredient) => (ingredient.name || '').toLowerCase().includes(search));
    },
    advancedSelectedIngredientOptions() {
      return this.filteredRankedIngredientsForAdvancedFilters
        .filter((ingredient) => this.advancedSelectedIngredientIdSet.has(Number(ingredient.id)));
    },
    advancedUnselectedIngredientOptions() {
      const unselected = this.filteredRankedIngredientsForAdvancedFilters
        .filter((ingredient) => !this.advancedSelectedIngredientIdSet.has(Number(ingredient.id)));

      if ((this.advancedIngredientSearch || '').trim().length > 0 || this.advancedIngredientsExpanded) {
        return unselected;
      }

      return unselected.slice(0, this.advancedIngredientPreviewCount);
    },
    advancedIngredientRemainderCount() {
      if ((this.advancedIngredientSearch || '').trim().length > 0) {
        return 0;
      }

      const allUnselectedCount = this.rankedIngredientsForAdvancedFilters
        .filter((ingredient) => !this.advancedSelectedIngredientIdSet.has(Number(ingredient.id))).length;
      const remainder = allUnselectedCount - this.advancedUnselectedIngredientOptions.length;
      return remainder > 0 ? remainder : 0;
    },
    ingredientFilterOptions() {
      return this.ingredients
        .filter((ingredient) => !this.selectedIngredientIds.includes(ingredient.id))
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    },
    selectedIngredientFilters() {
      if (!this.selectedIngredientIds.length) {
        return [];
      }

      const selected = new Set(this.selectedIngredientIds);
      return this.ingredients
        .filter((ingredient) => selected.has(ingredient.id))
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    },
    selectedIngredientFilterNames() {
      return this.selectedIngredientFilters
        .map((ingredient) => (ingredient.name || '').trim())
        .filter(Boolean);
    },
    selectedIngredientFilterCandidate() {
      const search = (this.ingredientFilterSearch || '').trim();
      if (!search) {
        return null;
      }

      return this.ingredientFilterOptions.find((ingredient) =>
        (ingredient.name || '').toLowerCase() === search.toLowerCase()) || null;
    },
    cocktailById() {
      const map = {};
      const addToMap = (list) => {
        (list || []).forEach((cocktail) => {
          if (!cocktail || !cocktail.id) {
            return;
          }

          map[cocktail.id] = cocktail;
        });
      };

      // Include public browse cocktails plus user/admin overlays so pending/rejected
      // entries still render in detail modal when selected from those lists.
      addToMap(this.cocktails);
      addToMap(this.allCocktails);
      addToMap(this.myCocktails);
      addToMap(this.adminPendingCocktails);
      return map;
    },
    selectedCocktail() {
      return this.cocktailById[this.selectedCocktailId] || null;
    },
    cocktailIngredientsByCocktail() {
      const map = {};
      this.cocktailIngredients.forEach((row) => {
        if (!map[row.cocktailId]) {
          map[row.cocktailId] = [];
        }
        map[row.cocktailId].push(row);
      });
      return map;
    },
    inventoryInStockSet() {
      return new Set(this.inventory.filter((x) => x.isInStock).map((x) => x.ingredientId));
    },
    browseCocktails() {
      if (!this.selectedUserId || !this.myCocktails.length) {
        return this.cocktails;
      }

      const byId = new Map(this.cocktails.map((cocktail) => [Number(cocktail.id), cocktail]));
      this.myCocktails.forEach((cocktail) => {
        byId.set(Number(cocktail.id), cocktail);
      });
      return [...byId.values()];
    },
    evaluatedBrowseCocktails() {
      return this.browseCocktails.map((cocktail) => {
        const ingredientRows = this.cocktailIngredientsByCocktail[cocktail.id] || [];
        const missingIngredients = this.getMissingIngredients(cocktail.id);
        const missingIngredientIds = missingIngredients.map((ingredient) => Number(ingredient.id));
        return {
          cocktail,
          ingredientRows,
          canMake: missingIngredientIds.length === 0,
          missingCount: missingIngredientIds.length,
          missingIngredientIds
        };
      });
    },
    filteredInventoryIngredients() {
      return this.ingredients.filter((ingredient) => {
        const matchesSearch = !this.ingredientSearch
          || ingredient.name.toLowerCase().includes(this.ingredientSearch.toLowerCase());

        const matchesSpirit = !this.inventorySpiritFilter
          || ingredient.primarySpirit === this.inventorySpiritFilter;

        return matchesSearch && matchesSpirit;
      });
    },
    makeableCocktails() {
      if (!this.selectedUserId) {
        return [];
      }

      const byId = new Map(this.allCocktails.map((cocktail) => [Number(cocktail.id), cocktail]));
      this.myCocktails.forEach((cocktail) => {
        byId.set(Number(cocktail.id), cocktail);
      });
      return [...byId.values()].filter((c) => this.canMakeById(c.id));
    },
    effectiveMode() {
      const mode = (this.filterState.mode || '').toUpperCase();
      if (mode === 'CAN_MAKE' || mode === 'ALMOST_UNLOCKED' || mode === 'SHOW_ALL') {
        return mode;
      }

      return this.cocktailListMode === 'makeable' ? 'CAN_MAKE' : 'SHOW_ALL';
    },
    filteredCocktailEvaluationsIgnoringMode() {
      return this.evaluatedBrowseCocktails.filter((evaluation) =>
        this.matchesCocktailEvaluationFilters(evaluation));
    },
    displayedCocktailEvaluations() {
      return this.filteredCocktailEvaluationsIgnoringMode.filter((evaluation) => {
        if (this.effectiveMode === 'CAN_MAKE') {
          return evaluation.canMake;
        }

        if (this.effectiveMode === 'ALMOST_UNLOCKED') {
          return evaluation.missingCount === 1;
        }

        return true;
      });
    },
    filteredMakeableCocktails() {
      return this.filteredCocktailEvaluationsIgnoringMode
        .filter((evaluation) => evaluation.canMake)
        .map((evaluation) => evaluation.cocktail);
    },
    displayedCocktails() {
      return this.displayedCocktailEvaluations.map((evaluation) => evaluation.cocktail);
    },
    filteredMyCocktailsForPage() {
      const search = (this.myCocktailSearch || '').trim().toLowerCase();
      return this.myCocktails.filter((cocktail) => {
        if (search && !(cocktail.name || '').toLowerCase().includes(search)) {
          return false;
        }

        const status = (cocktail.moderationStatus || 'pending').toLowerCase();
        if (this.myCocktailStatusFilter !== 'all' && status !== this.myCocktailStatusFilter) {
          return false;
        }

        return true;
      });
    },
    combinedCocktailListEmptyMessage() {
      if (this.effectiveMode === 'CAN_MAKE' && !this.selectedUserId) {
        return 'Log in to see what you can make from My Bar.';
      }

      if (this.displayedCocktails.length > 0) {
        return '';
      }

      if (this.effectiveMode === 'SHOW_ALL') {
        return 'No cocktails match your current filters.';
      }

      return 'No cocktails match My Bar with these filters yet. Try another spirit or add more ingredients.';
    },
    selectedCocktailIngredients() {
      return this.cocktailIngredientsByCocktail[this.selectedCocktailId] || [];
    },
    missingIngredientsForSelected() {
      if (!this.selectedCocktailId) {
        return [];
      }

      return this.getMissingIngredients(this.selectedCocktailId);
    },
    lastTriedLog() {
      if (!this.userCocktailLogs.length) {
        return null;
      }

      return [...this.userCocktailLogs]
        .sort((a, b) => new Date(b.triedOnUtc || b.createdUtc || 0) - new Date(a.triedOnUtc || a.createdUtc || 0))[0];
    },
    lastTriedSummary() {
      if (!this.selectedUserId) {
        return 'Log in';
      }

      if (!this.lastTriedLog) {
        return 'No cocktail logs yet';
      }

      const cocktailName = this.cocktailById[this.lastTriedLog.cocktailId]?.name || `Cocktail #${this.lastTriedLog.cocktailId}`;
      const date = this.formatDate(this.lastTriedLog.triedOnUtc || this.lastTriedLog.createdUtc);
      return `${cocktailName} (${date})`;
    },
    triedCocktailIdSet() {
      return new Set(this.userCocktailLogs.map((log) => log.cocktailId));
    },
    nextIngredientRecommendation() {
      if (!this.selectedUserId) {
        return null;
      }

      const unlockCounts = new Map();

      this.allCocktails.forEach((cocktail) => {
        if (this.canMakeById(cocktail.id)) {
          return;
        }

        const missing = this.getMissingIngredients(cocktail.id);
        if (missing.length !== 1) {
          return;
        }

        const ingredient = missing[0];
        unlockCounts.set(ingredient.id, {
          ingredient,
          count: (unlockCounts.get(ingredient.id)?.count || 0) + 1
        });
      });

      if (unlockCounts.size === 0) {
        return null;
      }

      return [...unlockCounts.values()].sort((a, b) => {
        if (b.count !== a.count) {
          return b.count - a.count;
        }

        return a.ingredient.name.localeCompare(b.ingredient.name);
      })[0];
    },
    nextIngredientRecommendationSummary() {
      if (!this.selectedUserId) {
        return 'Log in';
      }

      if (!this.nextIngredientRecommendation) {
        return 'No single-ingredient suggestion yet';
      }

      const { ingredient, count } = this.nextIngredientRecommendation;
      return `${ingredient.name} (+${count} cocktails)`;
    },
    canLogin() {
      return this.loginForm.email.trim().length > 0 && this.loginForm.password.length > 0;
    },
    canRegister() {
      return this.registerForm.displayName.trim().length > 0
        && this.registerForm.email.trim().length > 0
        && this.registerForm.password.length >= 8;
    },
    isAdminUser() {
      return Number(this.currentUser?.id || 0) === 1;
    },
    developerContactAction() {
      const smsHref = buildSmsHref(DEVELOPER_CONTACT_PHONE, DEVELOPER_CONTACT_BODY);
      const mailtoHref = buildMailtoHref(DEVELOPER_CONTACT_EMAIL, DEVELOPER_CONTACT_SUBJECT, DEVELOPER_CONTACT_BODY);

      if (DEVELOPER_CONTACT_MODE === 'sms' && smsHref) {
        return {
          href: smsHref,
          label: 'Send a message to the developer',
          description: 'Opens your texting app.'
        };
      }

      if (mailtoHref) {
        return {
          href: mailtoHref,
          label: 'Send a message to the developer',
          description: 'Opens your email app.'
        };
      }

      if (smsHref) {
        return {
          href: smsHref,
          label: 'Send a message to the developer',
          description: 'Opens your texting app.'
        };
      }

      return null;
    },
    isAdminRoute() {
      return this.currentPath === '/admin';
    },
    isMyCocktailsRoute() {
      return this.currentPath === '/my-cocktails';
    },
    preferredMyCocktailsSourceId() {
      const userAddedExact = this.sources.find((s) => (s.name || '').toLowerCase() === 'user added');
      const userAddedFuzzy = this.sources.find((s) => (s.name || '').toLowerCase().includes('user add'));
      const exact = this.sources.find((s) => (s.name || '').toLowerCase() === 'my cocktails');
      const fuzzy = this.sources.find((s) => (s.name || '').toLowerCase().includes('my cocktail'));
      return userAddedExact?.id || userAddedFuzzy?.id || exact?.id || fuzzy?.id || this.sources[0]?.id || 0;
    },
    adminTagsForSelectedType() {
      const selectedTypeId = Number(this.adminTagTypeId || 0);
      return this.tags
        .filter((tag) => !selectedTypeId || Number(tag.tagTypeId) === selectedTypeId)
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    },
    selectedAdminTag() {
      return this.adminTagsForSelectedType.find((tag) => Number(tag.id) === Number(this.adminTagId || 0)) || null;
    },
    filteredAdminTagCocktails() {
      const selectedTag = this.selectedAdminTag;
      const search = (this.adminTagCocktailSearch || '').trim().toLowerCase();
      return [...this.allCocktails]
        .filter((cocktail) => {
          if (search && !(cocktail.name || '').toLowerCase().includes(search)) {
            return false;
          }

          if (!selectedTag) {
            return true;
          }

          const isAssigned = this.cocktailHasTag(cocktail, selectedTag.normalizedName);
          if (this.adminTagAssignmentFilter === 'assigned') {
            return isAssigned;
          }
          if (this.adminTagAssignmentFilter === 'unassigned') {
            return !isAssigned;
          }
          return true;
        })
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    },
    selectedAdminCollection() {
      return this.systemCollections.find((collection) => Number(collection.id) === Number(this.adminSelectedCollectionId || 0)) || null;
    },
    selectedAdminCollectionCocktailIds() {
      const collectionId = Number(this.adminSelectedCollectionId || 0);
      const rows = this.collectionCocktailsByCollectionId[collectionId] || [];
      return new Set(rows.map((row) => Number(row.cocktailId)));
    },
    filteredAdminCollectionCocktails() {
      const search = (this.adminCollectionCocktailSearch || '').trim().toLowerCase();
      const memberIds = this.selectedAdminCollectionCocktailIds;
      return [...this.allCocktails]
        .filter((cocktail) => {
          if (search && !(cocktail.name || '').toLowerCase().includes(search)) {
            return false;
          }

          const isMember = memberIds.has(Number(cocktail.id));
          if (this.adminCollectionMembershipFilter === 'members') {
            return isMember;
          }
          if (this.adminCollectionMembershipFilter === 'nonmembers') {
            return !isMember;
          }
          return true;
        })
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    },
    canCreateCocktailEntry() {
      const hasIngredient = this.newCocktailForm.ingredientEntries.some((x) => (x.ingredientName || '').trim().length > 0);
      const hasStep = this.newCocktailForm.stepEntries.some((x) => (x.instruction || '').trim().length > 0);
      return this.newCocktailForm.name.trim().length > 0
        && Number(this.newCocktailForm.cocktailSourceId) > 0
        && hasIngredient
        && hasStep;
    },
    canReviewCocktailPaste() {
      return this.newCocktailForm.rawText.trim().length > 0;
    },
    canSubmitCocktailPaste() {
      return !this.submitFromPasteDisabledReason;
    },
    submitFromPasteDisabledReason() {
      if (!this.selectedUserId) {
        return 'Log in to submit cocktails for approval.';
      }

      if (!Number(this.newCocktailForm.cocktailSourceId)) {
        return 'Select a source before submitting.';
      }

      if (!this.addCocktailPreview) {
        return 'Run Review first.';
      }

      if (!this.addCocktailPreview.isValid) {
        return 'Fix review errors before submitting.';
      }

      return '';
    },
    pasteNeedsReview() {
      return this.newCocktailForm.rawText.trim() !== this.lastReviewedRawText;
    },
    authValidationMessage() {
      if (this.currentUser) {
        return '';
      }

      return 'Log in or create an account to save My Bar and your cocktail history.';
    },
    myBarGuidanceMessage() {
      if (!this.selectedUserId) {
        return 'To see what you can make, add ingredients to My Bar from the menu.';
      }

      if (this.inventoryInStockSet.size === 0) {
        return 'To see what you can make, add ingredients to My Bar from the menu.';
      }

      if (this.nextIngredientRecommendation) {
        const { ingredient, count } = this.nextIngredientRecommendation;
        return `Update My Bar from the menu. Adding ${ingredient.name} unlocks ${count} more cocktails.`;
      }

      return 'Update My Bar from the menu.';
    }
  },
  watch: {
    cocktailListMode(value) {
      this.filterState.mode = value === 'makeable' ? 'CAN_MAKE' : 'SHOW_ALL';
    },
    cocktailSearch(value) {
      this.filterState.searchText = value || '';
    },
    myDrinksOnly(value) {
      this.filterState.mySubmissionsOnly = !!value;
    },
    'filterState.mySubmissionsOnly'(value) {
      this.myDrinksOnly = !!value;
    },
    selectedIngredientIds: {
      deep: true,
      async handler() {
        this.filterState.selectedIngredientIds = [...this.selectedIngredientIds];
        await this.reloadCocktailsForIngredientFilters();
      }
    },
    async ingredientFilterMode() {
      await this.reloadCocktailsForIngredientFilters();
    },
    adminTagTypeId(newValue) {
      const available = this.tags
        .filter((tag) => !Number(newValue || 0) || Number(tag.tagTypeId) === Number(newValue))
        .sort((a, b) => (a.name || '').localeCompare(b.name || ''));
      this.adminTagId = available[0]?.id ? String(available[0].id) : '';
      this.adminTagSelectedCocktailIds = [];
    },
    async adminSelectedCollectionId(newValue) {
      this.adminCollectionSelectedCocktailIds = [];
      if (!Number(newValue || 0)) {
        return;
      }

      await this.loadCollectionCocktailsForAdmin(Number(newValue));
      const selected = this.selectedAdminCollection;
      if (selected) {
        this.adminCollectionForm = {
          id: selected.id,
          name: selected.name || '',
          description: selected.description || ''
        };
      }
    },
    async virginOnly() {
      await this.reloadCocktailsForIngredientFilters();
    },
    popularOnly(value) {
      if (typeof window === 'undefined') {
        return;
      }

      window.localStorage.setItem(POPULAR_ONLY_STORAGE_KEY, value ? '1' : '0');
    },
    selectedCocktail(newCocktail) {
      if (typeof document === 'undefined') {
        return;
      }

      const cocktailName = (newCocktail?.name || '').trim();
      document.title = cocktailName ? `Cocktail Chooser - ${cocktailName}` : 'Cocktail Chooser';
    },
    async adminView(newView) {
      if (this.activeModal !== 'admin' || !this.isAdminUser) {
        return;
      }

      if (newView === 'maintenance') {
        await this.loadAdminMaintenanceData();
      } else if (newView === 'taxonomy') {
        await this.loadAdminTaxonomyData();
      } else {
        await Promise.all([
          this.loadAdminExportPayload(),
          this.loadAdminPendingCocktails()
        ]);
      }
    }
  },
  async created() {
    this.currentPath = this.getCurrentPath();
    this.restorePopularOnlyPreference();
    await this.loadInitialData();
  },
  mounted() {
    if (typeof window !== 'undefined') {
      window.addEventListener('popstate', this.handlePopState);
      window.addEventListener('keydown', this.handleGlobalKeydown);
    }
  },
  beforeUnmount() {
    if (typeof window !== 'undefined') {
      window.removeEventListener('popstate', this.handlePopState);
      window.removeEventListener('keydown', this.handleGlobalKeydown);
    }
  },
  methods: {
    getCurrentPath() {
      if (typeof window === 'undefined') {
        return '/';
      }

      const path = (window.location.pathname || '/').trim();
      return path || '/';
    },
    handlePopState() {
      this.currentPath = this.getCurrentPath();
      if (this.currentPath === '/admin' && this.isAdminUser) {
        this.openAdminModal();
      } else if (this.currentPath === '/my-cocktails') {
        if (!this.currentUser) {
          this.error = 'Log in to access /my-cocktails.';
          this.navigateTo('/', { replace: true });
        } else {
          this.activeModal = '';
        }
      } else if (this.activeModal === 'admin') {
        this.activeModal = '';
      }
    },
    handleGlobalKeydown(event) {
      if (event?.key !== 'Escape') {
        return;
      }

      if (this.advancedFiltersOpen) {
        this.closeAdvancedFilters();
      }
    },
    openAdvancedFilters() {
      this.advancedFiltersOpen = true;
    },
    toggleAdvancedFilters() {
      this.advancedFiltersOpen = !this.advancedFiltersOpen;
    },
    closeAdvancedFilters() {
      this.advancedFiltersOpen = false;
    },
    async resetAllFilters() {
      this.filterState = createDefaultFilterState();
      this.advancedIngredientsExpanded = false;
      this.advancedIngredientSearch = '';

      this.cocktailListMode = this.selectedUserId ? 'makeable' : 'all';
      this.filterState.mode = this.cocktailListMode === 'makeable' ? 'CAN_MAKE' : 'SHOW_ALL';
      this.cocktailSearch = '';
      this.selectedSpirit = '';
      this.ingredientFilterMode = 'all';
      this.tagFilterMode = 'all';
      this.ingredientFilterSearch = '';
      this.selectedIngredientIds = [];
      this.virginOnly = false;
      this.popularOnly = false;
      this.myDrinksOnly = false;
      this.showUntriedOnly = false;

      await this.reloadCocktailsForIngredientFilters();
    },
    toggleAdvancedArrayItem(values, rawId) {
      const id = Number(rawId);
      const next = new Set(values.map((value) => Number(value)));
      if (next.has(id)) {
        next.delete(id);
      } else {
        next.add(id);
      }

      return [...next.values()];
    },
    toggleStringArrayItem(values, rawValue) {
      const value = String(rawValue || '');
      const next = new Set(values.map((entry) => String(entry || '')));
      if (next.has(value)) {
        next.delete(value);
      } else {
        next.add(value);
      }

      return [...next.values()];
    },
    toggleAdvancedSource(sourceId) {
      this.filterState.selectedSourceIds = this.toggleAdvancedArrayItem(this.filterState.selectedSourceIds, sourceId);
    },
    toggleAdvancedTimePeriod(timePeriodId) {
      this.filterState.selectedTimePeriodIds = this.toggleAdvancedArrayItem(this.filterState.selectedTimePeriodIds, timePeriodId);
    },
    toggleAdvancedIngredient(ingredientId) {
      this.selectedIngredientIds = this.toggleAdvancedArrayItem(this.selectedIngredientIds, ingredientId);
      this.filterState.selectedIngredientIds = [...this.selectedIngredientIds];
    },
    toggleAdvancedTag(tagName) {
      this.filterState.selectedTagNames = this.toggleStringArrayItem(this.filterState.selectedTagNames || [], tagName);
    },
    cocktailHasTag(cocktail, normalizedName) {
      return (cocktail?.tags || []).some((tag) => String(tag.normalizedName || '') === String(normalizedName || ''));
    },
    matchesCocktailEvaluationFilters(evaluation) {
      const cocktail = evaluation.cocktail;
      const matchesMySubmission = !this.filterState.mySubmissionsOnly || this.isMyDrink(cocktail);
      if (!matchesMySubmission) {
        return false;
      }

      if (this.filterState.myApprovedOnly) {
        const isMyApproved = this.isMyDrink(cocktail) && (cocktail.moderationStatus || '').toLowerCase() === 'approved';
        if (!isMyApproved) {
          return false;
        }
      }

      const searchText = (this.filterState.searchText || this.cocktailSearch || '').toLowerCase();
      if (searchText && !(cocktail.name || '').toLowerCase().includes(searchText)) {
        return false;
      }

      if (!this.matchesPopularFilter(cocktail)) {
        return false;
      }

      if (!this.matchesVirginFilter(cocktail.id)) {
        return false;
      }

      if (this.selectedSpirit) {
        const matchesSpirit = evaluation.ingredientRows.some((row) => row.primarySpirit === this.selectedSpirit);
        if (!matchesSpirit) {
          return false;
        }
      }

      if (!this.matchesSelectedIngredientFilters(cocktail.id)) {
        return false;
      }

      if (this.showUntriedOnly && evaluation.canMake && this.hasTriedCocktail(cocktail.id)) {
        return false;
      }

      if (this.filterState.selectedSourceIds.length > 0) {
        const sourceId = Number(cocktail.cocktailSourceId || 0);
        if (!this.filterState.selectedSourceIds.map((id) => Number(id)).includes(sourceId)) {
          return false;
        }
      }

      if (this.filterState.selectedTimePeriodIds.length > 0) {
        const timePeriodId = Number(cocktail.timePeriodId || 0);
        if (!this.filterState.selectedTimePeriodIds.map((id) => Number(id)).includes(timePeriodId)) {
          return false;
        }
      }

      if (this.filterState.selectedFlavorProfiles.length > 0) {
        const flavor = (cocktail.flavorProfile || '').trim().toLowerCase();
        if (!flavor) {
          return false;
        }

        const selected = this.filterState.selectedFlavorProfiles.map((value) => String(value).trim().toLowerCase());
        if (!selected.includes(flavor)) {
          return false;
        }
      }

      if (this.filterState.selectedTagNames.length > 0) {
        const assignedTagNames = new Set((cocktail.tags || []).map((tag) => String(tag.normalizedName || '')));
        const selectedTags = this.filterState.selectedTagNames.map((name) => String(name));
        const matchesTags = this.tagFilterMode === 'any'
          ? selectedTags.some((name) => assignedTagNames.has(name))
          : selectedTags.every((name) => assignedTagNames.has(name));
        if (!matchesTags) {
          return false;
        }
      }

      return true;
    },
    navigateTo(path, { replace = false } = {}) {
      if (typeof window === 'undefined') {
        return;
      }

      const target = path || '/';
      if (replace) {
        window.history.replaceState({}, '', target);
      } else if (window.location.pathname !== target) {
        window.history.pushState({}, '', target);
      }

      this.currentPath = this.getCurrentPath();
    },
    restorePopularOnlyPreference() {
      if (typeof window === 'undefined') {
        return;
      }

      const stored = window.localStorage.getItem(POPULAR_ONLY_STORAGE_KEY);
      if (stored === '0') {
        this.popularOnly = false;
      } else if (stored === '1') {
        this.popularOnly = true;
      }
    },
    async loadInitialData() {
      this.error = '';
      if (typeof document !== 'undefined') {
        document.title = 'Cocktail Chooser';
      }
      try {
        const [cocktails, ingredients, cocktailIngredients, sources, amounts, glassTypes, timePeriods, tagTypes, tags] = await Promise.all([
          getCocktails({ alcohol: this.virginOnly ? 'non-alcoholic' : 'all' }),
          getIngredients(),
          getCocktailIngredients(),
          getCocktailSources(),
          getAmounts(),
          getGlassTypes(),
          getCocktailTimePeriods(),
          getTagTypes(),
          getTags()
        ]);

        this.cocktails = [...cocktails];
        this.allCocktails = [...cocktails];
        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.sources = sources;
        this.amountOptions = amounts;
        this.glassTypeOptions = glassTypes;
        this.timePeriodOptions = timePeriods;
        this.tagTypes = tagTypes;
        this.tags = tags;
        await this.restoreSession();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async restoreSession() {
      if (!getStoredAuthToken()) {
        if (this.isAdminRoute) {
          this.error = 'Log in as admin to access /admin.';
          this.navigateTo('/', { replace: true });
        } else if (this.isMyCocktailsRoute) {
          this.error = 'Log in to access /my-cocktails.';
          this.navigateTo('/', { replace: true });
        }
        return;
      }

      try {
        const user = await getCurrentUser();
        await this.applyAuthenticatedUser(user, { message: '' });
      } catch (err) {
        setAuthToken('');
        this.currentUser = null;
        this.selectedUserId = 0;
        this.cocktailListMode = 'all';
        if (this.isAdminRoute || this.isMyCocktailsRoute) {
          this.error = this.isAdminRoute
            ? 'Log in as admin to access /admin.'
            : 'Log in to access /my-cocktails.';
          this.navigateTo('/', { replace: true });
        }
      }
    },
    async loginUser() {
      this.error = '';
      try {
        const result = await login({
          email: this.loginForm.email,
          password: this.loginForm.password
        });
        await this.applyAuthenticatedUser(result.user, { token: result.token, message: `Welcome back, ${result.user.displayName}.` });
        this.loginForm.password = '';
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async registerUser() {
      this.error = '';
      try {
        const result = await register({
          displayName: this.registerForm.displayName,
          email: this.registerForm.email,
          password: this.registerForm.password
        });
        await this.applyAuthenticatedUser(result.user, { token: result.token, message: `Account created for ${result.user.displayName}.` });
        this.registerForm.displayName = '';
        this.registerForm.email = '';
        this.registerForm.password = '';
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async applyAuthenticatedUser(user, { token = '', message = '' } = {}) {
      if (token) {
        setAuthToken(token);
      }

      this.currentUser = user;
      this.selectedUserId = user.id;
      this.cocktailListMode = 'makeable';
      this.accountMenuOpen = false;
      this.accountMenuView = '';
      this.activeModal = '';
      if (message) {
        this.userSuccessMessage = message;
        setTimeout(() => {
          this.userSuccessMessage = '';
        }, 2500);
      }

      await this.loadInventory();
      await this.loadUserCocktailLogs();
      await this.loadMyCocktails();
      if (this.selectedCocktailId) {
        await this.loadCocktailDetail();
      }

      if (this.isAdminRoute) {
        if (this.isAdminUser) {
          this.openAdminModal();
        } else {
          this.error = 'Admin access is required for /admin.';
          this.navigateTo('/', { replace: true });
        }
      } else if (this.isMyCocktailsRoute && !this.currentUser) {
        this.error = 'Log in to access /my-cocktails.';
        this.navigateTo('/', { replace: true });
      }
    },
    async logout() {
      setAuthToken('');
      this.currentUser = null;
      this.selectedUserId = 0;
      this.cocktailListMode = 'all';
      this.accountMenuOpen = false;
      this.accountMenuView = '';
      this.activeModal = '';
      this.inventory = [];
      this.userCocktailLogs = [];
      this.myCocktails = [];
      this.adminPendingCocktails = [];
      this.myDrinksOnly = false;
      this.myCocktailSearch = '';
      this.myCocktailStatusFilter = 'all';
      this.userSuccessMessage = 'Logged out.';
      if (this.selectedCocktailId) {
        await this.loadCocktailDetail();
      }
      if (this.isAdminRoute) {
        this.navigateTo('/', { replace: true });
      } else if (this.isMyCocktailsRoute) {
        this.navigateTo('/', { replace: true });
      }
      setTimeout(() => {
        this.userSuccessMessage = '';
      }, 2500);
    },
    toggleAccountMenu() {
      this.accountMenuOpen = !this.accountMenuOpen;
      if (this.accountMenuOpen && !this.accountMenuView) {
        this.accountMenuView = this.currentUser ? '' : 'login';
      }
    },
    openAccountView(view) {
      this.accountMenuView = view;
    },
    openAccountModal(defaultView = 'overview') {
      this.accountMenuOpen = false;
      this.activeModal = 'account';
      this.accountMenuView = this.currentUser ? defaultView : (defaultView || 'login');
      if (!this.currentUser && this.accountMenuView === 'overview') {
        this.accountMenuView = 'login';
      }
    },
    openMyBarModal() {
      this.accountMenuOpen = false;
      this.activeModal = 'mybar';
    },
    openAddCocktailModal() {
      this.accountMenuOpen = false;
      this.initializeNewCocktailForm();
      this.activeModal = 'addCocktail';
    },
    openRecipeModal() {
      if (!this.selectedCocktail) {
        return;
      }

      this.accountMenuOpen = false;
      this.activeModal = 'recipe';
    },
    openAdminModal() {
      if (!this.isAdminUser) {
        return;
      }

      this.navigateTo('/admin');
      this.accountMenuOpen = false;
      this.activeModal = 'admin';
      if (this.adminView === 'maintenance') {
        this.loadAdminMaintenanceData();
      } else if (this.adminView === 'taxonomy') {
        this.loadAdminTaxonomyData();
      } else {
        if (!this.adminExportJson) {
          this.loadAdminExportPayload();
        }
        this.loadAdminPendingCocktails();
      }
    },
    async openMyCocktailsPage() {
      if (!this.currentUser) {
        this.openAccountModal('login');
        return;
      }

      this.accountMenuOpen = false;
      this.activeModal = '';
      await this.loadMyCocktails();
      this.navigateTo('/my-cocktails');
    },
    closeActiveModal() {
      if (this.activeModal === 'admin' && this.isAdminRoute) {
        this.navigateTo('/');
      }
      this.activeModal = '';
    },
    async refreshAdminActiveView() {
      if (this.adminView === 'maintenance') {
        await this.loadAdminMaintenanceData();
        return;
      }

      if (this.adminView === 'taxonomy') {
        await this.loadAdminTaxonomyData();
        return;
      }

      await Promise.all([
        this.loadAdminExportPayload(),
        this.loadAdminPendingCocktails()
      ]);
    },
    async loadAdminTaxonomyData() {
      if (!this.isAdminUser) {
        return;
      }

      this.error = '';
      this.adminTaxonomyBusy = true;
      try {
        const [tagTypes, tags, collections] = await Promise.all([
          getTagTypes(),
          getTags(),
          getCollections({ includeSystem: true })
        ]);

        this.tagTypes = tagTypes;
        this.tags = tags;
        this.systemCollections = (collections || [])
          .filter((collection) => Number(collection.isSystemCollection || 0) === 1)
          .sort((a, b) => (a.name || '').localeCompare(b.name || ''));

        if (!this.adminTagTypeId && this.tagTypes.length > 0) {
          this.adminTagTypeId = String(this.tagTypes[0].id);
        }

        if (!this.adminSelectedCollectionId && this.systemCollections.length > 0) {
          this.adminSelectedCollectionId = String(this.systemCollections[0].id);
        } else if (this.adminSelectedCollectionId) {
          await this.loadCollectionCocktailsForAdmin(Number(this.adminSelectedCollectionId));
        }

        if (!this.adminSelectedCollectionId && this.systemCollections.length === 0) {
          this.startNewAdminCollection();
        }
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminTaxonomyBusy = false;
      }
    },
    async refreshCocktailCatalog() {
      const [allCocktails, filteredCocktails] = await Promise.all([
        getCocktails({ alcohol: this.virginOnly ? 'non-alcoholic' : 'all' }),
        this.buildFilteredCocktailRequest()
      ]);
      this.allCocktails = [...allCocktails];
      this.cocktails = filteredCocktails;
    },
    async buildFilteredCocktailRequest() {
      const include = this.selectedIngredientFilterNames;
      const options = {
        alcohol: this.virginOnly ? 'non-alcoholic' : 'all'
      };

      if (include.length > 0) {
        options.include = include;
        options.mode = this.ingredientFilterMode;
      }

      return getCocktails(options);
    },
    toggleAdminTagCocktailSelection(cocktailId) {
      this.adminTagSelectedCocktailIds = this.toggleAdvancedArrayItem(this.adminTagSelectedCocktailIds, cocktailId);
    },
    async applyAdminTagSelection(action) {
      if (!this.selectedAdminTag || this.adminTagSelectedCocktailIds.length === 0) {
        return;
      }

      this.error = '';
      this.adminTaxonomyBusy = true;
      try {
        await Promise.all(this.adminTagSelectedCocktailIds.map((cocktailId) => (
          action === 'remove'
            ? removeTagFromCocktail(cocktailId, this.selectedAdminTag.id)
            : assignTagToCocktail(cocktailId, this.selectedAdminTag.id)
        )));

        await this.refreshCocktailCatalog();
        this.adminTagSelectedCocktailIds = [];
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminTaxonomyBusy = false;
      }
    },
    startNewAdminCollection() {
      this.adminSelectedCollectionId = '';
      this.adminCollectionForm = {
        id: 0,
        name: '',
        description: ''
      };
      this.adminCollectionSelectedCocktailIds = [];
    },
    async loadCollectionCocktailsForAdmin(collectionId) {
      if (!collectionId) {
        return;
      }

      const cocktails = await getCollectionCocktails(collectionId);
      this.collectionCocktailsByCollectionId = {
        ...this.collectionCocktailsByCollectionId,
        [collectionId]: cocktails || []
      };
    },
    toggleAdminCollectionCocktailSelection(cocktailId) {
      this.adminCollectionSelectedCocktailIds = this.toggleAdvancedArrayItem(this.adminCollectionSelectedCocktailIds, cocktailId);
    },
    async saveAdminCollection() {
      if (!this.isAdminUser) {
        return;
      }

      const payload = {
        id: Number(this.adminCollectionForm.id || 0),
        name: (this.adminCollectionForm.name || '').trim(),
        description: (this.adminCollectionForm.description || '').trim() || null,
        ownerUserId: null,
        isSystemCollection: 1
      };

      if (!payload.name) {
        this.error = 'Collection name is required.';
        return;
      }

      this.error = '';
      this.adminTaxonomyBusy = true;
      try {
        if (payload.id > 0) {
          await updateCollection(payload.id, payload);
        } else {
          const created = await createCollection(payload);
          this.adminSelectedCollectionId = String(created.id);
        }

        await this.loadAdminTaxonomyData();
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminTaxonomyBusy = false;
      }
    },
    async deleteAdminCollection() {
      const collectionId = Number(this.adminSelectedCollectionId || 0);
      if (!collectionId) {
        return;
      }

      this.error = '';
      this.adminTaxonomyBusy = true;
      try {
        await deleteCollection(collectionId);
        const { [collectionId]: removedCollectionCocktails, ...remaining } = this.collectionCocktailsByCollectionId;
        void removedCollectionCocktails;
        this.collectionCocktailsByCollectionId = remaining;
        this.startNewAdminCollection();
        await this.loadAdminTaxonomyData();
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminTaxonomyBusy = false;
      }
    },
    async applyAdminCollectionSelection(action) {
      const collectionId = Number(this.adminSelectedCollectionId || 0);
      if (!collectionId || this.adminCollectionSelectedCocktailIds.length === 0) {
        return;
      }

      this.error = '';
      this.adminTaxonomyBusy = true;
      try {
        await Promise.all(this.adminCollectionSelectedCocktailIds.map((cocktailId) => (
          action === 'remove'
            ? removeCocktailFromCollection(collectionId, cocktailId)
            : addCocktailToCollection(collectionId, cocktailId)
        )));
        await this.loadCollectionCocktailsForAdmin(collectionId);
        this.adminCollectionSelectedCocktailIds = [];
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminTaxonomyBusy = false;
      }
    },
    openAdminImportFilePicker() {
      if (this.adminBusy) {
        return;
      }

      const input = this.$refs.adminImportFileInput;
      if (input && typeof input.click === 'function') {
        input.click();
      }
    },
    async handleAdminImportFileSelected(event) {
      const input = event?.target;
      const file = input?.files?.[0];
      if (!file) {
        return;
      }

      this.error = '';
      try {
        const raw = await file.text();
        JSON.parse(raw);
        this.adminImportJson = raw;
        this.adminImportSummary = null;
      } catch (err) {
        this.error = 'Selected file is not valid JSON. Import text was not changed.';
      } finally {
        if (input) {
          input.value = '';
        }
      }
    },
    async loadAdminExportPayload() {
      if (!this.isAdminUser) {
        return;
      }

      this.error = '';
      this.adminBusy = true;
      this.adminImportSummary = null;
      try {
        const payload = await exportAdminCocktails();
        this.adminExportJson = JSON.stringify(payload, null, 2);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminBusy = false;
      }
    },
    async importAdminPayload() {
      if (!this.isAdminUser) {
        return;
      }

      this.error = '';
      this.adminBusy = true;
      this.adminImportSummary = null;
      try {
        const raw = this.adminImportJson.trim();
        if (!raw) {
          throw new Error('Paste import JSON first.');
        }

        const parsed = JSON.parse(raw);
        const requestPayload = Array.isArray(parsed)
          ? { cocktails: parsed }
          : parsed;
        const summary = await importAdminCocktails(requestPayload);
        this.adminImportSummary = summary;
        await this.loadAdminExportPayload();

        const [ingredients, cocktailIngredients, allCocktails] = await Promise.all([
          getIngredients(),
          getCocktailIngredients(),
          getCocktails({ alcohol: this.virginOnly ? 'non-alcoholic' : 'all' })
        ]);

        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.allCocktails = [...allCocktails];
        await this.reloadCocktailsForIngredientFilters();
        await this.loadAdminPendingCocktails();
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminBusy = false;
      }
    },
    async loadAdminPendingCocktails() {
      if (!this.isAdminUser) {
        this.adminPendingCocktails = [];
        return;
      }

      this.adminModerationBusy = true;
      try {
        this.adminPendingCocktails = await getAdminPendingCocktails();
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminModerationBusy = false;
      }
    },
    async loadAdminMaintenanceData() {
      if (!this.isAdminUser) {
        return;
      }

      this.error = '';
      this.adminMaintenanceBusy = true;
      try {
        const [ingredientDuplicates, cocktailDuplicates] = await Promise.all([
          getAdminIngredientDuplicates(),
          getAdminCocktailDuplicates()
        ]);

        this.ingredientDuplicateGroups = ingredientDuplicates?.groups || [];
        this.cocktailDuplicateGroups = cocktailDuplicates?.groups || [];
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminMaintenanceBusy = false;
      }
    },
    parsePositiveId(value, fieldName) {
      const numeric = Number(value);
      if (!Number.isInteger(numeric) || numeric <= 0) {
        throw new Error(`${fieldName} must be a positive integer.`);
      }

      return numeric;
    },
    normalizeOptionalReason(reason) {
      const trimmed = (reason || '').trim();
      return trimmed || null;
    },
    autoFillMergeFormIds(form, keepField, removeField, idValue) {
      const value = String(idValue);

      if (!form[keepField] || form[keepField] === value) {
        form[keepField] = value;
        if (form[removeField] === value) {
          form[removeField] = '';
        }
        return;
      }

      if (!form[removeField] || form[removeField] === value) {
        form[removeField] = value;
        return;
      }

      form[removeField] = value;
      if (form[keepField] === form[removeField]) {
        form[removeField] = '';
      }
    },
    selectIngredientMergeCandidate(ingredientId) {
      this.autoFillMergeFormIds(this.ingredientMergeForm, 'keepIngredientId', 'removeIngredientId', ingredientId);
    },
    selectCocktailMergeCandidate(cocktailId) {
      this.autoFillMergeFormIds(this.cocktailMergeForm, 'keepCocktailId', 'removeCocktailId', cocktailId);
    },
    buildIngredientMergeRequest() {
      const keepIngredientId = this.parsePositiveId(this.ingredientMergeForm.keepIngredientId, 'Keep ingredient ID');
      const removeIngredientId = this.parsePositiveId(this.ingredientMergeForm.removeIngredientId, 'Remove ingredient ID');
      if (keepIngredientId === removeIngredientId) {
        throw new Error('Keep ingredient ID and remove ingredient ID must be different.');
      }

      return {
        keepIngredientId,
        removeIngredientId,
        reason: this.normalizeOptionalReason(this.ingredientMergeForm.reason)
      };
    },
    buildCocktailMergeRequest() {
      const keepCocktailId = this.parsePositiveId(this.cocktailMergeForm.keepCocktailId, 'Keep cocktail ID');
      const removeCocktailId = this.parsePositiveId(this.cocktailMergeForm.removeCocktailId, 'Remove cocktail ID');
      if (keepCocktailId === removeCocktailId) {
        throw new Error('Keep cocktail ID and remove cocktail ID must be different.');
      }

      return {
        keepCocktailId,
        removeCocktailId,
        reason: this.normalizeOptionalReason(this.cocktailMergeForm.reason)
      };
    },
    async runIngredientMergeDryRun() {
      this.error = '';
      this.ingredientMergeResult = null;
      try {
        const request = this.buildIngredientMergeRequest();
        this.adminMaintenanceBusy = true;
        this.ingredientMergePreview = await previewAdminIngredientMerge(request);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminMaintenanceBusy = false;
      }
    },
    async runIngredientMergeApply() {
      this.error = '';
      this.ingredientMergeResult = null;
      try {
        const request = this.buildIngredientMergeRequest();
        this.adminMaintenanceBusy = true;
        this.ingredientMergeResult = await mergeAdminIngredient(request);
        await Promise.all([
          this.loadAdminMaintenanceData(),
          getIngredients().then((ingredients) => { this.ingredients = ingredients; }),
          getCocktailIngredients().then((rows) => { this.cocktailIngredients = rows; })
        ]);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminMaintenanceBusy = false;
      }
    },
    async runCocktailMergeDryRun() {
      this.error = '';
      this.cocktailMergeResult = null;
      try {
        const request = this.buildCocktailMergeRequest();
        this.adminMaintenanceBusy = true;
        this.cocktailMergePreview = await previewAdminCocktailMerge(request);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminMaintenanceBusy = false;
      }
    },
    async runCocktailMergeApply() {
      this.error = '';
      this.cocktailMergeResult = null;
      try {
        const request = this.buildCocktailMergeRequest();
        this.adminMaintenanceBusy = true;
        this.cocktailMergeResult = await mergeAdminCocktail(request);

        const [cocktailIngredients, allCocktails] = await Promise.all([
          getCocktailIngredients(),
          getCocktails({ alcohol: this.virginOnly ? 'non-alcoholic' : 'all' })
        ]);

        this.cocktailIngredients = cocktailIngredients;
        this.allCocktails = [...allCocktails];
        await Promise.all([
          this.reloadCocktailsForIngredientFilters(),
          this.loadAdminMaintenanceData(),
          this.loadAdminPendingCocktails()
        ]);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminMaintenanceBusy = false;
      }
    },
    async approvePendingCocktail(cocktailId) {
      if (!this.isAdminUser || this.adminModerationBusy) {
        return;
      }

      this.adminModerationBusy = true;
      this.error = '';
      try {
        await approveCocktail(cocktailId);
        await Promise.all([
          this.loadAdminPendingCocktails(),
          this.loadMyCocktails(),
          this.reloadCocktailsForIngredientFilters()
        ]);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminModerationBusy = false;
      }
    },
    async rejectPendingCocktail(cocktailId) {
      if (!this.isAdminUser || this.adminModerationBusy) {
        return;
      }

      this.adminModerationBusy = true;
      this.error = '';
      try {
        await rejectCocktail(cocktailId);
        await Promise.all([
          this.loadAdminPendingCocktails(),
          this.loadMyCocktails(),
          this.reloadCocktailsForIngredientFilters()
        ]);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.adminModerationBusy = false;
      }
    },
    downloadAdminImportCsv() {
      const items = this.adminImportSummary?.items || [];
      if (!items.length || typeof window === 'undefined' || typeof document === 'undefined') {
        return;
      }

      const headers = ['inputIndex', 'action', 'cocktailId', 'canonicalKey', 'error'];
      const rows = items.map((item) => [
        item.inputIndex,
        item.action || '',
        item.cocktailId ?? '',
        item.canonicalKey || '',
        item.error || ''
      ]);

      const escapeCell = (value) => {
        const text = String(value ?? '');
        if (text.includes('"') || text.includes(',') || text.includes('\n') || text.includes('\r')) {
          return `"${text.replace(/"/g, '""')}"`;
        }

        return text;
      };

      const csv = [headers, ...rows]
        .map((row) => row.map(escapeCell).join(','))
        .join('\n');

      const blob = new Blob([csv], { type: 'text/csv;charset=utf-8' });
      const url = window.URL.createObjectURL(blob);
      const stamp = new Date().toISOString().replace(/[:.]/g, '-');
      const link = document.createElement('a');
      link.href = url;
      link.download = `admin-import-results-${stamp}.csv`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
    },
    downloadAdminExportJson() {
      const raw = (this.adminExportJson || '').trim();
      if (!raw || typeof window === 'undefined' || typeof document === 'undefined') {
        return;
      }

      const blob = new Blob([raw], { type: 'application/json;charset=utf-8' });
      const url = window.URL.createObjectURL(blob);
      const stamp = new Date().toISOString().replace(/[:.]/g, '-');
      const link = document.createElement('a');
      link.href = url;
      link.download = `admin-cocktails-export-${stamp}.json`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
    },
    initializeNewCocktailForm() {
      this.newCocktailForm.mode = 'paste';
      this.newCocktailForm.rawText = '';
      this.newCocktailForm.name = '';
      this.newCocktailForm.description = '';
      this.newCocktailForm.method = '';
      this.newCocktailForm.glassTypeId = '';
      this.newCocktailForm.timePeriodId = '';
      this.newCocktailForm.ingredientEntries = [this.createEmptyIngredientEntry()];
      this.newCocktailForm.stepEntries = [this.createEmptyStepEntry()];
      this.newCocktailForm.cocktailSourceId = this.preferredMyCocktailsSourceId;
      this.addCocktailPreview = null;
      this.addCocktailPreviewLoading = false;
      this.addCocktailSubmitLoading = false;
      this.lastReviewedRawText = '';
    },
    createEmptyIngredientEntry() {
      return { amountText: '', ingredientName: '' };
    },
    createEmptyStepEntry() {
      return { instruction: '' };
    },
    addIngredientEntry() {
      this.newCocktailForm.ingredientEntries.push(this.createEmptyIngredientEntry());
    },
    removeIngredientEntry(index) {
      if (this.newCocktailForm.ingredientEntries.length <= 1) {
        this.newCocktailForm.ingredientEntries.splice(0, 1, this.createEmptyIngredientEntry());
        return;
      }

      this.newCocktailForm.ingredientEntries.splice(index, 1);
    },
    addStepEntry() {
      this.newCocktailForm.stepEntries.push(this.createEmptyStepEntry());
    },
    addSelectedIngredientFilter() {
      const ingredient = this.selectedIngredientFilterCandidate;
      this.ingredientFilterSearch = '';
      if (!ingredient || this.selectedIngredientIds.includes(ingredient.id)) {
        return;
      }

      this.selectedIngredientIds.push(ingredient.id);
    },
    removeSelectedIngredientFilter(ingredientId) {
      this.selectedIngredientIds = this.selectedIngredientIds.filter((id) => id !== ingredientId);
    },
    clearSelectedIngredientFilters() {
      this.selectedIngredientIds = [];
      this.ingredientFilterSearch = '';
    },
    async reloadCocktailsForIngredientFilters() {
      if (this.ingredients.length === 0) {
        return;
      }

      try {
        this.cocktails = await this.buildFilteredCocktailRequest();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    removeStepEntry(index) {
      if (this.newCocktailForm.stepEntries.length <= 1) {
        this.newCocktailForm.stepEntries.splice(0, 1, this.createEmptyStepEntry());
        return;
      }

      this.newCocktailForm.stepEntries.splice(index, 1);
    },
    buildStructuredIngredientLines() {
      return this.newCocktailForm.ingredientEntries
        .map((row) => {
          const ingredientName = (row.ingredientName || '').trim();
          const amountText = this.normalizeEnteredAmountText(row.amountText);
          if (!ingredientName) {
            return '';
          }

          // Use a comma separator so the backend heuristic parser does not
          // accidentally consume the first ingredient word as part of the amount.
          return amountText ? `${amountText}, ${ingredientName}` : ingredientName;
        })
        .filter(Boolean);
    },
    normalizeEnteredAmountText(value) {
      const raw = (value || '').trim();
      if (!raw) {
        return '';
      }

      if (raw.startsWith('.')) {
        return `0${raw}`;
      }

      return raw.replace(/^-\./, '-0.');
    },
    buildStructuredStepLines() {
      return this.newCocktailForm.stepEntries
        .map((row) => (row.instruction || '').trim())
        .filter(Boolean);
    },
    async reviewNewCocktailPaste() {
      if (!this.canReviewCocktailPaste) {
        return;
      }

      this.error = '';
      this.addCocktailPreviewLoading = true;
      try {
        this.addCocktailPreview = await previewCocktailFromText({
          rawText: this.newCocktailForm.rawText
        });
        this.lastReviewedRawText = this.newCocktailForm.rawText.trim();

        if (!this.addCocktailPreview.isValid) {
          this.error = (this.addCocktailPreview.errors || []).join(' ');
        }

        await this.$nextTick();
        const previewSection = this.$refs.addCocktailPreviewSection;
        if (previewSection && typeof previewSection.scrollIntoView === 'function') {
          previewSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.addCocktailPreviewLoading = false;
      }
    },
    async submitNewCocktailFromPaste() {
      if (!this.selectedUserId) {
        this.error = 'Log in to submit cocktails for approval.';
        return;
      }

      if (!Number(this.newCocktailForm.cocktailSourceId)) {
        this.error = 'Select a source before submitting.';
        return;
      }

      if (!this.addCocktailPreview || !this.addCocktailPreview.isValid) {
        this.error = 'Run Review and fix validation errors before submitting.';
        return;
      }

      this.error = '';
      this.addCocktailSubmitLoading = true;
      try {
        const created = await submitCocktailFromText({
          rawText: this.newCocktailForm.rawText,
          cocktailSourceId: Number(this.newCocktailForm.cocktailSourceId),
          timePeriodIdOverride: this.newCocktailForm.timePeriodId ? Number(this.newCocktailForm.timePeriodId) : null
        });

        const [ingredients, cocktailIngredients] = await Promise.all([
          getIngredients(),
          getCocktailIngredients()
        ]);
        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;

        await Promise.all([
          this.reloadCocktailsForIngredientFilters(),
          this.loadMyCocktails()
        ]);
        this.userSuccessMessage = `Cocktail "${created.name}" submitted for approval.`;
        this.activeModal = '';
        this.reviewSubmittedModalOpen = true;
        setTimeout(() => {
          this.userSuccessMessage = '';
        }, 2500);
      } catch (err) {
        this.error = this.extractError(err);
      } finally {
        this.addCocktailSubmitLoading = false;
      }
    },
    async submitNewCocktail() {
      if (!this.canCreateCocktailEntry) {
        return;
      }

      this.error = '';
      try {
        const ingredientLines = this.buildStructuredIngredientLines();
        const stepLines = this.buildStructuredStepLines();
        const methodText = stepLines.length ? stepLines.join('. ') : null;
        const structuredIngredients = this.newCocktailForm.ingredientEntries
          .map((row) => {
            const amountText = this.normalizeEnteredAmountText(row.amountText);
            const amountMatch = amountText
              ? this.amountOptions.find((a) => (a.name || '').toLowerCase() === amountText.toLowerCase())
              : null;

            return {
              amountId: amountMatch ? Number(amountMatch.id) : null,
              amountText: amountText || null,
              ingredientName: (row.ingredientName || '').trim() || null
            };
          })
          .filter((row) => row.ingredientName);
        const structuredSteps = this.newCocktailForm.stepEntries
          .map((row) => ({
            instruction: (row.instruction || '').trim() || null
          }))
          .filter((row) => row.instruction);

        const created = await createCocktail({
          id: 0,
          name: this.newCocktailForm.name,
          description: this.newCocktailForm.description || null,
          method: methodText,
          ingredientLines: ingredientLines.length ? ingredientLines.join('\n') : null,
          stepLines: stepLines.length ? stepLines.join('\n') : null,
          flavorProfile: null,
          structuredIngredients,
          structuredSteps,
          glassTypeId: this.newCocktailForm.glassTypeId ? Number(this.newCocktailForm.glassTypeId) : null,
          timePeriodId: this.newCocktailForm.timePeriodId ? Number(this.newCocktailForm.timePeriodId) : null,
          isPopular: 0,
          isApproved: 0,
          isUserSubmitted: 1,
          submittedByUserId: this.selectedUserId || null,
          cocktailSourceId: Number(this.newCocktailForm.cocktailSourceId)
        });

        const [ingredients, cocktailIngredients] = await Promise.all([
          getIngredients(),
          getCocktailIngredients()
        ]);

        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        await this.loadMyCocktails();
        this.userSuccessMessage = `Cocktail "${created.name}" submitted for approval.`;
        this.activeModal = '';
        setTimeout(() => {
          this.userSuccessMessage = '';
        }, 2500);
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async loadMyCocktails() {
      this.myCocktails = [];
      if (!this.selectedUserId) {
        return;
      }

      try {
        this.myCocktails = await getMyCocktails();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    showNotImplementedModal(featureName) {
      this.notImplementedFeatureName = featureName || 'This feature';
      this.notImplementedModalOpen = true;
      this.accountMenuOpen = false;
      this.accountMenuView = '';
      this.activeModal = '';
    },
    closeNotImplementedModal() {
      this.notImplementedModalOpen = false;
    },
    closeReviewSubmittedModal() {
      this.reviewSubmittedModalOpen = false;
    },
    async loadInventory() {
      this.inventory = [];
      if (!this.selectedUserId) {
        return;
      }

      try {
        this.inventory = await getUserInventory(this.selectedUserId);
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async loadUserCocktailLogs() {
      this.userCocktailLogs = [];
      if (!this.selectedUserId) {
        return;
      }

      try {
        this.userCocktailLogs = await getUserCocktailTryLogs(this.selectedUserId);
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    isIngredientInStock(ingredientId) {
      return this.inventory.some((x) => x.ingredientId === ingredientId && x.isInStock);
    },
    hasTriedCocktail(cocktailId) {
      return this.triedCocktailIdSet.has(cocktailId);
    },
    isMyDrink(cocktail) {
      if (!this.selectedUserId) {
        return false;
      }

      return Number(cocktail?.submittedByUserId || 0) === Number(this.selectedUserId);
    },
    async toggleIngredientStock(ingredientId, isInStock) {
      if (!this.selectedUserId) {
        return;
      }

      try {
        const row = await upsertUserInventory(this.selectedUserId, ingredientId, { isInStock, notes: null });
        const index = this.inventory.findIndex((x) => x.ingredientId === ingredientId);
        if (index >= 0) {
          this.inventory.splice(index, 1, row);
        } else {
          this.inventory.push(row);
        }
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    canMakeById(cocktailId) {
      const rows = this.cocktailIngredientsByCocktail[cocktailId] || [];
      if (!rows.length) {
        return false;
      }

      return this.getMissingIngredients(cocktailId).length === 0;
    },
    getMissingIngredients(cocktailId) {
      const rows = this.cocktailIngredientsByCocktail[cocktailId] || [];
      const requiredIds = [...new Set(rows.map((x) => x.ingredientId))];
      return this.ingredients.filter((ingredient) =>
        requiredIds.includes(ingredient.id) && !this.inventoryInStockSet.has(ingredient.id));
    },
    matchesSelectedIngredientFilters(cocktailId) {
      if (!this.selectedIngredientIds.length) {
        return true;
      }

      const rows = this.cocktailIngredientsByCocktail[cocktailId] || [];
      const cocktailIngredientIds = new Set(rows.map((row) => Number(row.ingredientId)));
      const cocktailIngredientNames = new Set(
        rows
          .map((row) => (row.ingredientName || '').trim().toLowerCase())
          .filter(Boolean)
      );
      const selectedIds = this.selectedIngredientIds.map((id) => Number(id));
      const selectedNames = new Set(
        this.selectedIngredientFilters
          .map((ingredient) => (ingredient.name || '').trim().toLowerCase())
          .filter(Boolean)
      );

      const matchesOne = (ingredientId) => {
        if (cocktailIngredientIds.has(ingredientId)) {
          return true;
        }

        const selectedIngredient = this.ingredients.find((ingredient) => Number(ingredient.id) === ingredientId);
        if (!selectedIngredient) {
          return false;
        }

        return cocktailIngredientNames.has((selectedIngredient.name || '').trim().toLowerCase());
      };

      if (this.ingredientFilterMode === 'any') {
        if (selectedIds.some(matchesOne)) {
          return true;
        }

        return [...selectedNames].some((name) => cocktailIngredientNames.has(name));
      }

      return selectedIds.every(matchesOne);
    },
    isVirginCocktail(cocktailId) {
      const rows = this.cocktailIngredientsByCocktail[cocktailId] || [];
      const isAlcoholic = rows.some((row) => {
        if ((row.primarySpirit || '').trim().length > 0) {
          return true;
        }

        const ingredientName = (row.ingredientName || '').trim().toLowerCase();
        if (!ingredientName) {
          return false;
        }

        if (ingredientName.includes('non-alcoholic')
          || ingredientName.includes('non alcoholic')
          || ingredientName.includes('alcohol-free')
          || ingredientName.includes('alcohol free')) {
          return false;
        }

        const normalized = ` ${ingredientName.replace(/[^a-z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim()} `;
        return ALCOHOLIC_INGREDIENT_TOKENS.some((token) => normalized.includes(` ${token} `));
      });

      return !isAlcoholic;
    },
    isPopularCocktail(cocktail) {
      return Number(cocktail?.isPopular || 0) === 1;
    },
    moderationStatusLabel(status) {
      const normalized = (status || 'pending').toLowerCase();
      if (normalized === 'approved') {
        return 'Approved';
      }
      if (normalized === 'rejected') {
        return 'Rejected';
      }
      return 'Pending';
    },
    moderationStatusClass(status) {
      const normalized = (status || 'pending').toLowerCase();
      if (normalized === 'approved') {
        return 'status-approved';
      }
      if (normalized === 'rejected') {
        return 'status-rejected';
      }
      return 'status-pending';
    },
    matchesPopularFilter(cocktail) {
      if (!this.popularOnly) {
        return true;
      }

      return this.isPopularCocktail(cocktail);
    },
    matchesVirginFilter(cocktailId) {
      if (!this.virginOnly) {
        return true;
      }

      return this.isVirginCocktail(cocktailId);
    },
    async selectCocktail(cocktailId) {
      this.selectedCocktailId = cocktailId;
      await this.loadCocktailDetail();
      this.openRecipeModal();
    },
    async pickRandomMakeableCocktail() {
      if (this.filteredMakeableCocktails.length === 0) {
        return;
      }

      const index = Math.floor(Math.random() * this.filteredMakeableCocktails.length);
      const cocktail = this.filteredMakeableCocktails[index];
      await this.selectCocktail(cocktail.id);
    },
    async loadCocktailDetail() {
      if (!this.selectedCocktailId) {
        return;
      }

      try {
        const [steps, logs] = await Promise.all([
          getCocktailSteps(this.selectedCocktailId),
          getCocktailTryLogs(this.selectedCocktailId, this.selectedUserId || null)
        ]);

        this.selectedCocktailSteps = steps;
        this.selectedCocktailLogs = logs;
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async submitTryLog() {
      if (!this.selectedUserId || !this.selectedCocktailId) {
        return;
      }

      try {
        const payload = {
          userId: this.selectedUserId,
          cocktailId: this.selectedCocktailId,
          rating: this.newLog.rating,
          comment: this.newLog.comment || null,
          triedOnUtc: this.newLog.triedOnLocal
            ? new Date(this.newLog.triedOnLocal).toISOString()
            : null
        };

        await createCocktailTryLog(payload);

        this.newLog.rating = null;
        this.newLog.comment = '';
        this.newLog.triedOnLocal = '';

        await this.loadUserCocktailLogs();
        await this.loadCocktailDetail();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    sourceNameFor(sourceId) {
      const source = this.sources.find((s) => s.id === sourceId);
      return source ? source.name : 'Unknown source';
    },
    formatDate(utc) {
      if (!utc) {
        return 'Unknown date';
      }

      return new Date(utc).toLocaleString();
    },
    displayAmount(item) {
      const raw = (item?.displayAmount || item?.amountName || item?.amountText || '').trim();
      if (!raw) {
        return '';
      }

      return this.formatAmountTextForDisplay(raw);
    },
    formatAmountTextForDisplay(value) {
      const cleaned = (value || '').trim().replace(/\s+/g, ' ');
      if (!cleaned) {
        return '';
      }

      const normalizedFractions = cleaned
        .replace(/\b1\/4\b/g, '¼')
        .replace(/\b1\/2\b/g, '½')
        .replace(/\b3\/4\b/g, '¾');

      return normalizedFractions.replace(/\b\d+(?:\.\d+)?\b/g, (token) => this.convertDecimalTokenToFraction(token));
    },
    convertDecimalTokenToFraction(token) {
      if (!token.includes('.')) {
        return token;
      }

      const numeric = Number(token);
      if (!Number.isFinite(numeric)) {
        return token;
      }

      const whole = Math.trunc(numeric);
      const fractional = numeric - whole;
      const epsilon = 0.0001;
      let fractionGlyph = '';

      if (Math.abs(fractional - 0.25) < epsilon) {
        fractionGlyph = '¼';
      } else if (Math.abs(fractional - 0.5) < epsilon) {
        fractionGlyph = '½';
      } else if (Math.abs(fractional - 0.75) < epsilon) {
        fractionGlyph = '¾';
      } else if (Math.abs(fractional) < epsilon) {
        return String(whole);
      } else {
        return token;
      }

      if (whole === 0) {
        return fractionGlyph;
      }

      return `${whole}${fractionGlyph}`;
    },
    printSelectedRecipe() {
      if (!this.selectedCocktail || !this.$refs.recipePrintContent) {
        return;
      }

      const printWindow = window.open('', '_blank', 'width=900,height=700');
      if (!printWindow) {
        this.error = 'Unable to open print window. Please allow pop-ups and try again.';
        return;
      }

      const recipeHtml = this.$refs.recipePrintContent.innerHTML;
      const title = this.selectedCocktail.name.replace(/</g, '&lt;').replace(/>/g, '&gt;');

      try {
        printWindow.document.open();
        printWindow.document.write(`<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>${title}</title>
    <style>
      body { font-family: Arial, sans-serif; margin: 24px; color: #222; }
      h1, h2, h3 { margin: 0 0 10px; }
      h1 { font-size: 24px; }
      .subtle { color: #555; }
      .missing-panel { border: 1px dashed #bbb; border-radius: 8px; padding: 10px; margin: 12px 0 16px; }
      .pill { display: inline-block; border: 1px solid #9bcfb8; background: #e7f7ef; padding: 2px 8px; border-radius: 999px; font-size: 12px; }
      .recipe-modal-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
      ul, ol { margin-top: 8px; }
      @media print { body { margin: 0.4in; } }
    </style>
  </head>
  <body>
    <h1>${title}</h1>
    <div>${recipeHtml}</div>
  </body>
</html>`);
        printWindow.document.close();
        printWindow.focus();
        printWindow.addEventListener('load', () => {
          printWindow.print();
        }, { once: true });
      } catch (err) {
        this.error = 'Unable to prepare print preview window.';
      }
    },
    extractError(err) {
      if (typeof err?.response?.data === 'string') {
        return err.response.data;
      }

      return err?.response?.data?.message || err?.message || 'Request failed';
    }
  }
};
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;700&family=Fraunces:opsz,wght@9..144,600&display=swap');

:root {
  --bg: radial-gradient(circle at 20% 10%, #ffe8c9 0%, #f4f7ff 35%, #e5f3ef 100%);
  --panel: rgba(255, 255, 255, 0.84);
  --line: #d4deea;
  --text: #1e2a31;
  --muted: #54656f;
  --accent: #13795b;
  --accent-soft: #e8f8f2;
}

* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: 'Space Grotesk', sans-serif;
  color: var(--text);
  background: var(--bg);
}

.app-shell {
  max-width: 1280px;
  margin: 0 auto;
  padding: 1.25rem;
}

.top-nav-row {
  display: flex;
  justify-content: flex-start;
  margin-bottom: 0.45rem;
}

.info-bar {
  position: sticky;
  top: 0;
  z-index: 10;
  display: grid;
  grid-template-columns: repeat(4, minmax(140px, 1fr));
  gap: 0.5rem;
  margin-bottom: 0.9rem;
  padding: 0.55rem;
  border: 1px solid var(--line);
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(8px);
}

.info-chip {
  background: #fff;
  border: 1px solid var(--line);
  border-radius: 10px;
  padding: 0.45rem 0.6rem;
  display: flex;
  flex-direction: column;
  gap: 0.15rem;
  min-width: 0;
}

.info-chip .label {
  color: var(--muted);
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

.info-chip strong {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.hero {
  margin-bottom: 1rem;
}

.my-bar-inline-hint {
  display: flex;
  align-items: center;
  gap: 0.45rem;
  flex-wrap: wrap;
  margin: -0.15rem 0 0.7rem;
  padding: 0 0.15rem;
  color: var(--muted);
  font-size: 0.92rem;
}

.inline-hint-text {
  white-space: pre-wrap;
  margin-right: 0.8rem;
}

.inline-link-button {
  border: none;
  background: transparent;
  padding: 0;
  color: #0b5a85;
  text-decoration: underline;
  text-underline-offset: 2px;
  border-radius: 0;
}

.secondary-link {
  color: var(--accent);
}

.hero-top {
  display: block;
}

.hero h1 {
  font-family: 'Fraunces', serif;
  margin: 0;
  font-size: 2rem;
}

.hero p {
  margin: 0.35rem 0 0;
  color: var(--muted);
}

.grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(260px, 1fr));
  gap: 1rem;
}

.panel {
  background: var(--panel);
  border: 1px solid var(--line);
  border-radius: 14px;
  backdrop-filter: blur(5px);
  padding: 1rem;
}

.wide {
  grid-column: 1 / -1;
}

.panel-title {
  font-weight: 700;
  margin-bottom: 0.6rem;
}

.subheading {
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  color: var(--muted);
  margin-bottom: 0.4rem;
}

.user-row,
.toolbar {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.toolbar-checkbox {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.45rem 0.15rem;
  color: var(--muted);
  white-space: nowrap;
}

.toolbar .toolbar-checkbox + .toolbar-checkbox {
  margin-left: 0.5rem;
}

.toolbar-checkbox input[type='checkbox'] {
  margin: 0;
}

.search-input-wrap {
  position: relative;
  display: inline-flex;
  align-items: center;
}

.search-input-wrap input {
  padding-right: 2rem;
}

.search-clear-btn {
  position: absolute;
  right: 0.35rem;
  top: 50%;
  transform: translateY(-50%);
  border: 0;
  background: transparent;
  color: var(--muted);
  cursor: pointer;
  font-size: 1rem;
  line-height: 1;
  padding: 0.2rem 0.3rem;
}

.search-clear-btn:hover {
  color: var(--text);
}

.advanced-filters-overlay {
  position: fixed;
  inset: 0;
  background: rgba(16, 26, 34, 0.3);
  z-index: 4000;
}

.advanced-filters-drawer {
  position: fixed;
  top: 0;
  left: 0;
  width: min(32rem, 94vw);
  height: 100dvh;
  background: rgba(255, 255, 255, 0.98);
  border-right: 1px solid var(--line);
  box-shadow: 8px 0 24px rgba(16, 26, 34, 0.16);
  z-index: 4001;
  transform: translateX(-100%);
  transition: transform 180ms ease;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.advanced-filters-drawer.open {
  transform: translateX(0);
}

.advanced-filters-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.5rem;
  padding: 0.75rem;
  border-bottom: 1px solid var(--line);
  position: sticky;
  top: 0;
  z-index: 2;
  background: rgba(255, 255, 255, 0.98);
}

.advanced-collapse-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 2.25rem;
  font-weight: 700;
  line-height: 1;
}

.advanced-collapse-hitarea {
  display: inline-flex;
  align-items: center;
  gap: 0.45rem;
  border: none;
  background: transparent;
  padding: 0;
  cursor: pointer;
}

.advanced-collapse-hitarea strong {
  font: inherit;
}

.advanced-filters-body {
  padding: 0.75rem;
  overflow-y: visible;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.advanced-group {
  border: 1px solid var(--line);
  border-radius: 10px;
  padding: 0.55rem;
  background: #fff;
}

.advanced-group .toolbar-checkbox {
  width: 100%;
  white-space: normal;
  align-items: flex-start;
  line-height: 1.25;
  padding-top: 0.3rem;
  padding-bottom: 0.3rem;
}

.advanced-group .toolbar-checkbox input[type='checkbox'] {
  margin-top: 0.15rem;
  flex-shrink: 0;
}

.advanced-tag-group {
  margin-top: 0.55rem;
  display: flex;
  flex-direction: column;
  gap: 0.18rem;
}

.advanced-tag-group strong {
  margin-bottom: 0.2rem;
}

.advanced-header-actions {
  justify-content: flex-end;
}

.advanced-ingredient-search {
  width: 100%;
  margin-bottom: 0.4rem;
}

.advanced-ingredient-search input {
  width: 100%;
}

.advanced-ingredient-mode-select {
  margin-bottom: 0.4rem;
}

.advanced-ingredient-expand {
  margin-top: 0.55rem;
}

.advanced-selected-ingredient {
  background: #eef8f3;
  border-radius: 8px;
  border: 1px solid #d6ece0;
  padding-left: 0.35rem;
}

.advanced-ingredient-divider {
  margin: 0.45rem 0 0.2rem;
  padding-top: 0.45rem;
  border-top: 1px dashed var(--line);
  color: var(--muted);
  font-size: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

input,
select,
textarea,
button {
  border: 1px solid var(--line);
  border-radius: 10px;
  padding: 0.5rem 0.7rem;
  font: inherit;
}

button {
  background: var(--accent-soft);
  cursor: pointer;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.floating-message {
  margin: -0.35rem 0 0.85rem;
}

.app-menu {
  position: relative;
  flex-shrink: 0;
}

.menu-trigger {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.92);
  border-radius: 999px;
  padding: 0.4rem 0.65rem;
}

.menu-trigger-text {
  font-weight: 600;
}

.user-icon {
  width: 1.8rem;
  height: 1.8rem;
  border-radius: 999px;
  display: grid;
  place-items: center;
  background: #fff;
  border: 1px solid var(--line);
  font-weight: 700;
  color: var(--accent);
}

.hamburger-icon {
  width: 1.15rem;
  display: inline-flex;
  flex-direction: column;
  gap: 0.18rem;
}

.hamburger-icon span {
  display: block;
  width: 100%;
  height: 2px;
  border-radius: 999px;
  background: #27424f;
}

.app-menu-dropdown {
  position: absolute;
  left: 0;
  right: auto;
  top: calc(100% + 0.4rem);
  width: min(24rem, 92vw);
  background: rgba(255, 255, 255, 0.96);
  border: 1px solid var(--line);
  border-radius: 14px;
  box-shadow: 0 12px 30px rgba(21, 37, 48, 0.12);
  padding: 0.75rem;
  z-index: 20;
}

.menu-user-summary {
  display: flex;
  align-items: center;
  gap: 0.55rem;
  margin-bottom: 0.65rem;
}

.account-summary {
  display: flex;
  flex-direction: column;
  gap: 0.15rem;
  margin-bottom: 0.6rem;
}

.menu-actions {
  display: flex;
  gap: 0.4rem;
  flex-wrap: wrap;
}

.menu-button {
  background: #fff;
}

.advanced-toggle-button {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  font-weight: 700;
}

.advanced-toggle-chevron {
  letter-spacing: -0.03em;
  min-width: 1.5rem;
  text-align: center;
}

.advanced-toggle-icon {
  width: 0.95rem;
  height: 0.95rem;
  fill: currentColor;
}

.menu-button.active {
  background: var(--accent);
  color: #fff;
  border-color: #0f6048;
  font-weight: 700;
  box-shadow: 0 0 0 2px rgba(19, 121, 91, 0.2);
}

.account-pane {
  margin-top: 0.6rem;
  padding-top: 0.55rem;
  border-top: 1px solid var(--line);
}

.auth-stack {
  display: flex;
  flex-direction: column;
  gap: 0.45rem;
}

.structured-list {
  display: flex;
  flex-direction: column;
  gap: 0.45rem;
}

.structured-row {
  display: grid;
  grid-template-columns: minmax(8rem, 11rem) minmax(0, 1fr) auto;
  gap: 0.45rem;
  align-items: center;
}

.structured-step-row {
  grid-template-columns: minmax(0, 1fr) auto;
}

.add-row-button {
  justify-self: flex-start;
}

.row-remove {
  white-space: nowrap;
}

.account-help {
  margin: 0.6rem 0 0;
  font-size: 0.82rem;
}

.modal-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(18, 28, 36, 0.42);
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 0.75rem 1rem;
  z-index: 40;
  overflow-y: auto;
}

.modal-card {
  width: min(28rem, 100%);
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid var(--line);
  border-radius: 16px;
  box-shadow: 0 18px 42px rgba(21, 37, 48, 0.18);
  padding: 1rem;
  max-height: calc(100dvh - 1.5rem);
  overflow-y: auto;
  margin-top: 0;
}

.modal-card-wide {
  width: min(34rem, 100%);
}

.modal-card-xl {
  width: min(44rem, 100%);
}

.modal-card h2 {
  margin: 0 0 0.4rem;
  font-family: 'Fraunces', serif;
  font-size: 1.25rem;
}

.modal-card p {
  margin: 0.35rem 0;
}

.modal-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 0.75rem;
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.5rem;
  margin-bottom: 0.35rem;
}

.modal-header h2 {
  margin: 0;
}

.add-cocktail-modal {
  display: flex;
  flex-direction: column;
}

.add-cocktail-modal .auth-stack {
  min-height: 0;
}

.add-cocktail-actions {
  position: sticky;
  bottom: 0;
  background: rgba(255, 255, 255, 0.98);
  padding-top: 0.35rem;
  padding-bottom: 0.2rem;
  border-top: 1px solid var(--line);
  z-index: 2;
}

.modal-inventory {
  max-height: min(65vh, 34rem);
}

.list,
.inventory {
  margin-top: 0.75rem;
  max-height: 360px;
  overflow: auto;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.list-item {
  display: flex;
  justify-content: space-between;
  background: #fff;
}

.list-item.active {
  border-color: var(--accent);
}

.pill {
  background: #d6f4e8;
  color: #0d5a42;
  border-radius: 999px;
  padding: 0.1rem 0.5rem;
  font-size: 0.75rem;
}

.pill.status-approved {
  background: #d9f6e7;
  color: #0d5a42;
}

.pill.status-pending {
  background: #fff2cf;
  color: #8a5a00;
}

.pill.status-rejected {
  background: #ffe4e6;
  color: #9f1239;
}

.tried-pill {
  margin-left: 0.4rem;
  background: #eef2ff;
  color: #2f3ea8;
  border: 1px solid #cfd7ff;
  border-radius: 999px;
  padding: 0.05rem 0.45rem;
  font-size: 0.72rem;
}

.virgin-pill {
  margin-left: 0.4rem;
  background: #f4e9ff;
  color: #5c2f93;
  border: 1px solid #d9b8ff;
  border-radius: 999px;
  padding: 0.05rem 0.45rem;
  font-size: 0.72rem;
}

.inventory-row {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.inventory-row small,
.subtle {
  color: var(--muted);
}

.match-list {
  margin: 0.75rem 0 0;
  padding: 0;
  list-style: none;
  column-width: 18rem;
  column-gap: 1rem;
}

.match-list li {
  break-inside: avoid;
  display: flex;
  align-items: center;
  margin-bottom: 0.35rem;
}

.match-list button {
  border: none;
  background: transparent;
  color: #0b5a85;
  padding: 0;
  text-align: left;
}

.detail {
  margin-top: 1rem;
}

.detail-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.5rem;
}

.detail-header .panel-title {
  margin-bottom: 0;
}

.missing-panel {
  background: #fff;
  border: 1px dashed var(--line);
  border-radius: 10px;
  padding: 0.7rem;
  margin: 0.75rem 0 1rem;
}

.missing-panel ul {
  margin: 0.4rem 0 0;
  padding-left: 1.1rem;
}

.detail-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.recipe-modal-grid {
  margin-top: 0.3rem;
}

.admin-block {
  border: 1px solid var(--line);
  border-radius: 10px;
  background: #fff;
  padding: 0.75rem;
}

.admin-selection-list {
  margin-top: 0.45rem;
  max-height: min(38vh, 20rem);
  overflow-y: auto;
  border: 1px solid var(--line);
  border-radius: 10px;
  background: #fbfcfd;
}

.admin-selection-row {
  display: grid;
  grid-template-columns: auto minmax(0, 1fr) auto;
  align-items: center;
  gap: 0.55rem;
  padding: 0.45rem 0.6rem;
  border-bottom: 1px solid #e8edf3;
  cursor: pointer;
}

.admin-selection-row:last-child {
  border-bottom: none;
}

.admin-selection-row:hover {
  background: #f4f8fb;
}

.admin-selection-row input[type='checkbox'] {
  margin: 0;
}

.admin-selection-row span:nth-child(2) {
  min-width: 0;
  overflow-wrap: anywhere;
}

.pill-assigned {
  background: #e8f8f2;
  border: 1px solid #9cd4bc;
  color: #10694f;
}

.pill-unassigned {
  background: #f6edf9;
  border: 1px solid #d8c1e7;
  color: #6f3f88;
}

.tag-pill-row {
  display: flex;
  flex-wrap: wrap;
  gap: 0.35rem;
  margin: 0.55rem 0 0.8rem;
}

.admin-tab-row {
  margin-bottom: 0.5rem;
}

.menu-link-button {
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.admin-duplicate-groups {
  display: flex;
  flex-direction: column;
  gap: 0.7rem;
  max-height: min(40vh, 22rem);
  overflow-y: auto;
}

.admin-duplicate-group {
  border: 1px solid var(--line);
  border-radius: 10px;
  padding: 0.55rem;
  background: #fcfefe;
}

.admin-duplicate-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.76rem;
}

.admin-duplicate-table th,
.admin-duplicate-table td {
  border: 1px solid var(--line);
  padding: 0.25rem 0.3rem;
  text-align: left;
  vertical-align: top;
}

.admin-duplicate-row {
  cursor: pointer;
}

.admin-duplicate-row:hover {
  background: #f3faf7;
}

.admin-preview,
.admin-result {
  margin: 0.55rem 0 0;
  border: 1px solid var(--line);
  border-radius: 10px;
  background: #f7fafc;
  padding: 0.55rem;
  max-height: 10rem;
  overflow: auto;
  font-size: 0.74rem;
  white-space: pre-wrap;
  word-break: break-word;
}

.admin-result {
  background: #edf8f2;
}

.admin-hidden-file-input {
  display: none;
}

.admin-export-panel textarea {
  width: 100%;
}

.admin-export-actions {
  justify-content: center;
}

.admin-import-results {
  margin-top: 0.8rem;
}

.admin-import-results h4 {
  margin: 0 0 0.35rem;
  font-size: 0.95rem;
}

.admin-import-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.78rem;
}

.admin-import-table th,
.admin-import-table td {
  border: 1px solid var(--line);
  padding: 0.3rem 0.35rem;
  text-align: left;
  vertical-align: top;
}

.admin-import-row-created {
  background: #ecf8f2;
}

.admin-import-row-updated {
  background: #eef4ff;
}

.admin-import-row-failed {
  background: #fff0f1;
}

.admin-import-error {
  color: #8c1028;
  max-width: 16rem;
  word-break: break-word;
}

.recipe-print-content h3 {
  margin: 0 0 0.35rem;
}

.log-form {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.empty {
  color: var(--muted);
}

.error {
  color: #8c1028;
  margin-top: 1rem;
  font-weight: 600;
}

.success {
  color: #0d5a42;
  margin-top: 0.4rem;
  font-weight: 600;
}

@media (max-width: 900px) {
  .advanced-filters-drawer {
    width: 100vw;
    max-width: 100vw;
    border-right: none;
    box-shadow: none;
  }

  .info-bar {
    display: none;
  }

  .grid,
  .detail-grid {
    grid-template-columns: 1fr;
  }

  .structured-row {
    grid-template-columns: 1fr;
  }

  .hero-top {
    display: block;
  }

  .my-bar-inline-hint {
    align-items: flex-start;
  }

  .menu-trigger {
    justify-content: flex-start;
  }

  .app-menu-dropdown {
    left: 0;
    right: auto;
    width: min(24rem, calc(100vw - 2rem));
    max-width: calc(100vw - 2rem);
  }

  .app-menu-dropdown .menu-actions {
    flex-direction: column;
    align-items: stretch;
  }

  .app-menu-dropdown .menu-actions .menu-button,
  .app-menu-dropdown .menu-actions .menu-link-button {
    width: 100%;
    justify-content: center;
  }

  .match-list {
    column-width: auto;
    column-count: 1;
  }

  .admin-import-table {
    font-size: 0.72rem;
  }
}
</style>
