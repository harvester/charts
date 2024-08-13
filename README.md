# Harvester Charts
[![Release Charts](https://github.com/harvester/charts/actions/workflows/ci.yaml/badge.svg)](https://github.com/harvester/charts/actions/workflows/ci.yaml)

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

## Branch Usage:
- `master` branch is used for latest manifests
- `release` branch is used for the latest version. It should be mostly in sync with the `master` and the latest stable branch. Only the chart version should be different.
- `release-<version>` branch is used for the previous versions.

We will create a `release-<version>` after we release a new version of Harvester. The `release` branch can keep going with the latest version.

## Scenarios:

### Release a chart for the latest version.
1. Update (or create) chart files (including any manifest update) in the corresponding directory on `master` branch. (e.g. `charts/harvester-node-disk-manager`) If no manifest changes, skip this step.
2. Update (or create) chart  files (including the manifest update and new chart version) in the corresponding directory on `release` branch. (e.g. `charts/harvester-node-disk-manager`)
3. After the PR is merged, the chart will be released on the `GitHub Pages`.

Example:

I would like to release a new version for node-disk-manager chart and the manifest has new changes. I need to update the corresponding manifest file to the `master` branch, Like this PR: https://github.com/harvester/charts/pull/213 (This is Step 1).
Then, I need to update the same manifest changes and chart version in the `release` branch, like this PR: https://github.com/harvester/charts/pull/214 (This is Step 2).

### Release a chart for a previous version.
1. Make sure which `release-<version>` branch you need to use. It aligns with harvester branch, for example, if you want to release a chart for Harvester v1.3.x, you should use `release-1.3` branch.
2. Update (or create) chart files (including any manifest update) in the corresponding directory on `release-<version>` branch. (e.g. `charts/harvester-node-disk-manager`)


## Harvester-Cloud-Provider and Harvester-CSI-Driver
These two charts are out-of-band charts for Harvester. They are used for the rancher integration. We use the `release` branch to release these two charts.