# Release a New Chart and Bump it to Upstream

## Release a New Chart on Harvester Chart Repo

This document demonstrates how to release a new harvester-cloud-provider chart version, and bump the new version to upstream.

### Change an Existing Chart

e.g. https://github.com/harvester/charts/pull/229

merge to `master` branch

Note the chart version on `master` is `stable`, do not change it, e.g. https://github.com/harvester/charts/blob/9cd25bd54370e38b3d2a1731c317c418d079b8ff/charts/harvester-cloud-provider/Chart.yaml#L21, it keeps as `version: 0.0.0-dev`.

### Release a New Version

Cherry-pick all changes against the chart on `master` branch, add another commit to amend the `version` field &/ other fields on `Chart.yaml`.

After the PR to `release` branch is merged, a new chart version is released automatically.

e.g. https://github.com/harvester/charts/pull/230

e.g. https://github.com/harvester/charts/releases/tag/harvester-cloud-provider-0.2.4

The chart like `harvester-cloud-provider` and `harvester-csi-driver` also need to be bumped to upstream RKE2 and Rancher. The following sections describe the details.

:::note

Always create/connect a github issue to the new chart release, QA and project management will cover all the requried processes.

:::

## Bump the Chart to `RKE2`

### Update `rancher/rke2-charts`

Point to the new release on Harvester chart repo.

https://github.com/rancher/rke2-charts/blob/main-source/packages/harvester-cloud-provider/package.yaml

e.g. https://github.com/rancher/rke2-charts/pull/454

### Update `rancher/rke2` 

Point to the new chart version, then `RKE2` will use the new chart version as the default value.

https://github.com/rancher/rke2/blob/master/charts/chart_versions.yaml

e.g. https://github.com/rancher/rke2/pull/5980

:::note

  Add PR to each active `rancher/rke2` branch.

:::

## Bump the Chart to `Rancher`

### Bump the chart to `rancher/charts`

Rancher charts are managed in a more complex way. First, read the document on this repo like https://github.com/rancher/charts/blob/dev-v2.9/README.md, https://github.com/rancher/charts/blob/dev-v2.9/docs/developing.md.

We need the help of those two paths to step-by-step generate the target files.

```
  packages/harvester/harvester-cloud-provider/charts/  is used to download chart file in `make prepare`

  packages/harvester/harvester-cloud-provider/generated-changes/ is used to put the generated patch files
```

Example: https://github.com/rancher/charts/pull/3234

:::note

  Add PR to each active `rancher/charts` branch.

:::

#### Update the package.yaml file

Update the `url` and `version` fields.

```
diff --git a/packages/harvester/harvester-cloud-provider/package.yaml b/packages/harvester/harvester-cloud-provider/package.yaml
index 7e86c3d2..5485f225 100644
--- a/packages/harvester/harvester-cloud-provider/package.yaml
+++ b/packages/harvester/harvester-cloud-provider/package.yaml
@@ -1,3 +1,3 @@
-url: https://github.com/harvester/charts/releases/download/harvester-cloud-provider-0.1.14/harvester-cloud-provider-0.1.14.tgz
+url: https://github.com/harvester/charts/releases/download/harvester-cloud-provider-0.2.2/harvester-cloud-provider-0.2.2.tgz
 version: 103.0.0
 doNotRelease: false
```

:::note

The Rancher version `103.0.0` needs to increase to a next version like `103.0.1` if `103.0.0` has been used, otherwise, the `index.yaml` will not be updated.

:::


#### (Optional) Prepare the dependency file

Prepare the dependency file if it comes for the first time.

```
+++ b/packages/harvester/harvester-cloud-provider/generated-changes/dependencies/kube-vip/dependency.yaml
@@ -0,0 +1,3 @@
+workingDir: ""
+url: https://github.com/harvester/charts/releases/download/harvester-cloud-provider-0.2.2/harvester-cloud-provider-0.2.2.tgz
+subdirectory: dependency_charts/kube-vip
```

#### Make prepare

Make prepare will pull the source chart into local path of `packages/harvester/harvester-cloud-provider`.

