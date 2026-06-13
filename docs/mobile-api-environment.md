# Mobile API Environment Strategy

This document captures the initial API target strategy for issue `#106`.

## Goal

Support the same frontend codebase across:

- browser development
- Android emulator development
- future iOS simulator development
- staging and production mobile builds

## Current Defaults

The frontend resolves the API base URL in this order:

1. `VUE_APP_API_BASE_URL`
2. If running in Capacitor native mode:
   - `VUE_APP_NATIVE_API_BASE_URL`
   - Android: `VUE_APP_ANDROID_API_BASE_URL`
   - iOS: `VUE_APP_IOS_API_BASE_URL`
3. Fallback defaults:
   - browser web app: `/api`
   - Android emulator: `http://10.0.2.2:5190/api`
   - iOS simulator: `http://localhost:5190/api`

## Why Android Is Different

Android emulators do not treat `localhost` as the Windows host machine running the API.

For Android Emulator, use:

```text
http://10.0.2.2:5190/api
```

That host alias maps back to the development machine.

## Recommended Development Setups

### Browser development

- Run the API locally on `http://localhost:5190`
- Run `npm run serve`
- Let the Vue dev proxy handle `/api`

### Android emulator development

- Run the API locally on `http://localhost:5190`
- Build the frontend with:

```bash
VUE_APP_ANDROID_API_BASE_URL=http://10.0.2.2:5190/api npm run cap:sync:build
```

- Open the Android project with:

```bash
npm run cap:open:android
```

### Physical Android device

Use the development machine's LAN IP instead of `10.0.2.2`, for example:

```bash
VUE_APP_NATIVE_API_BASE_URL=http://192.168.1.50:5190/api npm run cap:sync:build
```

Requirements:

- phone and development machine on the same network
- local firewall allows access to port `5190`
- API binding is reachable from the LAN if needed

### Staging / production mobile builds

Use explicit environment variables during build:

```bash
VUE_APP_API_BASE_URL=https://your-host/api npm run cap:sync:build
```

## Android Networking Note

The generated Android project currently sets:

```xml
android:usesCleartextTraffic="true"
```

This is intentional for local development against the current HTTP API endpoint.

Before production release, we should move mobile builds to HTTPS and decide whether to narrow or remove broad cleartext support.

## iOS Note

iOS is kept aligned in configuration shape via `VUE_APP_IOS_API_BASE_URL`, but current development focus remains Android-first on Windows.

If we later run iOS simulator builds on macOS, `http://localhost:5190/api` is the expected default starting point.
