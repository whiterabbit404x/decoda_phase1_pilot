# Decoda Production SaaS Upgrade Notes

This package upgrades the prior institutional beta toward a hosted SaaS control plane.

## Added in this build

- Tenant onboarding checklist page and API
- Protected asset registry with asset, contract, and wallet APIs
- Seeded asset registry data for all demo tenants
- Platform admin overview endpoint
- Export bundle manifest and export logging table
- Dashboard cards for onboarding and registry coverage
- Navigation for onboarding and asset registry views
- Expanded automated tests for onboarding, registry, and platform overview

## New routes

- `/onboarding`
- `/assets`
- `/api/v1/onboarding/summary`
- `/api/v1/onboarding/bootstrap`
- `/api/v1/assets`
- `/api/v1/contracts`
- `/api/v1/wallets`
- `/api/v1/platform-admin/overview`

## New database objects

- `tenant_assets`
- `tenant_contracts`
- `tenant_wallets`
- `platform_admin_users`
- `export_packages`

- added managed-services deploy template
- added runtime/config visibility endpoint for platform admins
- added persistent export package storage metadata
- added `/readyz` alias and export history API