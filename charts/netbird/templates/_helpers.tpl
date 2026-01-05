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
Component: Management
*/}}
{{- define "netbird.management.deploymentName" -}}
{{- printf "%s-management" (include "netbird.fullname" .) }}
{{- end }}

{{- define "netbird.management.labels" -}}
{{ include "netbird.labels" . }}
{{ include "netbird.management.selectorLabels" . }}
{{- end }}

{{- define "netbird.management.selectorLabels" -}}
app.kubernetes.io/name: netbird
app.kubernetes.io/component: management
app.kubernetes.io/instance: {{ include "netbird.management.deploymentName" . }}
{{- end }}

{{- define "netbird.management.configSecret" -}}
{{- printf "%s-config" (include "netbird.management.deploymentName" .) }}
{{- end }}

{{- define "netbird.management.envSecret" -}}
{{- printf "%s-env" (include "netbird.management.deploymentName" .) }}
{{- end }}

{{- define "netbird.management.claimName" -}}
{{- default (include "netbird.management.deploymentName" .) .Values.management.storage.existingClaim }}
{{- end }}


{{/*
Component: Signal
*/}}
{{- define "netbird.signal.deploymentName" -}}
{{- printf "%s-signal" (include "netbird.fullname" .) }}
{{- end }}

{{- define "netbird.signal.labels" -}}
{{ include "netbird.labels" . }}
{{ include "netbird.signal.selectorLabels" . }}
{{- end }}

{{- define "netbird.signal.selectorLabels" -}}
app.kubernetes.io/name: netbird
app.kubernetes.io/component: signal
app.kubernetes.io/instance: {{ include "netbird.signal.deploymentName" . }}
{{- end }}


{{/*
Component: Relay
*/}}
{{- define "netbird.relay.deploymentName" -}}
{{- printf "%s-relay" (include "netbird.fullname" .) }}
{{- end }}

{{- define "netbird.relay.labels" -}}
{{ include "netbird.labels" . }}
{{ include "netbird.relay.selectorLabels" . }}
{{- end }}

{{- define "netbird.relay.selectorLabels" -}}
app.kubernetes.io/name: netbird
app.kubernetes.io/component: relay
app.kubernetes.io/instance: {{ include "netbird.relay.deploymentName" . }}
{{- end }}

{{- define "netbird.relay.envSecret" -}}
{{- printf "%s-env" (include "netbird.relay.deploymentName" .) }}
{{- end }}