```
$ export PACKAGE=harvester/harvester-cloud-provider

$ make prepare

/go/src/github.com/w13915984028/rancher-charts$ make prepare
INFO[0000] Pulling https://github.com/harvester/charts/releases/download/harvester-cloud-provider-0.2.2/harvester-cloud-provider-0.2.2.tgz from upstream into charts 
INFO[0000] Loading dependencies for chart
INFO[0000] found chart options for kube-vip in generated-changes/dependencies/kube-vip/dependency.yaml 
INFO[0000] Found chart options for kube-vip in generated-changes/dependencies/kube-vip/dependency.yaml 
INFO[0000] Pulling https://github.com/harvester/charts/releases/download/harvester-cloud-provider-0.2.2/harvester-cloud-provider-0.2.2.tgz[path=dependency_charts/kube-vip] from upstream into charts 
INFO[0000] Updating chart metadata with dependencies
WARN[0000] Detected 'apiVersion:v2' within Chart.yaml; these types of charts require additional testing 
INFO[0000] Applying changes from generated-changes
INFO[0000] Applying: generated-changes/patch/Chart.yaml.patch 
ERRO[0000] 
patching file Chart.yaml
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file Chart.yaml.rej 
FATA[0000] encountered error while preparing main chart: encountered error while trying to apply changes to charts: unable to generate patch with error: exit status 1 
make: *** [Makefile:17: prepare] Error 1
```

::: note

  If the above error is shown, simply remove the file `./packages/harvester/harvester-cloud-provider/generated-changes/patch/Chart.yaml.patch`, it means: the previous patch file has conflict, we need to generate a new one.
  
:::

#### Generate the patch file manually

Prepare the important patch file: `generated-changes/patch/Chart.yaml.patch`

:::note

Remove the origin `Chart.yaml.patch` first. Otherwise it may mislead us.

Make a copy of `Chart.yaml` and change it. Then use `diff` to get the new `Chart.yaml.patch`. 

:::

```
/go/src/github.com/w13915984028/rancher-charts/packages/harvester/harvester-cloud-provider/charts$ diff Chart.yaml Chart1.yaml -u > ../generated-changes/patch/Chart.yaml.patch
--- Chart.yaml	2024-01-08 20:33:08.893433595 +0100
+++ Chart1.yaml	2024-01-08 21:07:53.378778026 +0100
@@ -4,7 +4,7 @@
   catalog.cattle.io/kube-version: '>= 1.23.0-0 < 1.27.0-0'
   catalog.cattle.io/namespace: kube-system
   catalog.cattle.io/os: linux
-  catalog.cattle.io/rancher-version: '>= 2.7.0-0 < 2.8.0-0'
+  catalog.cattle.io/rancher-version: '>= 2.9.0-0 < 2.10.0-0'
   catalog.cattle.io/release-name: harvester-cloud-provider
   catalog.cattle.io/ui-component: harvester-cloud-provider
   catalog.cattle.io/upstream-version: 0.2.0

manually change it to:

--- charts-original/Chart.yaml
+++ charts/Chart.yaml
@@ -4,7 +4,7 @@
   catalog.cattle.io/kube-version: '>= 1.23.0-0 < 1.27.0-0'
   catalog.cattle.io/namespace: kube-system
   catalog.cattle.io/os: linux
-  catalog.cattle.io/rancher-version: '>= 2.7.0-0 < 2.8.0-0'
+  catalog.cattle.io/rancher-version: '>= 2.9.0-0 < 2.10.0-0'
   catalog.cattle.io/release-name: harvester-cloud-provider
   catalog.cattle.io/ui-component: harvester-cloud-provider
   catalog.cattle.io/upstream-version: 0.2.0
```

#### (Optional) Generate special patch file manually

When running `make check-images` you may encounter such error:

```
time="2023-11-03T21:56:40Z" level=fatal msg="failed to generate namespace and repository for image: ghcr.io/kube-vip/kube-vip"
make: *** [Makefile:17: check-images] Error 1
```

It is due to the make charts does not allow image format like `ghcr.io/kube-vip/kube-vip`, only one `/` can exist.

