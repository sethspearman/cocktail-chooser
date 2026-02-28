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
            <button type="button" class="menu-button" @click="openAddCocktailModal">Add a Cocktail</button>
            <button type="button" class="menu-button" @click="openMyBarModal">My Bar Checklist</button>
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
        <strong>{{ filteredMakeableCocktails.length }}</strong>
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

    <section class="grid">
      <article class="panel wide">
        <div class="panel-title">What Can I Drink</div>
        <div class="toolbar">
          <select v-model="cocktailListMode">
            <option value="makeable">What Can I Drink</option>
            <option value="all">Show All Cocktails</option>
          </select>
          <input v-model.trim="cocktailSearch" placeholder="Search cocktails" />
          <select v-model="selectedSpirit">
            <option value="">All spirits</option>
            <option v-for="spirit in spirits" :key="spirit" :value="spirit">{{ spirit }}</option>
          </select>
          <select v-model="ingredientFilterMode">
            <option value="all">Search Ingredients (All):</option>
            <option value="any">Search Ingredients (Any):</option>
          </select>
          <input
            v-model.trim="ingredientFilterSearch"
            list="cocktail-ingredient-filter-options"
            @change="addSelectedIngredientFilter"
            @keyup.enter.prevent="addSelectedIngredientFilter"
            placeholder="Find Ingredient..." />
          <label class="toolbar-checkbox">
            <input v-model="virginOnly" type="checkbox" />
            Virgin drinks only
          </label>
          <label class="toolbar-checkbox">
            <input v-model="popularOnly" type="checkbox" />
            Popular only
          </label>
          <datalist id="cocktail-ingredient-filter-options">
            <option
              v-for="ingredient in ingredientFilterOptions"
              :key="`filter-ing-${ingredient.id}`"
              :value="ingredient.name">
            </option>
          </datalist>
          <select v-model="makeableTriedFilter" :disabled="cocktailListMode !== 'makeable'">
            <option value="all">Show Tried and Untried</option>
            <option value="untried">Show Untried Only</option>
          </select>
          <button
            :disabled="cocktailListMode !== 'makeable' || filteredMakeableCocktails.length === 0"
            @click="pickRandomMakeableCocktail">
            Pick One for Me
          </button>
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
          <li v-for="cocktail in visibleCocktails" :key="`match-${cocktail.id}`">
            <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
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
              <span v-if="item.amountName || item.amountText" class="subtle">({{ item.amountName || item.amountText }})</span>
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
                  <span v-if="item.amountName || item.amountText" class="subtle">({{ item.amountName || item.amountText }})</span>
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
      <div class="modal-card modal-card-wide">
        <div class="modal-header">
          <h2 id="add-cocktail-modal-title">Add a Cocktail</h2>
          <button type="button" class="menu-button" @click="closeActiveModal">Close</button>
        </div>

        <div class="auth-stack">
          <input v-model.trim="newCocktailForm.name" placeholder="Cocktail name" />
          <textarea v-model.trim="newCocktailForm.description" placeholder="Description (optional)"></textarea>
          <select v-model.number="newCocktailForm.cocktailSourceId">
            <option :value="0">Select source</option>
            <option v-for="source in sources" :key="`src-${source.id}`" :value="source.id">
              {{ source.name }}
            </option>
          </select>
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

          <div class="menu-actions">
            <button type="button" :disabled="!canCreateCocktailEntry" @click="submitNewCocktail">Save Cocktail Recipe</button>
            <button type="button" class="menu-button" @click="closeActiveModal">Cancel</button>
          </div>
        </div>

        <datalist id="ingredient-options">
          <option v-for="ingredient in ingredients" :key="`ing-opt-${ingredient.id}`" :value="ingredient.name"></option>
        </datalist>
        <datalist id="amount-options">
          <option v-for="amount in amountOptions" :key="`amt-opt-${amount.id}`" :value="amount.name"></option>
        </datalist>

        <p class="subtle account-help">
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
  </div>
</template>

