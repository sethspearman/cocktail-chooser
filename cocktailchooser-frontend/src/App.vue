<template>
  <div class="app-shell">
    <section class="info-bar">
      <div class="info-chip">
        <span class="label">You Can Make</span>
        <strong>{{ makeableCocktails.length }}</strong>
      </div>
      <div class="info-chip">
        <span class="label">Filtered Matches</span>
        <strong>{{ filteredMakeableCocktails.length }}</strong>
      </div>
      <div class="info-chip wide-chip">
        <span class="label">Last Tried</span>
        <strong>{{ lastTriedSummary }}</strong>
      </div>
      <div class="info-chip wide-chip">
        <span class="label">Next Ingredient</span>
        <strong>{{ nextIngredientRecommendationSummary }}</strong>
      </div>
    </section>

    <header class="hero">
      <h1>Cocktail Chooser</h1>
      <p>Track what's in your bar, discover what you can make, and log what you try.</p>
    </header>

    <section class="panel">
      <div class="panel-title">User</div>
      <div class="subheading">Create User</div>
      <div class="user-row">
        <select v-model.number="selectedUserId" @change="handleUserChange">
          <option :value="0">Select a user</option>
          <option v-for="user in users" :key="user.id" :value="user.id">
            {{ user.displayName }}
          </option>
        </select>

        <input v-model.trim="newUser.displayName" placeholder="Display name (required)" />
        <input v-model.trim="newUser.email" placeholder="Email (optional)" />
        <button :disabled="!canCreateUser" @click="createUserAndSelect">Add User</button>
      </div>
      <p v-if="userValidationMessage" class="subtle">{{ userValidationMessage }}</p>
      <p v-if="userSuccessMessage" class="success">{{ userSuccessMessage }}</p>
    </section>

    <section class="grid">
      <article class="panel">
        <div class="panel-title">Cocktails</div>
        <div class="toolbar">
          <input v-model.trim="cocktailSearch" placeholder="Search cocktails" />
          <select v-model="selectedSpirit">
            <option value="">All spirits</option>
            <option v-for="spirit in spirits" :key="spirit" :value="spirit">{{ spirit }}</option>
          </select>
        </div>

        <div class="list">
          <button
            v-for="cocktail in filteredCocktails"
            :key="cocktail.id"
            :class="['list-item', { active: selectedCocktailId === cocktail.id }]"
            @click="selectCocktail(cocktail.id)">
            <span>{{ cocktail.name }}</span>
            <span v-if="canMakeById(cocktail.id)" class="pill">Can make</span>
          </button>
        </div>
      </article>

      <article class="panel">
        <div class="panel-title">My Bar</div>
        <div v-if="!selectedUserId" class="empty">Select a user to manage inventory.</div>
        <template v-else>
          <div class="toolbar">
            <input v-model.trim="ingredientSearch" placeholder="Search ingredients" />
            <select v-model="inventorySpiritFilter">
              <option value="">All</option>
              <option v-for="spirit in spirits" :key="`inv-${spirit}`" :value="spirit">{{ spirit }}</option>
            </select>
          </div>
          <div class="inventory">
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
      </article>

      <article class="panel wide">
        <div class="panel-title">What Can I Drink</div>
        <div class="toolbar">
          <select v-model="makeableTriedFilter">
            <option value="all">All makeable</option>
            <option value="untried">Only untried</option>
          </select>
          <button :disabled="filteredMakeableCocktails.length === 0" @click="pickRandomMakeableCocktail">
            Random Pick From Filtered List
          </button>
        </div>
        <div v-if="!selectedUserId" class="empty">Select a user to compute matches.</div>
        <div v-else-if="filteredMakeableCocktails.length === 0" class="empty">No full matches for the current filters. Try another spirit or add more ingredients.</div>
        <ul v-else class="match-list">
          <li v-for="cocktail in filteredMakeableCocktails" :key="`match-${cocktail.id}`">
            <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
            <span v-if="hasTriedCocktail(cocktail.id)" class="tried-pill" title="Tried / logged">Tried</span>
          </li>
        </ul>
      </article>
    </section>

    <section class="panel detail" v-if="selectedCocktail">
      <div class="panel-title">{{ selectedCocktail.name }}</div>
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
              <span v-if="item.amountText" class="subtle">({{ item.amountText }})</span>
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
  </div>
</template>

