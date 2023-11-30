# 服务网格扩展插件
服务网格扩展插件，用于 KubeSphere 平台启用服务网格。KubeSphere 服务网格基于 Istio，将微服务治理和流量管理可视化。它拥有强大的工具包，包括熔断机制、蓝绿部署、金丝雀发布、流量镜像、链路追踪、可观测性和流量控制等。

# 注意
- 需要在配置中配置可用的 Prometheus 服务和 OpenSearch 服务。
- Jaeger Operator 需要安装 [cert-manager](https://cert-manager.io/docs/installation/) 1.6.1+，或者有 Webhook 服务证书的 Secret。