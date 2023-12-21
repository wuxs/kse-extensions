# 服务网格扩展插件
服务网格扩展插件，用于 KubeSphere 平台启用服务网格。KubeSphere 服务网格基于 Istio，将微服务治理和流量管理可视化。它拥有强大的工具包，包括熔断机制、蓝绿部署、金丝雀发布、流量镜像、链路追踪、可观测性和流量控制等。

# 注意
- 需要在配置中配置可用的 Prometheus 服务和 OpenSearch 服务。


| 参数                                             | 含义                 | 默认值                                                               | 取值 |
| ------------------------------------------------ | -------------------- | -------------------------------------------------------------------- | -------- |
| backend.istiod.meshConfig.defaultConfig.sampling | 链路追踪采样率       | 1.0                                                                  | 1-100    |
| backend.kiali.prometheus_url                     | promethus 地址       | http://prometheus-operated.kubesphere-monitoring-system.svc:9090     |          |
| backend.storage.options.es.server-urls           | OpenSearch/ES 地址   | https://opensearch-cluster-master.kubesphere-logging-system.svc:9200 |          |
| backend.storage.options.es.username              | OpenSearch/ES 账户名 | admin                                                                |          |
| backend.storage.options.es.password              | OpenSearch/ES 密码   | admin                                                                |          |
| backend.storage.options.secretName         |         OpenSearch/ES 访问 Secret 名             |                                                                      |          |