<script>
import {
  createCocktail,
  createCocktailTryLog,
  getAmounts,
  getCocktailIngredients,
  getCocktailSources,
  getCocktailSteps,
  getCocktailTimePeriods,
  getCurrentUser,
  getCocktailTryLogs,
  getUserCocktailTryLogs,
  getCocktails,
  getGlassTypes,
  getIngredients,
  getUserInventory,
  getStoredAuthToken,
  login,
  register,
  setAuthToken,
  upsertUserInventory
} from './api';

const POPULAR_ONLY_STORAGE_KEY = 'cocktailchooser.popularOnly';

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
      popularOnly: true,
      ingredientFilterMode: 'all',
      ingredientFilterSearch: '',
      selectedIngredientIds: [],
      cocktailListMode: 'all',
      inventorySpiritFilter: '',
      makeableTriedFilter: 'all',

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
      notImplementedModalOpen: false,
      notImplementedFeatureName: 'This feature'
    };
  },
  computed: {
    spirits() {
      return [...new Set(this.ingredients.map((x) => x.primarySpirit).filter(Boolean))].sort();
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
      this.cocktails.forEach((c) => {
        map[c.id] = c;
      });
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
    filteredCocktails() {
      return this.cocktails.filter((cocktail) => {
        const matchesSearch = !this.cocktailSearch
          || cocktail.name.toLowerCase().includes(this.cocktailSearch.toLowerCase());

        if (!matchesSearch) {
          return false;
        }

        if (!this.matchesPopularFilter(cocktail)) {
          return false;
        }

        if (!this.matchesVirginFilter(cocktail.id)) {
          return false;
        }

        if (!this.selectedSpirit) {
          return this.matchesSelectedIngredientFilters(cocktail.id);
        }

        const rows = this.cocktailIngredientsByCocktail[cocktail.id] || [];
        const matchesSpirit = rows.some((row) => row.primarySpirit === this.selectedSpirit);
        if (!matchesSpirit) {
          return false;
        }

        return this.matchesSelectedIngredientFilters(cocktail.id);
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

      return this.allCocktails.filter((c) => this.canMakeById(c.id));
    },
    filteredMakeableCocktails() {
      return this.makeableCocktails.filter((cocktail) => {
        const matchesSearch = !this.cocktailSearch
          || cocktail.name.toLowerCase().includes(this.cocktailSearch.toLowerCase());
        if (!matchesSearch) {
          return false;
        }

        if (!this.matchesPopularFilter(cocktail)) {
          return false;
        }

        if (!this.matchesVirginFilter(cocktail.id)) {
          return false;
        }

        if (this.selectedSpirit) {
          const rows = this.cocktailIngredientsByCocktail[cocktail.id] || [];
          const matchesSpirit = rows.some((row) => row.primarySpirit === this.selectedSpirit);
          if (!matchesSpirit) {
            return false;
          }
        }

        if (!this.matchesSelectedIngredientFilters(cocktail.id)) {
          return false;
        }

        if (this.makeableTriedFilter === 'untried' && this.hasTriedCocktail(cocktail.id)) {
          return false;
        }

        return true;
      });
    },
    visibleCocktails() {
      return this.cocktailListMode === 'all'
        ? this.filteredCocktails
        : this.filteredMakeableCocktails;
    },
    combinedCocktailListEmptyMessage() {
      if (this.cocktailListMode === 'makeable' && !this.selectedUserId) {
        return 'Log in to see what you can make from My Bar.';
      }

      if (this.visibleCocktails.length > 0) {
        return '';
      }

      if (this.cocktailListMode === 'all') {
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
    preferredMyCocktailsSourceId() {
      const userAddedExact = this.sources.find((s) => (s.name || '').toLowerCase() === 'user added');
      const userAddedFuzzy = this.sources.find((s) => (s.name || '').toLowerCase().includes('user add'));
      const exact = this.sources.find((s) => (s.name || '').toLowerCase() === 'my cocktails');
      const fuzzy = this.sources.find((s) => (s.name || '').toLowerCase().includes('my cocktail'));
      return userAddedExact?.id || userAddedFuzzy?.id || exact?.id || fuzzy?.id || this.sources[0]?.id || 0;
    },
    canCreateCocktailEntry() {
      const hasIngredient = this.newCocktailForm.ingredientEntries.some((x) => (x.ingredientName || '').trim().length > 0);
      const hasStep = this.newCocktailForm.stepEntries.some((x) => (x.instruction || '').trim().length > 0);
      return this.newCocktailForm.name.trim().length > 0
        && Number(this.newCocktailForm.cocktailSourceId) > 0
        && hasIngredient
        && hasStep;
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
    selectedIngredientIds: {
      deep: true,
      async handler() {
        await this.reloadCocktailsForIngredientFilters();
      }
    },
    async ingredientFilterMode() {
      await this.reloadCocktailsForIngredientFilters();
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
    }
  },
  async created() {
    this.restorePopularOnlyPreference();
    await this.loadInitialData();
  },
  methods: {
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
        const [cocktails, ingredients, cocktailIngredients, sources, amounts, glassTypes, timePeriods] = await Promise.all([
          getCocktails({ alcohol: this.virginOnly ? 'non-alcoholic' : 'all' }),
          getIngredients(),
          getCocktailIngredients(),
          getCocktailSources(),
          getAmounts(),
          getGlassTypes(),
          getCocktailTimePeriods()
        ]);

        this.cocktails = [...cocktails];
        this.allCocktails = [...cocktails];
        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.sources = sources;
        this.amountOptions = amounts;
        this.glassTypeOptions = glassTypes;
        this.timePeriodOptions = timePeriods;
        await this.restoreSession();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async restoreSession() {
      if (!getStoredAuthToken()) {
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
      if (this.selectedCocktailId) {
        await this.loadCocktailDetail();
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
      this.userSuccessMessage = 'Logged out.';
      if (this.selectedCocktailId) {
        await this.loadCocktailDetail();
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
    closeActiveModal() {
      this.activeModal = '';
    },
    initializeNewCocktailForm() {
      this.newCocktailForm.name = '';
      this.newCocktailForm.description = '';
      this.newCocktailForm.method = '';
      this.newCocktailForm.glassTypeId = '';
      this.newCocktailForm.timePeriodId = '';
      this.newCocktailForm.ingredientEntries = [this.createEmptyIngredientEntry()];
      this.newCocktailForm.stepEntries = [this.createEmptyStepEntry()];
      this.newCocktailForm.cocktailSourceId = this.preferredMyCocktailsSourceId;
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
        const include = this.selectedIngredientFilterNames;
        const options = {
          alcohol: this.virginOnly ? 'non-alcoholic' : 'all'
        };

        if (include.length > 0) {
          options.include = include;
          options.mode = this.ingredientFilterMode;
        }

        this.cocktails = await getCocktails(options);
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
          cocktailSourceId: Number(this.newCocktailForm.cocktailSourceId)
        });

        const [ingredients, cocktailIngredients] = await Promise.all([
          getIngredients(),
          getCocktailIngredients()
        ]);

        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.cocktails.push(created);
        this.cocktails.sort((a, b) => (a.name || '').localeCompare(b.name || ''));
        this.allCocktails.push(created);
        this.allCocktails.sort((a, b) => (a.name || '').localeCompare(b.name || ''));
        this.userSuccessMessage = `Cocktail "${created.name}" added.`;
        this.activeModal = '';
        await this.selectCocktail(created.id);
        setTimeout(() => {
          this.userSuccessMessage = '';
        }, 2500);
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

.toolbar-checkbox input[type='checkbox'] {
  margin: 0;
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
  display: grid;
  place-items: center;
  padding: 1rem;
  z-index: 40;
}

.modal-card {
  width: min(28rem, 100%);
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid var(--line);
  border-radius: 16px;
  box-shadow: 0 18px 42px rgba(21, 37, 48, 0.18);
  padding: 1rem;
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
    width: 100%;
  }

  .match-list {
    column-width: auto;
    column-count: 1;
  }
}
</style>
