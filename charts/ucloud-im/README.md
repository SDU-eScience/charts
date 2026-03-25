# UCloud/IM
Helm chart for installing UCloud/IM in Kubernetes.


## Prerequisites
There are some prerequisites regarding storage, because UCloud/IM must be able to use the same shared storage from multiple namespaces and machines at the same time. This can be achieved by having a shared filesystem mounted directly on all the hosts or by using CSI drivers that allows you to create multiple static volumes, all pointing to the same shared storage. Below are two example configurations for the Helm chart, one using a simple host path mount and one using the CSI driver for CephFS.

```yaml
# example using hostPath
storage:
  capacity: 1Ti
  className: manual
  volume:
    hostPath:
      path: /example/path
      type: Directory
```

```yaml
# example using ceph-csi
storage:
  capacity: 1Ti
  className: csi-cephfs-sc
  volume:
    csi:
      driver: cephfs.csi.ceph.com
      nodeStageSecretRef:
        name: csi-cephfs-secret
        namespace: default
      volumeAttributes:
        clusterID:  9f0a7322-9dfc-43d0-892c-d69eb872d059
        fsName: cephfs
        staticVolume: "true"
        rootPath: /volumes/mygroup/example
      volumeHandle: cephfs-static-pv
```

In Kubernetes the volumes will be created with `accessMode` set to `ReadWriteMany`. For more configuration options, check the [storage](#storage) section in the Helm values reference below.


## Configuration
The following is a minimal example of a Helm values file that can be used for installing UCloud/IM. For a full list of all configuration options, see the next section.

```yaml
ingress:
  enabled: true
  hosts:
  - "example.com"
  - "*.example.com"

# provider deployment
provider:
  storage:
    size: 1Gi
    className: example

# shared storage for user data
storage:
  capacity: 1Ti
  className: manual
  volume:
    hostPath:
      path: /example/path
      type: Directory
```

Some general comments about the configuration.

* UCloud/IM requires some storage for the provider configuration. A volume can automatically be provisioned, as in the example above, or you can provide an `existingClaim` to use an existing volume. Be aware that the volume used for the configuration files _cannot_ be the same volume used for the user data.

* UCloud/IM must be accessible via https on a public address. An ingress ressource can automatically be provisioned.

* UCloud/IM needs two additional namespaces, which are automatically created by the Helm chart, used for running background tasks and user applications.

* As discussed under [prerequisites](#prerequisites) we need to configure access to a shared filesystem, where all the user data is stored. The installation creates a PVC in each of the namespaces for accessing this shared storage.

Use the following Helm commands for installing the software.

```console
$ helm repo add sdu-escience https://sdu-escience.github.io/charts
$ helm repo update
$ helm install myrelease sdu-escience/ucloud-im -n ucloud-im -f values.yaml
```


## Helm Values
Reference for all available Helm values.


### Network Policy
Configuration of the network policies.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| netpol.enabled                            | Create network policies for the deployments                              | `true`                               |
| netpol.ingress.http.allowed               | Allow ingress traffic to the http endpoint                               | `true`                               |
| netpol.ingress.http.namespace             | Allow only ingress traffic to the http endpoint from this namespace      | `""`                                 |
| netpol.ingress.metrics.allowed            | Allow ingress traffic to the metrics endpoint                            | `true`                               |
| netpol.ingress.metrics.namespace          | Allow only ingress traffic to the metrics endpoint from this namespace   | `""`                                 |


### Ingress
Configuration of the ingress.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| ingress.enabled                           | Specifies whether an Ingress should be created                           | `false`                              |
| ingress.annotations                       | Additional custom annotations for the Ingress                            | `{}`                                 |
| ingress.className                         | Name of the ingress class                                                | `""`                                 |
| ingress.hosts                             | List of hosts used for the Ingress                                       | `[]`                                 |
| ingress.tls                               | TLS configuration the Ingress                                            | `[]`                                 |


### Provider
Configuration of the the UCloud/IM deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| provider.revisionHistoryLimit             | The number of retained replica sets to allow rollback                    | `2`                                  |
| provider.nodeSelector                     | Node selector labels for provider pods                                   | `{}`                                 |
| provider.annotations                      | Annotations for provider pods                                            | `{}`                                 |
| provider.tolerations                      | Tolerations for provider pods                                            | `[]`                                 |
| provider.affinity                         | Affinity for provider pods                                               | `{}`                                 |
| provider.strategyType                     | Strategy type for replacing provider pods                                | `""`                                 |
| provider.command                          | Overrride the command for the provider container                         | `["/usr/bin/ucloud"]`                |
| provider.storage.size                     | Persistent Volume size                                                   | `1Gi`                                |
| provider.storage.className                | Persistent Volume storage class name                                     | `""`                                 |
| provider.storage.accessModes              | Persistent Volume access modes                                           | `["ReadWriteMany"]`                  |
| provider.storage.existingClaim            | Use an existing PVC which must be created beforehand                     | `""`                                 |
| provider.storage.subPath                  | The subdirectory of the volume to mount in the containers                | `""`                                 |
| provider.storage.selector                 | Additional labels to match for the PVC                                   | `{}`                                 |
| provider.storage.dataSource               | Custom data source for the PVC                                           | `{}`                                 |
| provider.image.repository                 | Provider image repository                                                | `dreg.cloud.sdu.dk/ucloud/im2`       |
| provider.image.pullPolicy                 | Provider image pull policy                                               | `IfNotPresent`                       |
| provider.image.tag                        | Provider image tag                                                       | `""`                                 |
| provider.service.type                     | Provider service type                                                    | `ClusterIP`                          |
| provider.service.annotations              | Provider service annotations                                             | `{}`                                 |


### Envoy
Configuration of the the Envoy deployment.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| envoy.revisionHistoryLimit                | The number of retained replica sets to allow rollback                    | `2`                                  |
| envoy.nodeSelector                        | Node selector labels for envoy pods                                      | `{}`                                 |
| envoy.annotations                         | Annotations for envoy pods                                               | `{}`                                 |
| envoy.tolerations                         | Tolerations for envoy pods                                               | `[]`                                 |
| envoy.affinity                            | Affinity for envoy pods                                                  | `{}`                                 |
| envoy.strategyType                        | Strategy type for replacing envoy pods                                   | `""`                                 |
| envoy.image.repository                    | Envoy image repository                                                   | `envoyproxy/envoy`                   |
| envoy.image.pullPolicy                    | Envoy image pull policy                                                  | `IfNotPresent`                       |
| envoy.image.tag                           | Envoy image tag                                                          | `v1.23-latest`                       |
| envoy.service.type                        | Envoy service type                                                       | `ClusterIP`                          |
| envoy.service.annotations                 | Envoy service annotations                                                | `{}`                                 |


### Storage
Configuration of the shared storage for user data.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| storage.capacity                          | Volume capacity                                                          | `1Ti`                                |
| storage.className                         | Volume storage class name                                                | `""`                                 |
| storage.volume.mountOptions               | Volume `mountOptions` configuration                                      | `""`                                 |
| storage.volume.hostPath                   | Volume `hostPath` configuration                                          | `{}`                                 |
| storage.volume.local                      | Volume `local` configuration                                             | `{}`                                 |
| storage.volume.csi                        | Volume `csi` configuration                                               | `{}`                                 |
| storage.volume.nfs                        | Volume `nfs` configuration                                               | `{}`                                 |


### Apps
Configuration of the namespace used for running user applications.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| apps.namespace                            | Namespace for running user applications                                  | `ucloud-apps`                        |
| apps.netpol.enabled                       | Create network policies for the namespace                                | `true`                               |
| apps.netpol.egress.allowed                | Allow egress traffic from the namespace                                  | `true`                               |
| apps.netpol.egress.blockPrivate           | Block egress traffic to private IPv4 subnets                             | `true`                               |
| apps.netpol.egress.toRules                | Custom rules for allowing egress traffic                                 | `[]`                                 |


### Tasks
Configuration of the namespace used for running background tasks.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| tasks.namespace                           | Namespace for running background tasks                                   | `ucloud-tasks`                       |
