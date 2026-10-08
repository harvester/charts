# Harvester Charts
![Release Charts](https://github.com/harvester/charts/workflows/Release%20Charts/badge.svg)

## Prerequisites
- Helm 3.x

## Adding the Chart
```
$ helm repo add harvester https://charts.harvesterhci.io
$ helm repo update
```

## Releasing New Charts
When ready to release a new chart version or add a new chart, copy the chart directory from the source repository into the `charts/` directory. Make sure the chart directory is named after the actual chart (for example: `harvester/`).

Once pushed, GitHub Actions will look for any changes to charts in the `charts/` directory since the last tagged release in the repository, package any changed charts, and then release them on `GitHub Pages`.

Note that changes should only be synced to this repository when ready for a new release. GitHub Actions will fail if making changes to the charts in this repository directly, as Chart Releaser will not attempt to override old chart releases.

## Release Branches

This repository uses several long-lived branches to manage chart releases across Harvester versions:

- **`master`** — The source of truth for all chart template changes. Every template change must land here first.
- **`release`** — Tracks the Harvester version currently under development (e.g., `v1.9.0-dev`). Rancher-related charts (`harvester-csi-driver`, `harvester-cloud-provider`, `harvester-rbac`) or independent chart (`forklift-operator`) are always updated on this branch.
- **`release-<version>`** (e.g., `release-v1.8`, `release-v1.7`) — Used by release automation for published Harvester versions. Anything strongly tied to a specific Harvester version is released from these branches. Most are handled by release automation today; currently only `kubeovn-operator` still requires manual updates.

### Propagation Rules

Any chart template change **must land in `master` first**, then be propagated to the relevant release branches.

Examples:

- Updating the `node-disk-manager` chart during v1.9 development → open a PR to `master`, then propagate to `release` (since `release` tracks v1.9-dev).
- Modifying a chart during v1.8 QA validation → update all three branches: `master`, `release`, and `release-v1.8`.

### After RC Hotfix Releases

During an RC validation cycle, if an additional fix is needed but cutting a new RC is undesirable, a chart version can be released manually on the corresponding `release-<version>` branch using a `.r<n>` postfix.

For example, if `kubeovn-operator` needs an extra fix after `v1.8.0-rc6`, we can manually release it as `v1.8.0-rc6.r2` directly on `release-v1.8`.

This could also be applied to after a stable release if needed, for example `v1.8.0.r2` on `release-v1.8`. However, we should avoid doing this unless absolutely necessary, as it can cause confusion and maintenance overhead.
