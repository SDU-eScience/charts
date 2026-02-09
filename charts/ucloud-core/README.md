# UCloud/Core
Helm chart for installing UCloud/Core in Kubernetes.


## Configuration
The following is a minimal example of a Helm values file that can be used for installing UCloud/Core. For a full list of all configuration options, see the next section.

```yaml
storage:
  size: 1Gi
  storageClass: example
ingress:
  enabled: true
  host: example.com
```

Some general comments about the configuration.

* The installation consists of four different deployments. Three of the deployments handle different parts of the backend API and the last deployment is the webclient.

* The backend deployments all share a common storage volume for the configuration files. For this reason, the volume must be configured with `accessMode` set to `ReadWriteMany`.

* The Helm values file contains a `global` section that can be used to configure properties shared by all deployments, but each deployment can override the global defaults, as shown in the table below.

* UCloud/Core must be accessible via https on a public address. An ingress ressource can automatically be provisioned. Any cross communication between the different deployments is done via the public address.

Use the following Helm commands for installing the software.

```console
$ helm repo add sdu-escience https://sdu-escience.github.io/charts
$ helm repo update
$ helm install myrelease sdu-escience/ucloud-core -n ucloud-core --create-namespace -f values.yaml
```


## Helm Values
Reference for all available Helm values.


### Storage
Configuration for the shared storage ressource.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| storage.size                              | Persistent volume size                                                   | `1Gi`                                |
| storage.storageClass                      | Persistent volume storage class                                          | `""`                                 |
| storage.accessModes                       | Persistent volume access modes                                           | `["ReadWriteMany"]`                  |
| storage.existingClaim                     | Use an existing PVC which must be created beforehand                     | `""`                                 |
| storage.subPath                           | The subdirectory of the volume to mount in the containers                | `""`                                 |
| storage.selector                          | Additional labels to match for the PVC                                   | `{}`                                 |
| storage.dataSource                        | Custom data source for the PVC                                           | `{}`                                 |


### Ingress
Configuration for the shared ingress ressource.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| ingress.enabled                           | Enable ingress ressource                                                 | `false`                              |
| ingress.annotations                       | Ingress annotations                                                      | `{}`                                 |
| ingress.className                         | Ingress class name                                                       | `""`                                 |
| ingress.host                              | Ingress host name                                                        | `""`                                 |
| ingress.tls                               | Ingress TLS configuration                                                | `[]`                                 |


### Global
Global configuration for all deployments

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| global.revisionHistoryLimit               | Number of retained replica sets to allow rollback                        | `2`                                  |
| global.nodeSelector                       | Pod node selector labels                                                 | `{}`                                 |
| global.annotations                        | Pod annotations                                                          | `{}`                                 |
| global.tolerations                        | Pod tolerations                                                          | `[]`                                 |
| global.affinity                           | Pod affinity                                                             | `{}`                                 |
| global.service.type                       | Service type                                                             | `ClusterIP`                          |
| global.service.annotations                | Service annotations                                                      | `{}`                                 |


### Foundation
Configuration for the `foundation` deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| foundation.revisionHistoryLimit           | Number of retained replica sets to allow rollback                        | `2`                                  |
| foundation.nodeSelector                   | Pod node selector labels                                                 | `{}`                                 |
| foundation.annotations                    | Pod annotations                                                          | `{}`                                 |
| foundation.tolerations                    | Pod tolerations                                                          | `[]`                                 |
| foundation.affinity                       | Pod affinity                                                             | `{}`                                 |
| foundation.image.repository               | Image repository                                                         | `dreg.cloud.sdu.dk/ucloud/core2`     |
| foundation.image.pullPolicy               | Image pull policy                                                        | `IfNotPresent`                       |
| foundation.image.tag                      | Image tag                                                                | `2026.1.39`                          |
| foundation.service.type                   | Service type                                                             | `ClusterIP`                          |
| foundation.service.annotations            | Service annotations                                                      | `{}`                                 |


### Accounting
Configuration for the `accounting` deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| accounting.revisionHistoryLimit           | Number of retained replica sets to allow rollback                        | `2`                                  |
| accounting.nodeSelector                   | Pod node selector labels                                                 | `{}`                                 |
| accounting.annotations                    | Pod annotations                                                          | `{}`                                 |
| accounting.tolerations                    | Pod tolerations                                                          | `[]`                                 |
| accounting.affinity                       | Pod affinity                                                             | `{}`                                 |
| accounting.image.repository               | Image repository                                                         | `dreg.cloud.sdu.dk/ucloud/core2`     |
| accounting.image.pullPolicy               | Image pull policy                                                        | `IfNotPresent`                       |
| accounting.image.tag                      | Image tag                                                                | `2026.1.39`                          |
| accounting.service.type                   | Service type                                                             | `ClusterIP`                          |
| accounting.service.annotations            | Service annotations                                                      | `{}`                                 |


### Orchestrator
Configuration for the `orchestrator` deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| orchestrator.revisionHistoryLimit         | Number of retained replica sets to allow rollback                        | `2`                                  |
| orchestrator.nodeSelector                 | Pod node selector labels                                                 | `{}`                                 |
| orchestrator.annotations                  | Pod annotations                                                          | `{}`                                 |
| orchestrator.tolerations                  | Pod tolerations                                                          | `[]`                                 |
| orchestrator.affinity                     | Pod affinity                                                             | `{}`                                 |
| orchestrator.image.repository             | Image repository                                                         | `dreg.cloud.sdu.dk/ucloud/core2`     |
| orchestrator.image.pullPolicy             | Image pull policy                                                        | `IfNotPresent`                       |
| orchestrator.image.tag                    | Image tag                                                                | `2026.1.39`                          |
| orchestrator.service.type                 | Service type                                                             | `ClusterIP`                          |
| orchestrator.service.annotations          | Service annotations                                                      | `{}`                                 |


### Frontend
Configuration for the `frontend` deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| frontend.revisionHistoryLimit             | Number of retained replica sets to allow rollback                        | `2`                                  |
| frontend.nodeSelector                     | Pod node selector labels                                                 | `{}`                                 |
| frontend.annotations                      | Pod annotations                                                          | `{}`                                 |
| frontend.tolerations                      | Pod tolerations                                                          | `[]`                                 |
| frontend.affinity                         | Pod affinity                                                             | `{}`                                 |
| frontend.image.repository                 | Image repository                                                         | `dreg.cloud.sdu.dk/ucloud/webclient` |
| frontend.image.pullPolicy                 | Image pull policy                                                        | `IfNotPresent`                       |
| frontend.image.tag                        | Image tag                                                                | `2026.1.41`                          |
| frontend.service.type                     | Service type                                                             | `ClusterIP`                          |
| frontend.service.annotations              | Service annotations                                                      | `{}`                                 |
