# Changelog
All notable changes from the upstream Prometheus Operator chart will be added to this file.

## [Package Version 00] - 2020-07-19
### Added
- Added [Prometheus Adapter](https://github.com/helm/charts/tree/master/stable/prometheus-adapter) as a dependency to the upstream Prometheus Operator chart to allow users to expose custom metrics from the default Prometheus instance deployed by this chart
- Exposed `prometheus.prometheusSpec.ignoreNamespaceSelectors` on values.yaml and set it to `true` by default. This value instructs the default Prometheus server deployed with this chart to ignore the `namespaceSelector` field within any created ServiceMonitor or PodMonitor CRs that it selects. This prevents ServiceMonitors and PodMonitors from configuring the Prometheus scrape configuration to monitor resources outside the namespace that they are deployed in; if a user needs to have one ServiceMonitor / PodMonitor monitor resources within several namespaces, they will need to either disable this default option or create one ServiceMonitor / PodMonitor CR per namespace that they would like to monitor. Relevant fields were also updated in the default README.md
- Added default resource limits for `Prometheus Operator`, `Prometheus`, `AlertManager`, `Grafana`, `kube-state-metrics`, `node-exporter`
### Modified
- Updated the chart name from `prometheus-operator` to `rancher-monitoring` and added the `io.rancher.certified: rancher` annotation to `Chart.yaml`
- Modified the default `node-exporter` port from `9100` to `9796`
- Modified the default `nameOverride` to `rancher-monitoring`. This change is necessary as the Prometheus Adapter's default URL (`http://{{ .Values.nameOverride }}-prometheus.{{ .Values.namespaceOverride }}.svc`) is based off of the value used here; if modified, the default Adapter URL must also be modified
- Modified the default `namespaceOverride` to `monitoring-system`. This change is necessary as the Prometheus Adapter's default URL (`http://{{ .Values.nameOverride }}-prometheus.{{ .Values.namespaceOverride }}.svc`) is based off of the value used here; if modified, the default Adapter URL must also be modified
- Configured some default values for `grafana.service` values and exposed them in the default README.md
- The default namespaces the following ServiceMonitors were changed from the deployment namespace to allow them to continue to monitor metrics when `prometheus.prometheusSpec.ignoreNamespaceSelectors` is enabled:
    - `core-dns`: `kube-system`
    - `api-server`: `default`
    - `kube-controller-manager`: `kube-system`
    - `kubelet`: `{{ .Values.kubelet.namespace }}`
- Disabled the following deployments by default (can be enabled if required):
    - `AlertManager`
    - `kube-controller-manager` metrics exporter
    - `kube-etcd` metrics exporter
    - `kube-scheduler` metrics exporter
    - `kube-proxy` metrics exporter