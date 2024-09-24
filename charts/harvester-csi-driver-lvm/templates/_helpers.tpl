{{/*
Expand the name of the chart.
*/}}
{{- define "harvester-csi-driver-lvm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "harvester-csi-driver-lvm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
CSI-plugin labels
*/}}
{{- define "harvester-csi-driver-lvm.labels" -}}
helm.sh/chart: {{ include "harvester-csi-driver-lvm.chart" . }}
{{ include "harvester-csi-driver-lvm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: storage
{{- end }}

{{/*
CSI-plugin Selector labels
*/}}
{{- define "harvester-csi-driver-lvm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-csi-driver-lvm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
CSI-controller labels
*/}}
{{- define "harvester-csi-driver-lvm-controller.labels" -}}
helm.sh/chart: {{ include "harvester-csi-driver-lvm.chart" . }}
{{ include "harvester-csi-driver-lvm-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: storage
{{- end }}

{{/*
CSI-controller Selector labels
*/}}
{{- define "harvester-csi-driver-lvm-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-csi-driver-lvm.name" . }}-controller
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
CSI-webhook labels
*/}}
{{- define "harvester-csi-driver-lvm-webhook.labels" -}}
helm.sh/chart: {{ include "harvester-csi-driver-lvm.chart" . }}
{{ include "harvester-csi-driver-lvm-webhook.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: webhook
{{- end }}

{{/*
CSI-webhook Selector labels
*/}}
{{- define "harvester-csi-driver-lvm-webhook.selectorLabels" -}}
app.kubernetes.io/name: {{ include "harvester-csi-driver-lvm.name" . }}-webhook
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
CSI components
*/}}
{{- define "externalImages.csiAttacher" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.attacher -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/csi-attacher:v4.4.2" -}}
{{- end -}}
{{- end -}}

{{- define "externalImages.csiProvisioner" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.provisioner -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/csi-provisioner:v3.6.2" -}}
{{- end -}}
{{- end -}}

{{- define "externalImages.csiLivenessprobe" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.livenessprobe -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/livenessprobe:v2.12.0" -}}
{{- end -}}
{{- end -}}

{{- define "externalImages.csiResizer" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.resizer -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/csi-resizer:v1.9.2" -}}
{{- end -}}
{{- end -}}

{{- define "externalImages.csiSnapshotter" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.snapshotter -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/csi-snapshotter:v6.3.4" -}}
{{- end -}}
{{- end -}}

{{- define "externalImages.csiNodeDriverRegistrar" -}}
{{- if .Values.customCSISidecars.enabled -}}
{{- print .Values.customCSISidecars.registrar -}}
{{- else -}}
{{- print "registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.9.2" -}}
{{- end -}}
{{- end -}}
