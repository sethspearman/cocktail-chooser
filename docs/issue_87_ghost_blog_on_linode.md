# Issue 87: Ghost Blog on Shared Linode

This runbook stands up `https://blog.cocktailchooser.com` on the existing Linode without disturbing the current Cocktail Chooser site.

## Why this approach

- Keep `nginx` in control of domain routing.
- Give the blog its own localhost port and its own `systemd` service.
- Avoid letting Ghost auto-edit shared `nginx` or SSL configuration.
- Verify both the new blog and the existing sites before cutover is considered complete.

## Planned inventory

- domain: `blog.cocktailchooser.com`
- app directory: `/opt/ghost-blog`
- content directory: `/opt/ghost-blog/content`
- runtime user: `ghostblog`
- backend port: `127.0.0.1:2368`
- nginx config: `/etc/nginx/sites-available/blog.cocktailchooser.com`
- systemd service: `ghost-blog.service`

## Safe deployment sequence

1. Capture the current Linode state before changing anything.
2. Add DNS for `blog.cocktailchooser.com`.
3. Install Ghost into its own directory and bind it to `127.0.0.1:2368`.
4. Add a dedicated `nginx` site for the blog only.
5. Validate `nginx` config before reload.
6. Obtain the certificate for the blog subdomain only.
7. Smoke-test the blog and re-check the existing Cocktail Chooser site.

## Preflight on the Linode

Run these first and save the output in your terminal scrollback:

```bash
systemctl list-units --type=service | grep -Ei 'nginx|apache|caddy|httpd|dotnet|node|pm2|cocktail'
sudo ss -ltnp | grep -E ':80|:443|:2368|:5000|:5001|:3000|:8080'
grep -RniE 'server_name|proxy_pass|listen' /etc/nginx/sites-enabled
curl -fI https://cocktailchooser.com
curl -fI https://cocktailchooser.com/health
```

If any current site is already unhealthy, stop there and fix that first.

## DNS

Create this DNS record in Linode DNS:

- type: `A`
- host: `blog`
- value: `172.105.152.79`
- TTL: default or `300`

Verify from your workstation before requesting SSL:

```bash
dig +short blog.cocktailchooser.com
```

It should return `172.105.152.79`.

## Server packages

If Node is not already present in a suitable LTS version, install Node 20 LTS. Ghost runs well there and keeping the version current reduces operational surprises.

Also confirm these are available:

- `nginx`
- `certbot`
- `python3-certbot-nginx`

## Create a dedicated service account

```bash
sudo adduser --system --group --home /opt/ghost-blog ghostblog
sudo mkdir -p /opt/ghost-blog
sudo chown -R ghostblog:ghostblog /opt/ghost-blog
```

## Install Ghost without auto-mutating nginx

Use Ghost CLI for installation convenience, but do not let it manage shared infrastructure:

```bash
sudo -u ghostblog -H bash
cd /opt/ghost-blog
npm install ghost-cli@latest --no-save
npx ghost install \
  --url https://blog.cocktailchooser.com \
  --db sqlite3 \
  --port 2368 \
  --ip 127.0.0.1 \
  --dir /opt/ghost-blog \
  --no-setup-nginx \
  --no-setup-ssl \
  --no-setup-systemd \
  --no-prompt
exit
```

If interactive setup is easier in practice, that is fine, but keep the three `--no-setup-*` guardrails.

## Ghost config

Use the example at [deploy/ghost/config.production.json.example](/mnt/c/_CODE/cocktail-chooser/deploy/ghost/config.production.json.example) as the reference shape for `/opt/ghost-blog/config.production.json`.

Important values:

- URL must be `https://blog.cocktailchooser.com`
- host must be `127.0.0.1`
- port must be `2368`
- content path should stay inside `/opt/ghost-blog/content`

## Systemd service

Install the unit from [deploy/ghost/ghost-blog.service](/mnt/c/_CODE/cocktail-chooser/deploy/ghost/ghost-blog.service) to:

`/etc/systemd/system/ghost-blog.service`

Then enable it:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now ghost-blog
sudo systemctl status ghost-blog --no-pager -l
```

Check Ghost locally before putting `nginx` in front of it:

```bash
curl -I http://127.0.0.1:2368
```

## Nginx site

Install [deploy/ghost/blog.cocktailchooser.com.nginx.conf](/mnt/c/_CODE/cocktail-chooser/deploy/ghost/blog.cocktailchooser.com.nginx.conf) as:

- `/etc/nginx/sites-available/blog.cocktailchooser.com`

Enable it:

```bash
sudo ln -s /etc/nginx/sites-available/blog.cocktailchooser.com /etc/nginx/sites-enabled/blog.cocktailchooser.com
sudo nginx -t
sudo systemctl reload nginx
```

At this point, plain HTTP for the blog subdomain should proxy to Ghost, while the existing sites remain untouched because they keep their own `server_name` blocks.

## SSL for the blog only

Request a certificate scoped to the new subdomain:

```bash
sudo certbot --nginx -d blog.cocktailchooser.com
```

After Certbot updates the site config:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Smoke tests

Run all of these after deployment:

```bash
curl -fI https://blog.cocktailchooser.com
curl -fI https://cocktailchooser.com
curl -fI https://cocktailchooser.com/health
sudo systemctl status ghost-blog --no-pager -l
sudo journalctl -u ghost-blog -n 100 --no-pager
```

Success means:

- the blog returns `200` or a valid redirect chain to `200`
- the main site still returns healthy responses
- the Cocktail Chooser API health endpoint still responds

## Open Live Writer note

Ghost does not provide classic WordPress XML-RPC publishing. If Open Live Writer compatibility is non-negotiable, WordPress is the safer platform choice.

If the real requirement is "external editor support," Ghost Admin API workflows are still workable, but they are not drop-in Windows Live Writer style publishing.

## Recommended MVP decision

For the "do not break current sites" constraint, I recommend:

- use Ghost
- manage `nginx`, SSL, and `systemd` manually
- keep the blog isolated on `127.0.0.1:2368`
- add the app nav link only after DNS and HTTPS are confirmed live
