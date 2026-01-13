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
Create the name of the volume claim
*/}}
{{- define "ucloud.storage.claimName" -}}
{{- default (include "ucloud.fullname" .) .Values.storage.existingClaim }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "ucloud.labels" -}}
helm.sh/chart: {{ include "ucloud.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Component: Accounting
*/}}
{{- define "ucloud.accounting.deploymentName" -}}
{{- printf "%s-accounting" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.accounting.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.accounting.selectorLabels" . }}
{{- end }}

{{- define "ucloud.accounting.selectorLabels" -}}
app.kubernetes.io/name: ucloud-core
app.kubernetes.io/instance: {{ include "ucloud.accounting.deploymentName" . }}
{{- end }}


{{/*
Component: Foundation
*/}}
{{- define "ucloud.foundation.deploymentName" -}}
{{- printf "%s-foundation" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.foundation.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.foundation.selectorLabels" . }}
{{- end }}

{{- define "ucloud.foundation.selectorLabels" -}}
app.kubernetes.io/name: ucloud-core
app.kubernetes.io/instance: {{ include "ucloud.foundation.deploymentName" . }}
{{- end }}


{{/*
Component: Orchestrator
*/}}
{{- define "ucloud.orchestrator.deploymentName" -}}
{{- printf "%s-orchestrator" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.orchestrator.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.orchestrator.selectorLabels" . }}
{{- end }}

{{- define "ucloud.orchestrator.selectorLabels" -}}
app.kubernetes.io/name: ucloud-core
app.kubernetes.io/instance: {{ include "ucloud.orchestrator.deploymentName" . }}
{{- end }}


{{/*
Component: Frontend
*/}}
{{- define "ucloud.frontend.deploymentName" -}}
{{- printf "%s-frontend" (include "ucloud.fullname" .) }}
{{- end }}

{{- define "ucloud.frontend.labels" -}}
{{ include "ucloud.labels" . }}
{{ include "ucloud.frontend.selectorLabels" . }}
{{- end }}

{{- define "ucloud.frontend.selectorLabels" -}}
app.kubernetes.io/name: ucloud-core
app.kubernetes.io/instance: {{ include "ucloud.frontend.deploymentName" . }}
{{- end }}
