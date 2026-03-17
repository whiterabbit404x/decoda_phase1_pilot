# Decoda Security - Production Deployment Package

A runnable FastAPI package that takes the earlier institutional beta into a **production deployment candidate** for Strategic Infrastructure Guard.

## What this build adds

This package layers the operational pieces you need to move from beta software to a deployable institutional platform:

- Dockerfile and production `docker-compose` stack
- NGINX reverse-proxy configuration
- Kubernetes manifest examples
- start, prestart, backup, and restore scripts
- CI workflow for tests and container build validation
- production deployment docs and go-live checklist
- live OIDC support in addition to the existing mock OIDC mode

## Core product capabilities already included

- multi-tenant login and tenant scoping
- policy engine and synchronous simulation runs
- queued simulation jobs via worker
- reports and audit trail
- incident creation and updates
- signed webhooks, delivery logs, and retries
- tenant RBAC, tenant user administration, and approvals
- monitoring summary, alerts, Prometheus-style metrics, and evidence package exports

## Run locally for development

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload
python -m app.worker
```

## Run production-style with containers

```bash
cp .env.example .env
# edit values for PostgreSQL, PUBLIC_BASE_URL, secrets, and secure cookies

docker compose -f docker-compose.production.yml up --build
```

## Production-critical settings

- `APP_ENV=production`
- `DATABASE_URL=postgresql://...`
- `SESSION_COOKIE_SECURE=true`
- `PUBLIC_BASE_URL=https://infra.decodasecurity.com`
- `OIDC_MOCK_ENABLED=false`

## OIDC modes

- `mode=mock` for demos
- `mode=live` for real providers using authorization code flow and userinfo lookup

See `docs/production/oidc_real_provider_guide.md`.

## Operational docs

- `docs/production/`
- `docs/trust_pack/`
- `docs/legal/`

## What this package does **not** honestly claim

This repository can package the software and deployment assets, but it does **not** by itself prove:

- a successful live cloud deployment
- a completed external penetration test
- a completed SOC 2 examination
- a completed customer pilot with operating evidence

Those still require real execution outside the repo.


## Added in this build

- Threat defense module for AI zero-day scoring, flash-loan exposure, liquidity drainer detection, and Treasury-token market anomaly tracking.
- Oracle integrity module for validator quorum, drift tolerance, collateral coverage, and provenance evidence.
- Governance module for KYC/travel-rule wrappers, sanctions screening, geopatriation, and approvals.
- Resilience module for cross-chain reconciliation, circuit breakers, and liquidity backstops.


## Wallet-aware Auto Watch added in this build

This package now supports a first wallet connector layer for Auto Watch:

- watched admin and reserve wallets are stored as public addresses only
- wallet activity snapshots can be upserted manually through the API for demos and testing
- Auto Watch can optionally refresh wallet telemetry from an **etherscan-compatible** explorer API when `wallet_activity_sources` are configured inside the monitoring profile `signal_overrides`
- admin wallet bursts and reserve wallet outflows now affect Auto Watch risk, alerts, and incidents

### New wallet activity APIs

- `POST /api/v1/monitoring/wallet-snapshots`
- `GET /api/v1/monitoring/profiles/{id}/wallet-activity?tenant_id=1`
- `POST /api/v1/monitoring/profiles/{id}/wallet-refresh?tenant_id=1`

### Example signal override for a Base wallet explorer

```json
{
  "wallet_activity_sources": {
    "base": {
      "mode": "etherscan_compatible",
      "base_url": "https://YOUR-EXPLORER-API/api",
      "api_key": "OPTIONAL"
    }
  },
  "wallet_admin_burst_warning_txs": 6,
  "wallet_admin_burst_critical_txs": 12,
  "wallet_reserve_outflow_warning_native": 0.5,
  "wallet_reserve_outflow_critical_native": 2.0,
  "wallet_stale_minutes": 1440
}
```

Never store or paste a seed phrase or private key into this system. Use public wallet addresses only.
