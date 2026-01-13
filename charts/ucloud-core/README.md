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

Use the following Helm command for installing the software.

```console
$ helm install myrelease ./ucloud-core -n ucloud-core --create-namespace -f values.yaml
```


## Helm Values
Reference for all available Helm values.

| Name                                      | Description                                                              | Value                                |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------ |
| storage.size                              | Persistent volume size                                                   | `1Gi`                                |
| storage.storageClass                      | Persistent volume storage class                                          | `""`                                 |
| storage.accessModes                       | Persistent volume access modes                                           | `["ReadWriteMany"]`                  |
| storage.existingClaim                     | Use an existing PVC which must be created beforehand                     | `""`                                 |
| storage.subPath                           | The subdirectory of the volume to mount in the containers                | `""`                                 |
| storage.selector                          | Additional labels to match for the PVC                                   | `{}`                                 |
| storage.dataSource                        | Custom data source for the PVC                                           | `{}`                                 |
| ingress.enabled                           | Enable ingress ressource                                                 | `false`                              |
| ingress.annotations                       | Ingress annotations                                                      | `{}`                                 |
| ingress.host                              | Ingress host name                                                        | `""`                                 |
| ingress.tls                               | Ingress TLS configuration                                                | `[]`                                 |
| global.revisionHistoryLimit               | Number of retained replica sets to allow rollback                        | `2`                                  |
| global.nodeSelector                       | Pod node selector labels                                                 | `{}`                                 |
| global.annotations                        | Pod annotations                                                          | `{}`                                 |
| global.tolerations                        | Pod tolerations                                                          | `[]`                                 |
| global.affinity                           | Pod affinity                                                             | `{}`                                 |
| global.image.repository                   | Image repository                                                         | `dreg.cloud.sdu.dk/ucloud/core2`     |
| global.image.pullPolicy                   | Image pull policy                                                        | `IfNotPresent`                       |
| global.image.tag                          | Image tag                                                                | `""`                                 |
| global.service.type                       | Service type                                                             | `ClusterIP`                          |
| global.service.annotations                | Service annotations                                                      | `{}`                                 |
| accounting                                | Settings for accounting deployment, overrides `global` settings          | `{}`                                 |
| foundation                                | Settings for foundation deployment, overrides `global` settings          | `{}`                                 |
| orchestrator                              | Settings for orchestrator deployment, overrides `global` settings        | `{}`                                 |
| frontend                                  | Settings for frontend deployment, overrides `global` settings            | `{}`                                 |
| frontend.image.repository                 | Frontend image repository                                                | `dreg.cloud.sdu.dk/ucloud/webclient` |
| frontend.image.pullPolicy                 | Frontend image pull policy                                               | `IfNotPresent`                       |
| frontend.image.tag                        | Frontend image tag                                                       | `""`                                 |
