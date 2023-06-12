{{- define "app.label" -}}
    app: post
{{- end -}}

{{- define "database.label" -}}
    database: post-set
{{- end -}}

{{- define "version" -}}
    2.0
{{- end -}}

{{- define "current-date" -}}
    {{- now | date "2006-01-02" -}}
{{- end -}}