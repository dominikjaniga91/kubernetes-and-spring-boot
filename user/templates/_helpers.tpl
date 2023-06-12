{{- define "app.label" -}}
    app: user
{{- end -}}

{{- define "database.label" -}}
    database: user-set
{{- end -}}

{{- define "version" -}}
    1.0.0
{{- end -}}

{{- define "current-date" -}}
    {{- now | date "2006-01-02" -}}
{{- end -}}