<script>
import {
  createCocktailTryLog,
  createUser,
  getCocktailIngredients,
  getCocktailSources,
  getCocktailSteps,
  getCocktailTryLogs,
  getUserCocktailTryLogs,
  getCocktails,
  getIngredients,
  getUserInventory,
  getUsers,
  upsertUserInventory
} from './api';

export default {
  name: 'App',
  data() {
    return {
      cocktails: [],
      ingredients: [],
      cocktailIngredients: [],
      users: [],
      inventory: [],
      sources: [],
      userCocktailLogs: [],

      selectedUserId: 0,
      selectedCocktailId: 0,

      selectedCocktailSteps: [],
      selectedCocktailLogs: [],

      cocktailSearch: '',
      ingredientSearch: '',
      selectedSpirit: '',
      inventorySpiritFilter: '',
      makeableTriedFilter: 'all',

      newUser: {
        displayName: '',
        email: ''
      },
      newLog: {
        rating: null,
        comment: '',
        triedOnLocal: ''
      },

      userSuccessMessage: '',
      error: ''
    };
  },
  computed: {
    spirits() {
      return [...new Set(this.ingredients.map((x) => x.primarySpirit).filter(Boolean))].sort();
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

        if (!this.selectedSpirit) {
          return true;
        }

        const rows = this.cocktailIngredientsByCocktail[cocktail.id] || [];
        return rows.some((row) => row.primarySpirit === this.selectedSpirit);
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

      return this.cocktails.filter((c) => this.canMakeById(c.id));
    },
    filteredMakeableCocktails() {
      return this.makeableCocktails.filter((cocktail) => {
        if (this.selectedSpirit) {
          const rows = this.cocktailIngredientsByCocktail[cocktail.id] || [];
          const matchesSpirit = rows.some((row) => row.primarySpirit === this.selectedSpirit);
          if (!matchesSpirit) {
            return false;
          }
        }

        if (this.makeableTriedFilter === 'untried' && this.hasTriedCocktail(cocktail.id)) {
          return false;
        }

        return true;
      });
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
        return 'Select a user';
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

      this.cocktails.forEach((cocktail) => {
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
        return 'Select a user';
      }

      if (!this.nextIngredientRecommendation) {
        return 'No single-ingredient unlock recommendation yet';
      }

      const { ingredient, count } = this.nextIngredientRecommendation;
      return `${ingredient.name} (+${count} cocktails)`;
    },
    canCreateUser() {
      return this.newUser.displayName.trim().length > 0;
    },
    userValidationMessage() {
      if (this.canCreateUser) {
        return '';
      }

      return 'Enter a display name to create a user.';
    }
  },
  async created() {
    await this.loadInitialData();
  },
  methods: {
    async loadInitialData() {
      this.error = '';
      try {
        const [cocktails, ingredients, cocktailIngredients, users, sources] = await Promise.all([
          getCocktails(),
          getIngredients(),
          getCocktailIngredients(),
          getUsers(),
          getCocktailSources()
        ]);

        this.cocktails = cocktails;
        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.users = users;
        this.sources = sources;

        if (users.length) {
          this.selectedUserId = users[0].id;
          await this.loadInventory();
          await this.loadUserCocktailLogs();
        }
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async createUserAndSelect() {
      if (!this.newUser.displayName) {
        this.error = 'Display name is required.';
        return;
      }

      this.error = '';
      try {
        const user = await createUser({
          displayName: this.newUser.displayName,
          email: this.newUser.email || null
        });

        this.users.push(user);
        this.selectedUserId = user.id;
        this.newUser.displayName = '';
        this.newUser.email = '';
        this.userSuccessMessage = `User "${user.displayName}" created and selected.`;
        setTimeout(() => {
          this.userSuccessMessage = '';
        }, 2500);
        await this.loadInventory();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async handleUserChange() {
      await this.loadInventory();
      await this.loadUserCocktailLogs();
      if (this.selectedCocktailId) {
        await this.loadCocktailDetail();
      }
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
    async selectCocktail(cocktailId) {
      this.selectedCocktailId = cocktailId;
      await this.loadCocktailDetail();
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
    extractError(err) {
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
    grid-template-columns: 1fr;
    position: static;
  }

  .grid,
  .detail-grid {
    grid-template-columns: 1fr;
  }

  .match-list {
    column-width: auto;
    column-count: 1;
  }
}
</style>
