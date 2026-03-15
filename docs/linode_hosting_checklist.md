# Linode Hosting Checklist

Use this checklist when adding or moving sites on the shared Linode so one site's deployment does not accidentally break another.

## Current model

- `nginx` terminates TLS and routes each domain by `server_name`
- each app has its own `systemd` service
- each backend listens on its own localhost port
- static sites can be served directly by `nginx`
- ASP.NET apps require both `Microsoft.AspNetCore.App` and `Microsoft.NETCore.App` runtimes unless published self-contained

## Per-site inventory

Record these for every hosted app:

- domain and any `www` aliases
- nginx config file path
- systemd service name
- working directory
- backend listen port, if any
- deploy target directory
- runtime requirement such as `aspnetcore-runtime-8.0`

Example inventory for CocktailChooser:

- domain: `cocktailchooser.com`, `www.cocktailchooser.com`
- nginx config: `/etc/nginx/sites-enabled/cocktailchooser.com`
- systemd service: `cocktailchooser.service`
- working directory: `/opt/cocktailchooser/publish`
- backend port: `127.0.0.1:5000`
- deploy root: `/opt/cocktailchooser`
- runtime: `.NET 8`, framework-dependent publish

## New-site checklist

Before enabling a new site:

- confirm the new domain has its own nginx `server_name`
- confirm the backend port is unique on the box
- confirm the systemd service name is unique
- confirm the app's runtime is installed
- run `sudo nginx -t`
- restart only the intended service
- verify the existing sites still return healthy responses

## Useful commands

List web-facing services:

```bash
systemctl list-units --type=service | grep -Ei 'nginx|apache|caddy|httpd|dotnet|node|pm2|cocktail'
```

List listening web ports:

```bash
sudo ss -ltnp | grep -E ':80|:443|:5000|:5001|:3000|:8080'
```

Inspect nginx domain routing:

```bash
grep -RniE 'server_name|proxy_pass|listen' /etc/nginx/sites-enabled
```

Check installed .NET runtimes:

```bash
dotnet --list-runtimes
```

Check a service and its logs:

```bash
sudo systemctl status cocktailchooser --no-pager -l
sudo journalctl -u cocktailchooser -n 200 --no-pager
```

## Deployment guardrail

Homepage checks alone are not enough for SPA plus API deployments. A site can return `200` for `/` while the API is failing behind nginx with `502`.

At minimum, smoke tests should verify:

- homepage loads
- API responds

For CocktailChooser, verify both:

```bash
curl -fI https://cocktailchooser.com
curl -fI https://cocktailchooser.com/health
```
