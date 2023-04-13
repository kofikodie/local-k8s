resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "loki"
  create_namespace = true
  repository       = "https://grafana.github.io/loki/charts"
  chart            = "loki-stack"

  # Define the values for the Loki chart
  set {
    name  = "loki.enabled"
    value = "true"
  }

  set {
    name  = "loki.isDefault"
    value = "true"
  }

  set {
    name  = "loki.url"
    value = "http://{{(include \"loki.serviceName\" .)}}:{{ .Values.loki.service.port }}"
  }

  set {
    name  = "loki.readinessProbe.httpGet.path"
    value = "/ready"
  }

  set {
    name  = "loki.readinessProbe.httpGet.port"
    value = "http-metrics"
  }

  set {
    name  = "loki.readinessProbe.initialDelaySeconds"
    value = "45"
  }

  set {
    name  = "loki.livenessProbe.httpGet.path"
    value = "/ready"
  }

  set {
    name  = "loki.livenessProbe.httpGet.port"
    value = "http-metrics"
  }

  set {
    name  = "loki.livenessProbe.initialDelaySeconds"
    value = "45"
  }

  set {
    name  = "loki.datasource.jsonData"
    value = "{}"
  }

  set {
    name  = "loki.datasource.uid"
    value = ""
  }

  set {
    name  = "promtail.enabled"
    value = "true"
  }

  set {
    name  = "promtail.config.logLevel"
    value = "info"
  }

  set {
    name  = "promtail.config.serverPort"
    value = "3101"
  }

  set {
    name  = "promtail.config.clients[0].url"
    value = "http://{{ .Release.Name }}:3100/loki/api/v1/push"
  }

  set {
    name  = "fluent-bit.enabled"
    value = "false"
  }

  set {
    name  = "grafana.enabled"
    value = "true"
  }

  set {
    name  = "grafana.sidecar.datasources.label"
    value = ""
  }

  set {
    name  = "grafana.sidecar.datasources.labelValue"
    value = ""
  }

  set {
    name  = "grafana.sidecar.datasources.enabled"
    value = "true"
  }

  set {
    name  = "grafana.sidecar.datasources.maxLines"
    value = "1000"
  }

  set {
    name  = "grafana.image.tag"
    value = "8.3.5"
  }

  set {
    name  = "prometheus.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.isDefault"
    value = "false"
  }

  set {
    name  = "prometheus.url"
    value = "http://{{ include \"prometheus.fullname\" .}}:{{ .Values.prometheus.server.service.servicePort }}{{ .Values.prometheus.server.prefixURL }}"
  }

  set {
    name  = "prometheus.datasource.jsonData"
    value = "{}"
  }
}
