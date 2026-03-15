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

## Optional developer contact action

The admin panel can show a `Send a message to the developer` button.

Configure it with frontend environment variables:

```bash
VUE_APP_DEVELOPER_CONTACT_MODE=email
VUE_APP_DEVELOPER_CONTACT_EMAIL=you@example.com
VUE_APP_DEVELOPER_CONTACT_PHONE=15551234567
VUE_APP_DEVELOPER_CONTACT_SUBJECT=CocktailChooser admin note
VUE_APP_DEVELOPER_CONTACT_BODY=Hi, I have a note from the CocktailChooser admin panel.
```

Notes:

- Set `VUE_APP_DEVELOPER_CONTACT_MODE=sms` to prefer text messages.
- If SMS is preferred but no phone number is set, the app falls back to email when an email address is configured.
- These values are compiled into the frontend bundle, so they should be treated as deploy-time public config.
