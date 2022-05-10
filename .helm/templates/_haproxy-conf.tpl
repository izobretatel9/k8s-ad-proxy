{{ define "haproxy_conf" -}}

defaults
    mode tcp

frontend db
    bind :389
    default_backend ad

backend ad
    server one 192.xxx.xx.1:389 check
    server two 192.xxx.xx.2:389 check
    server three 192.xxx.xx.3:389 check

{{ end }}
