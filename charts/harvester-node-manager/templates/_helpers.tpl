{{/*
Expand the name of the chart.
*/}}
{{- define "harvester-node-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "harvester-node-manager-webhook.name" -}}
{{- default "harvester-node-manager-webhook" | trunc 63 }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "harvester-node-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "harvester-node-manager.labels" -}}
helm.sh/chart: {{ include "harvester-node-manager.chart" . }}
{{ include "harvester-node-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: node-manager
{{- end }}

{{/*
Selector labels
*/}}
{{- define "harvester-node-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-node-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "harvester-node-manager-webhook.labels" -}}
helm.sh/chart: {{ include "harvester-node-manager.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: node-manager
{{- end }}

{{- define "harvester-node-manager-webhook.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-node-manager-webhook.name" . }}
{{- end }}