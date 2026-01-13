{{/*
Expand the name of the chart.
*/}}
{{- define "ucloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ucloud.fullname" -}}
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
{{- define "ucloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create the name of the service account
*/}}
{{- define "ucloud.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ucloud.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the volume claim
*/}}
{{- define "ucloud.provider.claimName" -}}
{{- default (include "ucloud.provider.deploymentName" .) .Values.provider.storage.existingClaim }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "ucloud.labels" -}}
helm.sh/chart: {{ include "ucloud.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Component: Envoy
*/}}
{{- define "ucloud.envoy.deploymentName" -}}
{{- printf "%s-envoy" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.envoy.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.envoy.selectorLabels" . }}
{{- end }}

{{- define "ucloud.envoy.selectorLabels" -}}
app.kubernetes.io/name: envoy
app.kubernetes.io/instance: {{ include "ucloud.envoy.deploymentName" . }}
{{- end }}


{{/*
Component: Provider
*/}}
{{- define "ucloud.provider.deploymentName" -}}
{{- printf "%s-provider" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.provider.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.provider.selectorLabels" . }}
{{- end }}

{{- define "ucloud.provider.selectorLabels" -}}
app.kubernetes.io/name: ucloud-im
app.kubernetes.io/instance: {{ include "ucloud.provider.deploymentName" . }}
{{- end }}
