{{/*
Expand the name of the chart.
*/}}
{{- define "harvester-rbac.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "harvester-rbac.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "harvester-rbac.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "harvester-rbac.labels" -}}
helm.sh/chart: {{ include "harvester-rbac.chart" . }}
{{ include "harvester-rbac.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "harvester-rbac.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-rbac.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Rules of the "View Virtualization Resources" cluster role. Roles in this chart include these
rules instead of inheriting virt-view-cluster, because the Rancher webhook rejects a RoleTemplate
whose inherited RoleTemplate does not exist yet, and Helm creates all RoleTemplates at once.
*/}}
{{- define "harvester-rbac.clusterViewRules" }}
  - apiGroups:
      - harvesterhci.io
    resources:
      - supportbundles
    verbs:
      - "*"
  - apiGroups:
      - network.harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - loadbalancer.harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - devices.harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - node.harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - harvesterhci.io
    resources:
      - settings
    verbs:
      - get
      - list
      - watch
      - create
{{- end }}

{{/*
Rules of the "View Virtualization Resources" project role (see harvester-rbac.clusterViewRules).
*/}}
{{- define "harvester-rbac.projectViewRules" }}
  - apiGroups:
      - loadbalancer.harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - harvesterhci.io
    resources:
      - "*"
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - harvesterhci.io
    resources:
      - supportbundles
    verbs:
      - "*"
{{- end }}
