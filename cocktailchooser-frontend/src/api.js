import axios from 'axios';

const AUTH_TOKEN_KEY = 'cocktailchooser.authToken';

const api = axios.create({
  baseURL: process.env.VUE_APP_API_BASE_URL || '/api',
  timeout: 15000
});

let authToken = typeof window !== 'undefined' ? window.localStorage.getItem(AUTH_TOKEN_KEY) || '' : '';

api.interceptors.request.use((config) => {
  if (authToken) {
    config.headers = config.headers || {};
    config.headers.Authorization = `Bearer ${authToken}`;
  }

  return config;
});

export function setAuthToken(token) {
  authToken = token || '';
  if (typeof window !== 'undefined') {
    if (authToken) {
      window.localStorage.setItem(AUTH_TOKEN_KEY, authToken);
    } else {
      window.localStorage.removeItem(AUTH_TOKEN_KEY);
    }
  }
}

export function getStoredAuthToken() {
  return authToken;
}

export async function getCocktails(options = {}) {
  const params = {};
  if (Array.isArray(options.include) && options.include.length > 0) {
    params.include = options.include.join(',');
  }
  if (options.mode) {
    params.mode = options.mode;
  }
  if (options.alcohol) {
    params.alcohol = options.alcohol;
  }
  if (Array.isArray(options.tags) && options.tags.length > 0) {
    params.tags = options.tags.join(',');
  }
  if (options.tagMode) {
    params.tagMode = options.tagMode;
  }

  const { data } = await api.get('/cocktails', { params });
  return data;
}

export async function createCocktail(payload) {
  const { data } = await api.post('/cocktails', payload);
  return data;
}

export async function previewCocktailFromText(payload) {
  const { data } = await api.post('/cocktails/preview-from-text', payload);
  return data;
}

export async function submitCocktailFromText(payload) {
  const { data } = await api.post('/cocktails/submit-from-text', payload);
  return data;
}

export async function getMyPendingCocktails() {
  const { data } = await api.get('/cocktails/my-pending');
  return data;
}

export async function getMyCocktails() {
  const { data } = await api.get('/cocktails/mine');
  return data;
}

export async function getAdminPendingCocktails() {
  const { data } = await api.get('/cocktails/admin/pending');
  return data;
}

export async function approveCocktail(cocktailId) {
  await api.post(`/cocktails/${cocktailId}/approve`);
}

export async function rejectCocktail(cocktailId) {
  await api.post(`/cocktails/${cocktailId}/reject`);
}

export async function getIngredients() {
  const { data } = await api.get('/ingredients');
  return data;
}

export async function getUsers() {
  const { data } = await api.get('/users');
  return data;
}

export async function createUser(payload) {
  const { data } = await api.post('/users', payload);
  return data;
}

export async function register(payload) {
  const { data } = await api.post('/auth/register', payload);
  return data;
}

export async function login(payload) {
  const { data } = await api.post('/auth/login', payload);
  return data;
}

export async function getCurrentUser() {
  const { data } = await api.get('/auth/me');
  return data;
}

export async function getUserInventory(userId) {
  const { data } = await api.get(`/users/${userId}/inventory`);
  return data;
}

export async function upsertUserInventory(userId, ingredientId, payload) {
  const { data } = await api.put(`/users/${userId}/inventory/${ingredientId}`, payload);
  return data;
}

export async function getCocktailIngredients() {
  const { data } = await api.get('/cocktailingredients');
  return data;
}

export async function getCocktailSteps(cocktailId) {
  const { data } = await api.get(`/cocktailrecipes/${cocktailId}`);
  return data;
}

export async function getCocktailTryLogs(cocktailId, userId) {
  const params = { cocktailId };
  if (userId) {
    params.userId = userId;
  }

  const { data } = await api.get('/cocktailtrylogs', { params });
  return data;
}

export async function getUserCocktailTryLogs(userId) {
  const { data } = await api.get('/cocktailtrylogs', { params: { userId } });
  return data;
}

export async function createCocktailTryLog(payload) {
  const { data } = await api.post('/cocktailtrylogs', payload);
  return data;
}

export async function getCocktailGroupingsByCocktail(cocktailId) {
  const { data } = await api.get(`/cocktailgroupings/by-cocktail/${cocktailId}`);
  return data;
}

export async function getCocktailGroupingNames() {
  const { data } = await api.get('/cocktailgroupings/names');
  return data;
}

export async function upsertCocktailGrouping(payload) {
  const { data } = await api.post('/cocktailgroupings', payload);
  return data;
}

export async function renameCocktailGrouping(payload) {
  await api.put('/cocktailgroupings/rename', payload);
}