In `harvester-cloud-provider`, there are:

```
charts/dependency_charts/kube-vip/values.yaml:  repository: ghcr.io/kube-vip/kube-vip
charts/charts/kube-vip/values.yaml:  repository: ghcr.io/kube-vip/kube-vip
```

Make a copy of the `dependency_charts/kube-vip/values.yaml` and modify it, finally generate a patch file like:

```
$ diff -Naur values.yaml values1.yaml > values.yaml.patch

--- values.yaml	2023-11-03 22:53:06.468672017 +0100
+++ values1.yaml	2023-11-17 21:14:04.573425541 +0100
@@ -3,10 +3,10 @@
 # Declare variables to be passed into your templates.
 
 image:
-  repository: ghcr.io/kube-vip/kube-vip
+  repository: rancher/mirrored-kube-vip-kube-vip-iptables
   pullPolicy: IfNotPresent
   # Overrides the image tag whose default is the chart appVersion.
-  tag: "v0.4.1"
+  tag: "v0.6.0"
 
 config:
   address: ""
```

Edit the file to change file name and remove timestamp, finally `git diff` will show it as:

```
+++ b/packages/harvester/harvester-cloud-provider/generated-changes/patch/dependency_charts/kube-vip/values.yaml.patch
@@ -0,0 +1,15 @@
+--- charts-original/dependency_charts/kube-vip/values.yaml
++++ charts/dependency_charts/kube-vip/values.yaml
+@@ -3,10 +3,10 @@
+ # Declare variables to be passed into your templates.
+ 
+ image:
+-  repository: ghcr.io/kube-vip/kube-vip
++  repository: rancher/mirrored-kube-vip-kube-vip-iptables
+   pullPolicy: IfNotPresent
+   # Overrides the image tag whose default is the chart appVersion.
+-  tag: "v0.4.1"
++  tag: "v0.6.0"
+ 
+ config:
+   address: ""
```

Same procedure against `charts/kube-vip/values.yaml` and get the generated `values.yaml.patch`.

```
--- charts-original/charts/kube-vip/values.yaml
+++ charts/charts/kube-vip/values.yaml
@@ -3,10 +3,10 @@
 # Declare variables to be passed into your templates.
 
 image:
-  repository: ghcr.io/kube-vip/kube-vip
+  repository: rancher/mirrored-kube-vip-kube-vip-iptables
   pullPolicy: IfNotPresent
   # Overrides the image tag whose default is the chart appVersion.
-  tag: "v0.4.1"
+  tag: "v0.6.0"
 
 config:
   address: ""
```

#### Make

The whole command list is:

```
$ export PACKAGE=harvester/harvester-cloud-provider

$ make prepare

$ make patch

$ make clean

$ make charts
```
When no error happens, commit the changes.

#### Make validate

Such error may happen:

```
INFO[0178] harvester-cloud-provider/103.0.0+up0.2.2 is untracked 
ERRO[0181] The following new assets have been introduced: map[harvester-cloud-provider:[103.0.0+up0.2.2]] 
ERRO[0181] The following released assets have been removed: map[] 
ERRO[0181] The following released assets have been modified: map[] 
ERRO[0181] If this was intentional, to allow validation to pass, these charts must be added to the release.yaml. 
INFO[0181] Dumping release.yaml tracking changes that have been introduced 
```

Update the release.yaml, commit.

```
$ diff --git a/release.yaml b/release.yaml
index 422c128f..7ff5a50c 100644
--- a/release.yaml
+++ b/release.yaml
@@ -26,6 +26,7 @@ fleet-crd:
   - 103.1.0+up0.9.0-rc.5
 harvester-cloud-provider:
   - 103.0.0+up0.1.14
+  - 103.0.0+up0.2.2
 harvester-csi-driver:
   - 103.0.0+up0.1.16

```

`make validate` again.

```
...
INFO[0188] index.yaml is up-to-date                     
INFO[0188] Doing a final check to ensure Git is clean   
INFO[0190] Successfully validated current repository!   

```

#### Always check

Check again to make sure all the requirements from `rancher/charts` are met.
