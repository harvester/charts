# Harvester-Network-Controller Helm Chart

[Harvester Network Contrller](https://github.com/harvester/network-controller-harvester) is a network controller that helps to manage the host network configuration of the Harvester cluster.

Introduction
------------

This chart installs the network-controller daemonset on the [harvester](https://github.com/harvester/harvester) cluster using the [Helm](https://helm.sh) package manager.

Prerequisites
-------------
- [multus-cni](https://github.com/intel/multus-cni) v3.6+
- Vlan filtering support on bridge
- Switch to support `trunk` mode

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add harvester https://charts.harvesterhci.io
helm repo update
helm install -n $namespace my-release harvester/harvester-network-controller
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm uninstall -n $namespace my-release
```
