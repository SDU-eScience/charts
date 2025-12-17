# Netbird
Helm chart for installing Netbird in Kubernetes.

## Helm Values
Reference for all available Helm values.

| Name                                      | Description                                                                     | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------ |
| **global**                                | Global settings for all deployments (overrides for each deployment supported)   |                                      |
| global.revisionHistoryLimit               | Number of retained replica sets to allow rollback                               | `2`                                  |
| global.nodeSelector                       | Pod node selector labels                                                        | `{}`                                 |
| global.annotations                        | Pod annotations                                                                 | `{}`                                 |
| global.tolerations                        | Pod tolerations                                                                 | `[]`                                 |
| global.affinity                           | Pod affinity                                                                    | `{}`                                 |
| global.resources                          | Pod resources                                                                   | `{}`                                 |
| **management**                            | Settings for the management deployment                                          |                                      |
| management.enabled                        | Create the mangement deployment                                                 | `true`                               |
| management.env                            | Environment variables (stored as a secret)                                      | `{}`                                 |
| management.config                         | The `management.json` configuration file (stored as a secret)                   | `""`                                 |
| management.storage.enabled                | Enable persistent storage                                                       | `false`                              |
| management.storage.size                   | Persistent volume size                                                          | `1Gi`                                |
| management.storage.selector               | Additional labels to match for the PVC                                          | `{}`                                 |
| management.storage.dataSource             | Custom data source for the PVC                                                  | `{}`                                 |
| management.storage.storageClass           | Persistent volume storage class                                                 | `""`                                 |
| management.storage.accessModes            | Persistent volume access modes                                                  | `["ReadWriteMany"]`                  |
| management.storage.existingClaim          | Use an existing PVC which must be created beforehand                            | `""`                                 |
| management.storage.subPath                | The subdirectory of the volume to mount in the containers                       | `""`                                 |
| management.image.repository               | Image repository                                                                | `netbirdio/management`               |
| management.image.pullPolicy               | Image pull policy                                                               | `IfNotPresent`                       |
| management.image.tag                      | Image tag                                                                       | `""`                                 |
| management.service.type                   | Service type                                                                    | `ClusterIP`                          |
| management.service.annotations            | Service annotations                                                             | `{}`                                 |
| management.service.httpPort               | Port for HTTP traffic                                                           | `80`                                 |
| management.service.grpcPort               | Port for GRPC traffic                                                           | `33073`                              |
| **signal**                                | Settings for the signal deployment                                              |                                      |
| signal.enabled                            | Create the signal deployment                                                    | `true`                               |
| signal.image.repository                   | Image repository                                                                | `netbirdio/signal`                   |
| signal.image.pullPolicy                   | Image pull policy                                                               | `IfNotPresent`                       |
| signal.image.tag                          | Image tag                                                                       | `""`                                 |
| signal.service.type                       | Service type                                                                    | `ClusterIP`                          |
| signal.service.annotations                | Service annotations                                                             | `{}`                                 |
| signal.service.grpcPort                   | Port for GRPC traffic                                                           | `80`                                 |
| **dashboard**                             | Settings for the dashboard deployment                                           |                                      |
| dashboard.enabled                         | Create the dashboard deployment                                                 | `true`                               |
| dashboard.env                             | Environment variables (stored as a secret)                                      | `{}`                                 |
| dashboard.image.repository                | Image repository                                                                | `netbirdio/dashboard`                |
| dashboard.image.pullPolicy                | Image pull policy                                                               | `IfNotPresent`                       |
| dashboard.image.tag                       | Image tag                                                                       | `2.23.0`                             |
| dashboard.service.type                    | Service type                                                                    | `ClusterIP`                          |
| dashboard.service.annotations             | Service annotations                                                             | `{}`                                 |
| dashboard.service.httpPort                | Port for HTTP traffic                                                           | `80`                                 |