export async function getCocktailsByGroupingName(groupingName) {
  const { data } = await api.get(`/cocktailgroupings/${encodeURIComponent(groupingName)}/cocktails`);
  return data;
}

export async function deleteCocktailGrouping(cocktailId, cocktailSourceId, groupingName) {
  await api.delete('/cocktailgroupings', {
    params: {
      cocktailId,
      cocktailSourceId,
      groupingName
    }
  });
}

export async function getCocktailSources() {
  const { data } = await api.get('/recipesources');
  return data;
}

export async function getAmounts() {
  const { data } = await api.get('/lookups/amounts');
  return data;
}

export async function getGlassTypes() {
  const { data } = await api.get('/lookups/glass-types');
  return data;
}

export async function getCocktailTimePeriods() {
  const { data } = await api.get('/lookups/time-periods');
  return data;
}

export async function exportAdminCocktails({ sourceId = null, offset = null, limit = null } = {}) {
  const params = {};
  if (sourceId) {
    params.sourceId = sourceId;
  }
  if (offset !== null && offset !== undefined) {
    params.offset = offset;
  }
  if (limit !== null && limit !== undefined) {
    params.limit = limit;
  }

  const { data } = await api.get('/cocktails/admin/export', { params });
  return data;
}

export async function exportAdminCocktail(cocktailId) {
  const { data } = await api.get(`/cocktails/admin/export/${cocktailId}`);
  return data;
}

export async function importAdminCocktails(payload) {
  const { data } = await api.post('/cocktails/admin/import', payload);
  return data;
}

export async function getAdminIngredientDuplicates() {
  const { data } = await api.get('/admin/maintenance/ingredient-duplicates');
  return data;
}

export async function getAdminCocktailDuplicates() {
  const { data } = await api.get('/admin/maintenance/cocktail-duplicates');
  return data;
}

export async function previewAdminIngredientMerge(payload) {
  const { data } = await api.post('/admin/maintenance/ingredient-merge/dry-run', payload);
  return data;
}

export async function mergeAdminIngredient(payload) {
  const { data } = await api.post('/admin/maintenance/ingredient-merge', payload);
  return data;
}

export async function previewAdminCocktailMerge(payload) {
  const { data } = await api.post('/admin/maintenance/cocktail-merge/dry-run', payload);
  return data;
}

export async function mergeAdminCocktail(payload) {
  const { data } = await api.post('/admin/maintenance/cocktail-merge', payload);
  return data;
}

export async function getTagTypes() {
  const { data } = await api.get('/tags/types');
  return data;
}

export async function getTags({ tagTypeId = null, tagType = null } = {}) {
  const params = {};
  if (tagTypeId) {
    params.tagTypeId = tagTypeId;
  }
  if (tagType) {
    params.tagType = tagType;
  }

  const { data } = await api.get('/tags', { params });
  return data;
}

export async function getCocktailTags(cocktailId) {
  const { data } = await api.get(`/tags/cocktails/${cocktailId}`);
  return data;
}

export async function assignTagToCocktail(cocktailId, tagId) {
  await api.post(`/tags/cocktails/${cocktailId}/${tagId}`);
}

export async function removeTagFromCocktail(cocktailId, tagId) {
  await api.delete(`/tags/cocktails/${cocktailId}/${tagId}`);
}

export async function getCollections({ includeSystem = true, ownerUserId = null } = {}) {
  const params = { includeSystem };
  if (ownerUserId) {
    params.ownerUserId = ownerUserId;
  }

  const { data } = await api.get('/collections', { params });
  return data;
}

export async function getMyCollections({ includeSystem = true } = {}) {
  const { data } = await api.get('/collections/mine', { params: { includeSystem } });
  return data;
}

export async function getCollection(collectionId) {
  const { data } = await api.get(`/collections/${collectionId}`);
  return data;
}

export async function getCollectionCocktails(collectionId) {
  const { data } = await api.get(`/collections/${collectionId}/cocktails`);
  return data;
}

export async function createCollection(payload) {
  const { data } = await api.post('/collections', payload);
  return data;
}

export async function updateCollection(collectionId, payload) {
  await api.put(`/collections/${collectionId}`, payload);
}

export async function deleteCollection(collectionId) {
  await api.delete(`/collections/${collectionId}`);
}

export async function addCocktailToCollection(collectionId, cocktailId) {
  await api.post(`/collections/${collectionId}/cocktails`, { cocktailId });
}

export async function removeCocktailFromCollection(collectionId, cocktailId) {
  await api.delete(`/collections/${collectionId}/cocktails/${cocktailId}`);
}
