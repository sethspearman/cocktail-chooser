# Android Emulator Quickstart

This is the fastest path to a first local Android run for the Capacitor mobile shell.

## Prerequisites

- Android Studio installed on Windows
- An Android emulator created in Android Studio
- The API running locally on the development machine

## Start The API

From repo root:

```bash
./tools/dotnet run --project CocktailChooser.API
```

The default development API URL is:

```text
http://localhost:5190
```

## Sync The Mobile App For Android Emulator

From `cocktailchooser-frontend`:

```bash
VUE_APP_ANDROID_API_BASE_URL=http://10.0.2.2:5190/api npm run cap:sync:build
```

Why `10.0.2.2`:

- Android Emulator cannot use the host machine via `localhost`
- `10.0.2.2` routes back to the Windows host machine

## Open The Native Android Project

```bash
npm run cap:open:android
```

This opens the generated project in Android Studio.

## Run The App

In Android Studio:

1. Let Gradle sync finish
2. Select an emulator/device
3. Run the `app` configuration

## Common Local Variants

### Physical Android device

Use your machine's LAN IP instead of `10.0.2.2`:

```bash
VUE_APP_NATIVE_API_BASE_URL=http://192.168.1.50:5190/api npm run cap:sync:build
```

### Hosted/staging API

```bash
VUE_APP_API_BASE_URL=https://your-host/api npm run cap:sync:build
```

## Notes

- Browser dev mode still uses the Vue dev proxy and `/api`
- Android local development currently allows cleartext HTTP for local API access
- Before production mobile release, API traffic should move to HTTPS
