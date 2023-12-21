# Service Mesh Extension
Service Mesh Extension, Used to enable ServiceMesh for the KubeSphere platform. 
On the basis of Istio, KubeSphere Service Mesh visualizes microservices governance and traffic management. It features a powerful toolkit including circuit breaking, blue-green deployment, canary release, traffic mirroring, tracing, observability, and traffic control.

# Notice
- The available Prometheus service and OpenSearch service need to be configured in the configuration.


| Name | Meaning                 |Default                      | Range |
| ------------------------------------------------ | -------------------- | -------------------------------------------------------------------- | -------- |
| backend.istiod.meshConfig.defaultConfig.sampling | 链路追踪采样率       | 1.0                                                                  | 1-100    |
| backend.kiali.prometheus_url                     | promethus 地址       | http://prometheus-operated.kubesphere-monitoring-system.svc:9090     |          |
| backend.storage.options.es.server-urls           | OpenSearch/ES 地址   | https://opensearch-cluster-master.kubesphere-logging-system.svc:9200 |          |
| backend.storage.options.es.username              | OpenSearch/ES 账户名 | admin                                                                |          |
| backend.storage.options.es.password              | OpenSearch/ES 密码   | admin                                                                |          |
| backend.storage.options.secretName         |         OpenSearch/ES 访问 Secret 名             |                                                                      |          |
