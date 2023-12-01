# Service Mesh Extension
Service Mesh Extension, Used to enable ServiceMesh for the KubeSphere platform. 
On the basis of Istio, KubeSphere Service Mesh visualizes microservices governance and traffic management. It features a powerful toolkit including circuit breaking, blue-green deployment, canary release, traffic mirroring, tracing, observability, and traffic control.

# Notice
- The available Prometheus service and OpenSearch service need to be configured in the configuration.
- Jaeger Operator needs [cert-manager](https://cert-manager.io/docs/installation/) 1.6.1+ installed, or certificate for webhook service in a secret.