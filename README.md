# Hola-Calendar on Railway

[Hola-Calendar](https://github.com/Ray-hola/Hola-Calendar) (MIT, "Hola!" / 哗啦待办): a self-hosted task and project workbench for small teams: week view, projects, one-off and recurring tasks, daily notes, an inbox, team chat and an optional AI assistant. One Python file and one SQLite database; Chinese and English UI. Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/yOPQHd)

## What this template runs
- **hola-calendar**: `ghcr.io/onepush-dev/hola-calendar:829d578`, built from upstream's own Dockerfile recipe at commit `829d578` (upstream publishes no image or release tags; application unmodified). Port 8080, health check `/api/health`, one volume at `/data` for the SQLite database.

## Variables
| Variable | Value |
|---|---|
| `HOLA_ADMIN_PASSWORD` | generated password for the `superadmin` account (set on first boot) |
| `WORK_CALENDAR_ORIGINS` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` (browser origin the server accepts) |

Sign in as `superadmin` with `HOLA_ADMIN_PASSWORD`. Upstream also seeds three sample accounts (`test001`-`test003`, random passwords) and a sample project; reset or deactivate them from the account list. Switch the UI language from the avatar menu (or `?lang=en`). The app's clock is Asia/Shanghai upstream. If you add a custom domain, add it to `WORK_CALENDAR_ORIGINS` (comma-separated).

Not affiliated with Hola-Calendar.
