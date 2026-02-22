<template>
  <div class="app-shell">
    <header class="hero">
      <h1>Cocktail Chooser</h1>
      <p>Track your bar, discover what you can make, and log what you try.</p>
    </header>

    <section class="panel">
      <div class="panel-title">User</div>
      <div class="user-row">
        <select v-model.number="selectedUserId" @change="handleUserChange">
          <option :value="0">Select a user</option>
          <option v-for="user in users" :key="user.id" :value="user.id">
            {{ user.displayName }}
          </option>
        </select>

        <input v-model.trim="newUser.displayName" placeholder="Display name" />
        <input v-model.trim="newUser.email" placeholder="Email (optional)" />
        <button @click="createUserAndSelect">Add User</button>
      </div>
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
        <div v-if="!selectedUserId" class="empty">Select a user to compute matches.</div>
        <div v-else-if="makeableCocktails.length === 0" class="empty">No full matches yet. Add more ingredients in My Bar.</div>
        <ul v-else class="match-list">
          <li v-for="cocktail in makeableCocktails" :key="`match-${cocktail.id}`">
            <button @click="selectCocktail(cocktail.id)">{{ cocktail.name }}</button>
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
          <h3>Groupings</h3>
          <ul>
            <li v-for="link in selectedCocktailGroupings" :key="`grp-${link.cocktailSourceId}-${link.groupingName}`">
              <button class="link-btn" @click="loadGroupingResults(link.groupingName)">{{ link.groupingName }}</button>
              <button class="delete-btn" @click="deleteGroupingLink(link)">Delete</button>
            </li>
          </ul>
          <div class="grouping-form">
            <h4>Add Grouping Link</h4>
            <select v-model.number="groupingDraft.cocktailSourceId">
              <option :value="null">Select source</option>
              <option v-for="source in sources" :key="`src-${source.id}`" :value="source.id">
                {{ source.name }}
              </option>
            </select>
            <input
              v-model.trim="groupingDraft.groupingName"
              list="grouping-name-options"
              placeholder="Grouping name (e.g., Gin and Tonics)" />
            <datalist id="grouping-name-options">
              <option v-for="name in groupingNames" :key="`name-${name}`" :value="name" />
            </datalist>
            <button @click="addGroupingLink">Add Link</button>
          </div>
          <div class="grouping-form">
            <h4>Rename Grouping Link</h4>
            <select v-model.number="renameDraft.cocktailSourceId">
              <option :value="null">Select source</option>
              <option v-for="source in sources" :key="`rename-src-${source.id}`" :value="source.id">
                {{ source.name }}
              </option>
            </select>
            <input v-model.trim="renameDraft.groupingName" placeholder="Current grouping name" />
            <input v-model.trim="renameDraft.newGroupingName" placeholder="New grouping name" />
            <button @click="renameGroupingLink">Rename Link</button>
          </div>

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

    <section class="panel" style="margin-top: 1rem;">
      <div class="panel-title">Browse Groupings</div>
      <div class="toolbar">
        <input
          v-model.trim="groupingQuery"
          list="grouping-query-options"
          placeholder="Grouping name (e.g., Gin and Tonics)" />
        <datalist id="grouping-query-options">
          <option v-for="name in groupingNames" :key="`query-name-${name}`" :value="name" />
        </datalist>
        <button @click="searchGroupingCocktails">Search Group</button>
      </div>
      <div v-if="groupingCocktails.length === 0" class="empty">No grouping results loaded yet.</div>
      <ul v-else class="match-list">
        <li v-for="row in groupingCocktails" :key="`group-row-${row.cocktailId}-${row.cocktailSourceId}`">
          <button @click="selectCocktail(row.cocktailId)">{{ row.cocktailName }}</button>
          <span class="subtle"> · {{ row.groupingName }} · {{ row.cocktailSourceName }}</span>
        </li>
      </ul>
    </section>

    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<script>
