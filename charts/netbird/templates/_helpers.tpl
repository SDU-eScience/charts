{{/*
Expand the name of the chart.
*/}}
{{- define "netbird.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "netbird.fullname" -}}
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
{{- define "netbird.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "netbird.labels" -}}
helm.sh/chart: {{ include "netbird.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Component: Dashboard
*/}}
{{- define "netbird.dashboard.deploymentName" -}}
{{- printf "%s-dashboard" (include "netbird.fullname" .) }}
{{- end }}

{{- define "netbird.dashboard.labels" -}}
{{ include "netbird.labels" . }}
{{ include "netbird.dashboard.selectorLabels" . }}
{{- end }}

{{- define "netbird.dashboard.selectorLabels" -}}
app.kubernetes.io/name: netbird
app.kubernetes.io/component: dashboard
app.kubernetes.io/instance: {{ include "netbird.dashboard.deploymentName" . }}
{{- end }}

{{- define "netbird.dashboard.envSecret" -}}
{{- printf "%s-env" (include "netbird.dashboard.deploymentName" .) }}
{{- end }}


{{/*
Component: Server
*/}}
{{- define "netbird.server.deploymentName" -}}
{{- printf "%s-server" (include "netbird.fullname" .) }}
{{- end }}

{{- define "netbird.server.labels" -}}
{{ include "netbird.labels" . }}
{{ include "netbird.server.selectorLabels" . }}
{{- end }}

{{- define "netbird.server.selectorLabels" -}}
app.kubernetes.io/name: netbird
app.kubernetes.io/component: server
app.kubernetes.io/instance: {{ include "netbird.server.deploymentName" . }}
{{- end }}

{{- define "netbird.server.configSecret" -}}
{{- printf "%s-config" (include "netbird.server.deploymentName" .) }}
{{- end }}

{{- define "netbird.server.claimName" -}}
{{- default (include "netbird.server.deploymentName" .) .Values.server.storage.existingClaim }}
{{- end }}
