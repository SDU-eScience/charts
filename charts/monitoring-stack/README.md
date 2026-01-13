# Monitoring Stack
Helm chart for installing a monitoring stack based on Prometheus, Alertmanager, and selected exporters.

## Helm Values
Reference for all available Helm values.

| Name                                      | Description                                                | Value                                  |
| ----------------------------------------- | ---------------------------------------------------------- | -------------------------------------- |
| storage                                   | List of storage volumes to create                          | `[]`                                   |
| storage.[].name                           | Name of this volume                                        | `""`                                   |
| storage.[].size                           | Size of this volume                                        | `""`                                   |
| storage.[].storageClass                   | Storage class for this volume                              | `""`                                   |
| storage.[].accessModes                    | Access modes for this volume                               | `[]`                                   |
| ingress                                   | List of ingress resources to create                        | `[]`                                   |
| ingress.[].name                           | Name of this ingress                                       | `""`                                   |
| ingress.[].host                           | Host for this ingress                                      | `""`                                   |
| ingress.[].service                        | Backend service for this ingress                           | `""`                                   |
| ingress.[].annotations                    | Annotations for this ingress                               | `{}`                                   |
| ingress.[].tls                            | TLS configuration for this ingress                         | `[]`                                   |
| prometheus.enabled                        | Enable Prometheus deployment                               | `true`                                 |
| prometheus.args                           | Default `args` for the pods                                | `[]`                                   |
| prometheus.volumes                        | Default `volumes` for the pods                             | `[]`                                   |
| prometheus.volumeMounts                   | Default `volumeMounts` for the pods                        | `[]`                                   |
| prometheus.nodeSelector                   | Default `nodeSelector` for the pods                        | `{}`                                   |
| prometheus.image.repository               | Image repository                                           | `quay.io/prometheus/prometheus`        |
| prometheus.image.pullPolicy               | Image pull policy                                          | `IfNotPresent`                         |
| prometheus.image.tag                      | Image tag                                                  | `v3.9.1`                               |
| prometheus.service.type                   | Service type                                               | `ClusterIP`                            |
| prometheus.service.annotations            | Service annotations                                        | `{}`                                   |
| prometheus.instances                      | List of instances to deploy                                | `[]`                                   |
| prometheus.instances.[].name              | Deployment name for this instance                          | `""`                                   |
| prometheus.instances.[].args              | Override default `args` for this instance                  | `[]`                                   |
| prometheus.instances.[].volumes           | Override default `volumes` for this instance               | `[]`                                   |
| prometheus.instances.[].volumeMounts      | Override default `volumeMounts` for this instance          | `[]`                                   |
| prometheus.instances.[].nodeSelector      | Override default `nodeSelector` for this instance          | `{}`                                   |
| alertmanager.enabled                      | Enable Alertmanager deployment                             | `true`                                 |
| alertmanager.args                         | Default `args` for the pods                                | `[]`                                   |
| alertmanager.volumes                      | Default `volumes` for the pods                             | `[]`                                   |
| alertmanager.volumeMounts                 | Default `volumeMounts` for the pods                        | `[]`                                   |
| alertmanager.nodeSelector                 | Default `nodeSelector` for the pods                        | `{}`                                   |
| alertmanager.image.repository             | Image repository                                           | `quay.io/prometheus/alertmanager`      |
| alertmanager.image.pullPolicy             | Image pull policy                                          | `IfNotPresent`                         |
| alertmanager.image.tag                    | Image tag                                                  | `v0.30.1`                              |
| alertmanager.service.type                 | Service type                                               | `ClusterIP`                            |
| alertmanager.service.annotations          | Service annotations                                        | `{}`                                   |
| alertmanager.instances                    | List of instances to deploy                                | `[]`                                   |
| alertmanager.instances.[].name            | Deployment name for this instance                          | `""`                                   |
| alertmanager.instances.[].args            | Override default `args` for this instance                  | `[]`                                   |
| alertmanager.instances.[].volumes         | Override default `volumes` for this instance               | `[]`                                   |
| alertmanager.instances.[].volumeMounts    | Override default `volumeMounts` for this instance          | `[]`                                   |
| alertmanager.instances.[].nodeSelector    | Override default `nodeSelector` for this instance          | `{}`                                   |
| idrac_exporter.enabled                    | Enable iDRAC exporter deployment                           | `false`                                |
| idrac_exporter.name                       | Deployment name                                            | `idrac-exporter`                       |
| idrac_exporter.replicas                   | Number of replicas                                         | `1`                                    |
| idrac_exporter.args                       | Value of `args` for the pods                               | `[]`                                   |
| idrac_exporter.volumes                    | Value of `volumes` for the pods                            | `[]`                                   |
| idrac_exporter.volumeMounts               | Value of `volumeMounts` for the pods                       | `[]`                                   |
| idrac_exporter.nodeSelector               | Value of `nodeSelector` for the pods                       | `{}`                                   |
| idrac_exporter.image.repository           | Image repository                                           | `ghcr.io/mrlhansen/idrac_exporter`     |
| idrac_exporter.image.pullPolicy           | Image pull policy                                          | `IfNotPresent`                         |
| idrac_exporter.image.tag                  | Image tag                                                  | `2.3.2`                                |
| idrac_exporter.service.type               | Service type                                               | `ClusterIP`                            |
| idrac_exporter.service.annotations        | Service annotations                                        | `{}`                                   |
| blackbox_exporter.enabled                 | Enable Blakbox exporter deployment                         | `false`                                |
| blackbox_exporter.name                    | Deployment name                                            | `idrac-exporter`                       |
| blackbox_exporter.replicas                | Number of replicas                                         | `1`                                    |
| blackbox_exporter.args                    | Value of `args` for the pods                               | `[]`                                   |
| blackbox_exporter.volumes                 | Value of `volumes` for the pods                            | `[]`                                   |
| blackbox_exporter.volumeMounts            | Value of `volumeMounts` for the pods                       | `[]`                                   |
| blackbox_exporter.nodeSelector            | Value of `nodeSelector` for the pods                       | `{}`                                   |
| blackbox_exporter.image.repository        | Image repository                                           | `quay.io/prometheus/blackbox-exporter` |
| blackbox_exporter.image.pullPolicy        | Image pull policy                                          | `IfNotPresent`                         |
| blackbox_exporter.image.tag               | Image tag                                                  | `v0.28.0`                              |
| blackbox_exporter.service.type            | Service type                                               | `ClusterIP`                            |
| blackbox_exporter.service.annotations     | Service annotations                                        | `{}`                                   |
