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

### Mobile shell setup with Capacitor

The frontend now includes Capacitor configuration for native iOS and Android shells.

Useful commands:

```bash
npm run cap:add:ios
npm run cap:add:android
npm run cap:sync:build
npm run cap:open:ios
npm run cap:open:android
```

Notes:

- `npm run cap:sync:build` rebuilds the Vue app and copies the web assets into the native projects
- The first platform add creates native folders for `ios` and `android`
- API endpoint strategy for simulator/device builds is tracked separately because `/api` proxy behavior only works in browser dev mode

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

## Mobile API environment strategy

Browser development and native mobile builds do not resolve the API the same way.

Current behavior:

- Browser dev defaults to `/api` and uses the Vue dev proxy from `vue.config.js`
- Native Android defaults to `http://10.0.2.2:5190/api`
- Native iOS defaults to `http://localhost:5190/api`

Recommended overrides:

```bash
VUE_APP_NATIVE_API_BASE_URL=http://192.168.1.50:5190/api
VUE_APP_ANDROID_API_BASE_URL=http://10.0.2.2:5190/api
VUE_APP_IOS_API_BASE_URL=http://localhost:5190/api
```

Notes:

- `10.0.2.2` is the Android emulator alias for the host machine localhost
- Physical Android devices should use your dev machine LAN IP instead of `10.0.2.2`
- `VUE_APP_API_BASE_URL` overrides all environments if you want one explicit target
- The generated Android project currently allows cleartext HTTP traffic to support local development against `http://localhost:5190`

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
