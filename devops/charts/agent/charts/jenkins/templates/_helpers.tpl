{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jenkins.fullname" -}}
    {{- if .Values.fullnameOverride -}}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- $name := default .Chart.Name .Values.nameOverride -}}
        {{- if contains "$name" ".Release.Name" -}}
            {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
        {{- else -}}
            {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
        {{- end -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the admin password
https://github.com/helm/charts/issues/5167#issuecomment-619137759
*/}}
{{- define "jenkins.password" -}}
  {{- if .Values.Master.AdminPassword -}}
    {{- .Values.Master.AdminPassword | b64enc | quote }}
  {{- else -}}
    {{- $secret := (lookup "v1" "Secret" (default .Release.Namespace .Values.global.namespace) (include "jenkins.fullname" .)).data -}}
    {{- if $secret -}}
      {{/*
        Reusing current password since secret exists
      */}}
      {{- index $secret "jenkins-admin-password" -}}
    {{- else -}}
      {{/*
          Generate new password
      */}}
      {{- randAlphaNum 22 | b64enc | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Returns the admin default api token
https://github.com/helm/charts/issues/5167#issuecomment-619137759
*/}}
{{- define "jenkins.adminToken" -}}
  {{- if .Values.Master.AdminToken -}}
    {{- .Values.Master.AdminToken | b64enc | quote }}
  {{- else -}}
    {{- $secret := (lookup "v1" "Secret" (default .Release.Namespace .Values.global.namespace) (include "jenkins.fullname" .)).data -}}
    {{- if $secret -}}
      {{/*
        Reusing current password since secret exists
      */}}
      {{- index $secret "jenkins-admin-token" -}}
    {{- else -}}
      {{/*
          Generate new token
      */}}
      {{- randNumeric 32 | printf "11%s" | lower | b64enc | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ContainerRuntime" -}}
  {{- $containerRuntimeVersion := trim (mustFirst (lookup "v1" "Node" "" "").items).status.nodeInfo.containerRuntimeVersion -}}
  {{- trimAll "://" (mustRegexFind "^([a-zA-Z]+)://" $containerRuntimeVersion) }}
{{- end -}}

{{- define "jenkins.agent.variant" -}}
    {{- if empty .Values.Builder.ContainerRuntime }}
      {{- if eq (include "ContainerRuntime" .) "containerd" }}
      {{- print "-podman" -}}
      {{- end -}}
    {{- else -}}
      {{- if eq .Values.Builder.ContainerRuntime "podman" }}
      {{- print "-podman" -}}
      {{- end -}}
    {{- end -}}
{{- end -}}

{{- define "jenkins.agent.privileged" -}}
    {{ if eq (include "jenkins.agent.variant" .) "podman" }}
    {{- print "true" -}}
    {{- else -}}
    {{- print "false" -}}
    {{- end -}}
{{- end -}}

{{- define "jenkins.master.javaToolOpts" -}}
    {{ if .Values.Master.JavaOpts }}
    {{- print .Values.Master.JavaOpts -}}
    {{- else -}}
    -XX:InitialRAMPercentage=70 -XX:MaxRAMPercentage=70
    -XX:MaxRAM={{ .Values.Master.resources.limits.memory | replace "Gi" "G" | replace "Mi" "M" }}
    -Dhudson.slaves.NodeProvisioner.initialDelay=20
    -Dhudson.slaves.NodeProvisioner.MARGIN=50
    -Dhudson.slaves.NodeProvisioner.MARGIN0=0.85
    -Dhudson.model.LoadStatistics.clock=5000
    -Dhudson.model.LoadStatistics.decay=0.2
    -Dhudson.slaves.NodeProvisioner.recurrencePeriod=5000
    -Dhudson.security.csrf.DefaultCrumbIssuer.EXCLUDE_SESSION_ID=true
    -Dio.jenkins.plugins.casc.ConfigurationAsCode.initialDelay=10000
    -Djenkins.install.runSetupWizard=false
    -XX:+AlwaysPreTouch
    -XX:+HeapDumpOnOutOfMemoryError
    -XX:+UseG1GC
    -XX:+UseStringDeduplication
    -XX:+ParallelRefProcEnabled
    -XX:+DisableExplicitGC
    -XX:+UnlockDiagnosticVMOptions
    -XX:+UnlockExperimentalVMOptions
    {{- end -}}
{{- end -}}
