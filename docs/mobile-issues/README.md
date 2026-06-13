# Mobile Issue Pack

This folder contains issue-ready markdown files for the mobile app effort.

The goal is to turn the mobile architecture decision into a clean GitHub issue set that can be pasted into existing issues or created as new issues.

## Recommended Issue Flow

1. Update existing epic issue `#101` with `01_mobile-epic.md`
2. Update existing architecture issue `#102` with `02_mobile-architecture-decision.md`
3. Create the new implementation issues in this order:
   - `03_capacitor-shell-setup.md`
   - `04_mobile-api-environment-configuration.md`
   - `05_mobile-ux-audit-core-flows.md`
   - `06_mobile-build-pipeline-and-store-readiness.md`

## Notes

- These files follow the same issue-writing style already used in `issues.json`
- Labels are included as suggested labels at the bottom of each file
- The architecture decision assumes a Capacitor wrapper around the existing Vue app

