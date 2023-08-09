{{/*
Expand the name of the chart.
*/}}
{{- define "ks-devops.name" -}}
{{- print "devops" -}}
{{- end }}

{{- define "ks-devops.apiserver-fullname" -}}
{{ include "ks-devops.name" . }}-apiserver
{{- end }}

{{- define "ks-devops.controller-fullname" -}}
{{ include "ks-devops.name" . }}-controller
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ks-devops.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for ks-devops
*/}}
{{- define "ks-devops.labels" -}}
helm.sh/chart: {{ include "ks-devops.chart" . }}
app.kubernetes.io/name: {{ include "ks-devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for apiserver
*/}}
{{- define "apiserver.labels" -}}
{{ include "ks-devops.labels" . }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Selector labels for apiserver
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ks-devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Common labels for controller
*/}}
{{- define "controller.labels" -}}
{{ include "ks-devops.labels" . }}
devops.kubesphere.io/component: devops-controller
{{- end }}

{{/*
Selector labels for controller
*/}}
{{- define "controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ks-devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
devops.kubesphere.io/component: devops-controller
{{- end }}

{{/*
setup CronJob apiversion by k8s version
*/}}
{{- define "cronjob.apiversion" -}}
{{- if semverCompare ">=1.24.0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "batch/v1" -}}
{{- else }}
{{- print "batch/v1beta1" -}}
{{- end }}
{{- end }}
