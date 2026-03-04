# Netbird
Helm chart for installing Netbird in Kubernetes.


## Helm Values
Reference for all available Helm values.


### Global
Global configuration for all deployments

| Name                                      | Description                                                                     | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------ |
| global.revisionHistoryLimit               | Number of retained replica sets to allow rollback                               | `2`                                  |
| global.nodeSelector                       | Pod node selector labels                                                        | `{}`                                 |
| global.annotations                        | Pod annotations                                                                 | `{}`                                 |
| global.tolerations                        | Pod tolerations                                                                 | `[]`                                 |
| global.affinity                           | Pod affinity                                                                    | `{}`                                 |
| global.resources                          | Pod resources                                                                   | `{}`                                 |


### Server
Configuration for the `server` deployment.

| Name                                      | Description                                                                     | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------ |
| server.enabled                            | Create the mangement deployment                                                 | `true`                               |
| server.config                             | The `config.yaml` configuration file (stored as a secret)                       | `""`                                 |
| server.storage.enabled                    | Enable persistent storage                                                       | `false`                              |
| server.storage.size                       | Persistent volume size                                                          | `1Gi`                                |
| server.storage.selector                   | Additional labels to match for the PVC                                          | `{}`                                 |
| server.storage.dataSource                 | Custom data source for the PVC                                                  | `{}`                                 |
| server.storage.storageClass               | Persistent volume storage class                                                 | `""`                                 |
| server.storage.accessModes                | Persistent volume access modes                                                  | `["ReadWriteMany"]`                  |
| server.storage.existingClaim              | Use an existing PVC which must be created beforehand                            | `""`                                 |
| server.storage.subPath                    | The subdirectory of the volume to mount in the containers                       | `""`                                 |
| server.image.repository                   | Image repository                                                                | `netbirdio/netbird-server`           |
| server.image.pullPolicy                   | Image pull policy                                                               | `IfNotPresent`                       |
| server.image.tag                          | Image tag                                                                       | `""`                                 |
| server.service.type                       | Service type                                                                    | `ClusterIP`                          |
| server.service.annotations                | Service annotations                                                             | `{}`                                 |
| server.service.httpPort                   | Port for HTTP traffic                                                           | `8080`                               |
| server.service.stunPort                   | Port for STUN traffic                                                           | `3478`                               |


### Dashboard
Configuration for the `dashboard` deployment.

| Name                                      | Description                                                                     | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------ |
| dashboard.enabled                         | Create the dashboard deployment                                                 | `true`                               |
| dashboard.env                             | Environment variables (stored as a secret)                                      | `{}`                                 |
| dashboard.image.repository                | Image repository                                                                | `netbirdio/dashboard`                |
| dashboard.image.pullPolicy                | Image pull policy                                                               | `IfNotPresent`                       |
| dashboard.image.tag                       | Image tag                                                                       | `2.25.0`                             |
| dashboard.service.type                    | Service type                                                                    | `ClusterIP`                          |
| dashboard.service.annotations             | Service annotations                                                             | `{}`                                 |
| dashboard.service.httpPort                | Port for HTTP traffic                                                           | `8081`                               |
