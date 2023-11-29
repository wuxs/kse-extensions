# Kubernetes Metrics Server

Kubernetes Metrics Server 是 Kubernetes 内置的自动缩放流程的可扩展且高效的容器资源度量数据源。

Metrics Server 从 Kubelets 收集资源度量数据，并通过 [Metrics API](https://github.com/kubernetes/metrics) 将其暴露在 Kubernetes apiserver 中，供 [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) 和 [Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler/) 使用。Metrics API 也可以通过 kubectl top 访问，方便调试自动缩放流程。

Metrics Server不适用于非自动缩放的用途。例如，不要将其用于将度量数据转发到监控解决方案，或作为监控解决方案度量数据的来源。在这种情况下，请直接从 Kubelet 的 `/metrics/resource` 端点收集度量数据。

Metrics Server提供以下功能：

- 单个部署适用于大多数集群（参见Requirements）
- 快速自动缩放，每15秒收集度量数据。
- 资源高效，每个节点使用1毫核CPU和2 MB内存。
- 支持高达5,000个节点的可扩展性。
