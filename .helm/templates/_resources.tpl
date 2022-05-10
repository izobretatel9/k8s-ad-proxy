{{- define "haproxy_resources" }}
resources:
  requests:
    memory: {{ pluck .Values.werf.env .Values.resources.haproxy.memory.requests | first | default .Values.resources.haproxy.memory.requests._default | quote }}
    cpu: {{ pluck .Values.werf.env .Values.resources.haproxy.cpu.requests | first | default .Values.resources.haproxy.cpu.requests._default | quote }}
  limits:
    memory: {{ pluck .Values.werf.env .Values.resources.haproxy.memory.limits | first | default .Values.resources.haproxy.memory.limits._default | quote }}
{{- end }}
