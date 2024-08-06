# Harvester Charts

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

## Example

Refer the [release a chart and bump to upstream](./release-a-chart-and-bump-to-upstream.md) for more details.
