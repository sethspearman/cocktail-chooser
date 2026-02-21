# cocktailchooser-frontend

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

Runs on `http://localhost:8080` by default.
In development, `/api/*` requests are proxied to `http://localhost:5190` (configured in `vue.config.js`).

Before starting frontend dev server, start the API from repo root:

```bash
./tools/dotnet run --project CocktailChooser.API
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

## Optional API base override

You can point the frontend at another API URL by setting:

```bash
VUE_APP_API_BASE_URL=http://your-api-host/api
```
