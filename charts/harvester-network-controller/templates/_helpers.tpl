{{/*
Expand the name of the chart.
*/}}
{{- define "harvester-network-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "harvester-network-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "harvester-network-controller.labels" -}}
helm.sh/chart: {{ include "harvester-network-controller.chart" . }}
{{ include "harvester-network-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: network
{{- end }}

{{/*
Selector labels
*/}}
{{- define "harvester-network-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-network-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "harvester-network-controller-manager.labels" -}}
helm.sh/chart: {{ include "harvester-network-controller.chart" . }}
{{ include "harvester-network-controller-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: network
{{- end }}

{{- define "harvester-network-controller-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-network-controller.name" . }}-manager
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "harvester-network-webhook.labels" -}}
helm.sh/chart: {{ include "harvester-network-controller.chart" . }}
{{ include "harvester-network-webhook.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: network-webhook
{{- end }}

{{- define "harvester-network-webhook.selectorLabels" -}}
app.kubernetes.io/name: harvester-network-webhook
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