import {
  deleteCocktailGrouping,
  createCocktailTryLog,
  createUser,
  getCocktailGroupingNames,
  getCocktailsByGroupingName,
  getCocktailGroupingsByCocktail,
  getCocktailIngredients,
  getCocktailSources,
  getCocktailSteps,
  getCocktailTryLogs,
  getCocktails,
  getIngredients,
  getUserInventory,
  getUsers,
  renameCocktailGrouping,
  upsertCocktailGrouping,
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

      selectedUserId: 0,
      selectedCocktailId: 0,

      selectedCocktailSteps: [],
      selectedCocktailLogs: [],
      selectedCocktailGroupings: [],
      groupingCocktails: [],
      groupingNames: [],

      cocktailSearch: '',
      ingredientSearch: '',
      selectedSpirit: '',
      inventorySpiritFilter: '',
      groupingQuery: '',

      newUser: {
        displayName: '',
        email: ''
      },
      newLog: {
        rating: null,
        comment: '',
        triedOnLocal: ''
      },
      groupingDraft: {
        cocktailSourceId: null,
        groupingName: ''
      },
      renameDraft: {
        cocktailSourceId: null,
        groupingName: '',
        newGroupingName: ''
      },

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
    selectedCocktailIngredients() {
      return this.cocktailIngredientsByCocktail[this.selectedCocktailId] || [];
    },
    missingIngredientsForSelected() {
      if (!this.selectedCocktailId) {
        return [];
      }

      return this.getMissingIngredients(this.selectedCocktailId);
    }
  },
  async created() {
    await this.loadInitialData();
  },
  methods: {
    async loadInitialData() {
      this.error = '';
      try {
        const [groupingNames, cocktails, ingredients, cocktailIngredients, users, sources] = await Promise.all([
          getCocktailGroupingNames(),
          getCocktails(),
          getIngredients(),
          getCocktailIngredients(),
          getUsers(),
          getCocktailSources()
        ]);

        this.groupingNames = groupingNames;
        this.cocktails = cocktails;
        this.ingredients = ingredients;
        this.cocktailIngredients = cocktailIngredients;
        this.users = users;
        this.sources = sources;

        if (users.length) {
          this.selectedUserId = users[0].id;
          await this.loadInventory();
        }
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async createUserAndSelect() {
      if (!this.newUser.displayName) {
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
        await this.loadInventory();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async handleUserChange() {
      await this.loadInventory();
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
    isIngredientInStock(ingredientId) {
      return this.inventory.some((x) => x.ingredientId === ingredientId && x.isInStock);
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
    async loadCocktailDetail() {
      if (!this.selectedCocktailId) {
        return;
      }

      try {
        const [steps, logs, groupings] = await Promise.all([
          getCocktailSteps(this.selectedCocktailId),
          getCocktailTryLogs(this.selectedCocktailId, this.selectedUserId || null),
          getCocktailGroupingsByCocktail(this.selectedCocktailId)
        ]);

        this.selectedCocktailSteps = steps;
        this.selectedCocktailLogs = logs;
        this.selectedCocktailGroupings = groupings;

        this.groupingDraft.cocktailSourceId = this.selectedCocktail?.cocktailSourceId || null;
        this.renameDraft.cocktailSourceId = this.selectedCocktail?.cocktailSourceId || null;
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async addGroupingLink() {
      if (!this.selectedCocktailId || !this.groupingDraft.cocktailSourceId || !this.groupingDraft.groupingName) {
        return;
      }

      try {
        await upsertCocktailGrouping({
          cocktailId: this.selectedCocktailId,
          cocktailSourceId: this.groupingDraft.cocktailSourceId,
          groupingName: this.groupingDraft.groupingName
        });
        await this.refreshGroupingNames();
        this.groupingDraft.groupingName = '';
        await this.loadCocktailDetail();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async renameGroupingLink() {
      if (
        !this.selectedCocktailId
        || !this.renameDraft.cocktailSourceId
        || !this.renameDraft.groupingName
        || !this.renameDraft.newGroupingName
      ) {
        return;
      }

      try {
        await renameCocktailGrouping({
          cocktailId: this.selectedCocktailId,
          cocktailSourceId: this.renameDraft.cocktailSourceId,
          groupingName: this.renameDraft.groupingName,
          newGroupingName: this.renameDraft.newGroupingName
        });
        await this.refreshGroupingNames();
        this.renameDraft.groupingName = '';
        this.renameDraft.newGroupingName = '';
        await this.loadCocktailDetail();
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async deleteGroupingLink(link) {
      try {
        await deleteCocktailGrouping(link.cocktailId, link.cocktailSourceId, link.groupingName);
        await this.refreshGroupingNames();
        await this.loadCocktailDetail();
        if (this.groupingQuery === link.groupingName) {
          await this.loadGroupingResults(this.groupingQuery);
        }
      } catch (err) {
        this.error = this.extractError(err);
      }
    },
    async refreshGroupingNames() {
      this.groupingNames = await getCocktailGroupingNames();
    },
    async searchGroupingCocktails() {
      if (!this.groupingQuery) {
        return;
      }

      await this.loadGroupingResults(this.groupingQuery);
    },
    async loadGroupingResults(groupingName) {
      try {
        this.groupingQuery = groupingName;
        this.groupingCocktails = await getCocktailsByGroupingName(groupingName);
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
  margin: 0;
  padding-left: 1rem;
}

.match-list button {
  border: none;
  background: transparent;
  color: #0b5a85;
  padding: 0;
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

.grouping-form {
  margin-bottom: 0.75rem;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.grouping-form h4 {
  margin: 0.25rem 0 0;
  font-size: 0.9rem;
}

.link-btn {
  border: none;
  background: transparent;
  color: #0b5a85;
  padding: 0;
}

.delete-btn {
  margin-left: 0.5rem;
  background: #feecef;
  color: #9b1030;
  border-color: #f4c5d0;
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

@media (max-width: 900px) {
  .grid,
  .detail-grid {
    grid-template-columns: 1fr;
  }
}
</style>
