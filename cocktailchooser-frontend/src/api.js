import axios from 'axios';

const api = axios.create({
  baseURL: process.env.VUE_APP_API_BASE_URL || '/api',
  timeout: 15000
});

export async function getCocktails() {
  const { data } = await api.get('/cocktails');
  return data;
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

export async function createCocktailTryLog(payload) {
  const { data } = await api.post('/cocktailtrylogs', payload);
  return data;
}

export async function getCocktailGroupingsByCocktail(cocktailId) {
  const { data } = await api.get(`/cocktailgroupings/by-cocktail/${cocktailId}`);
  return data;
}

export async function getCocktailSources() {
  const { data } = await api.get('/recipesources');
  return data;
}
