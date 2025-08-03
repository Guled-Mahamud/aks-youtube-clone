{{/*
Expand the name of the chart.
*/}}
{{- define "youtube-clone.fullname" -}}
{{- printf "%s-%s" .Release.Name "youtube-clone" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
