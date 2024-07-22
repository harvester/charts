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
