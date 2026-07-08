# Kubernetes Observability Platform

A GitOps-managed Kubernetes observability platform deploying metrics, dashboards, and centralized logging using **Prometheus**, **Grafana**, **Loki**, **Helm**, and **ArgoCD**.

This project demonstrates a production-oriented approach to Kubernetes observability by automating the deployment of monitoring and logging components on a local Kubernetes cluster using **kind** and managing application delivery through GitOps workflows.

The platform provides:

* Kubernetes cluster bootstrap automation
* GitOps-based application deployment
* Metrics collection and visualization
* Centralized log aggregation
* Helm-based configuration management
* Custom resource tuning and persistence configuration

---

# Architecture Overview

The platform consists of the following components:

```
k8s-observability-platform

Kubernetes Cluster (kind)
│
├── ArgoCD
│   └── GitOps Application Management
│
├── kube-prometheus-stack
│   │
│   ├── Prometheus
│   │   └── Metrics collection
│   │
│   ├── AlertManager
│   │   └── Alert management
│   │
│   ├── Grafana
│   │   └── Dashboards and visualization
│   │
│   └── Kubernetes exporters
│       └── Cluster metrics
│
├── Loki Stack
│   │
│   ├── Loki
│   │   └── Log aggregation backend
│   │
│   └── Promtail
│       └── Kubernetes log collection
│
└── Custom Helm Configuration
    ├── Resource tuning
    ├── Persistence settings
    └── Retention configuration
```

---

# Repository Structure

```
k8s-observability-platform
│
├── setup-k8s.sh
│   └── Kubernetes environment bootstrap script
│
├── kind-config.yaml
│   └── Local Kubernetes cluster configuration
│
├── monitoring-stack
│
│   ├── argocd-apps
│   │   ├── kube-prometheus-stack-application.yaml
│   │   └── loki-stack-application.yaml
│   │
│   ├── kube-prometheus-stack
│   │   ├── Chart.yaml
│   │   ├── values.yaml
│   │   └── custom-values.yaml
│   │
│   └── loki-stack
│       ├── Chart.yaml
│       ├── values.yaml
│       └── custom-values.yaml
│
└── README.md
```

---

# Platform Components

## GitOps Deployment

### ArgoCD

ArgoCD manages Kubernetes application deployment using GitOps principles.

The desired cluster state is stored in Git and automatically synchronized with Kubernetes.

Capabilities:

* Declarative application deployment
* Automated synchronization
* Configuration drift detection
* Kubernetes resource reconciliation

Application definitions:

```
monitoring-stack/argocd-apps/
```

Configured applications:

* kube-prometheus-stack
* Loki stack

---

# Monitoring Stack

## Prometheus and Grafana

The monitoring platform uses the **kube-prometheus-stack** Helm chart.

Components:

* Prometheus
* Grafana
* AlertManager
* Kubernetes exporters

Capabilities:

* Kubernetes resource monitoring
* Node and workload metrics
* Cluster health visibility
* Dashboard visualization
* Alerting foundation

Configuration:

```
monitoring-stack/kube-prometheus-stack/
```

Custom settings include:

* Resource configuration
* Persistence settings
* Retention configuration

---

# Logging Stack

## Loki and Promtail

The logging platform uses Loki for centralized Kubernetes log aggregation.

Components:

* Loki
* Promtail
* Grafana Loki datasource

Capabilities:

* Container log collection
* Kubernetes workload troubleshooting
* Centralized log querying
* Integration with Grafana dashboards

Configuration:

```
monitoring-stack/loki-stack/
```

---

# Prerequisites

Before starting, install:

* Docker
* kubectl
* Helm
* kind

Verify installations:

```bash
docker --version

kubectl version --client

helm version

kind version
```

---

# Kubernetes Cluster Setup

The project includes a bootstrap script for creating a local Kubernetes environment.

Make the script executable:

```bash
chmod +x setup-k8s.sh
```

Run:

```bash
./setup-k8s.sh
```

The script performs:

* kubectl installation
* kind installation
* Kubernetes cluster creation
* Helm installation
* ArgoCD installation

---

# Deploy Applications

After the cluster is created, deploy the ArgoCD applications:

```bash
kubectl apply \
-f monitoring-stack/argocd-apps/
```

ArgoCD will synchronize the configured Helm applications and deploy:

* Prometheus monitoring stack
* Grafana dashboards
* Loki logging stack

---

# Access ArgoCD

Forward the ArgoCD server:

```bash
kubectl port-forward \
svc/argocd-server \
-n argocd 8081:443
```

Access:

```
https://localhost:8081
```

Retrieve the initial password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

Login:

```
Username:
admin
```

---

# Access Grafana

Forward Grafana:

```bash
kubectl port-forward \
svc/kube-prometheus-stack-grafana \
-n monitoring 3000:80
```

Access:

```
http://localhost:3000
```

Default credentials:

```
Username:
admin

Password:
prom-operator
```

> Change default credentials for production deployments.

---

# Access Prometheus

Forward Prometheus:

```bash
kubectl port-forward \
svc/kube-prometheus-stack-prometheus \
-n monitoring 9090:9090
```

Access:

```
http://localhost:9090
```

---

# Configure Loki Datasource in Grafana

After Grafana is available:

1. Login to Grafana
2. Navigate to:

```
Configuration
→ Data Sources
→ Add Data Source
→ Loki
```

Configure Loki URL:

```
http://loki-stack:3100
```

Select:

```
Save & Test
```

Grafana can now query Kubernetes logs through Loki.

---

# Technologies Used

| Category           | Technology |
| ------------------ | ---------- |
| Container Platform | Kubernetes |
| Local Cluster      | kind       |
| GitOps             | ArgoCD     |
| Package Management | Helm       |
| Metrics Collection | Prometheus |
| Visualization      | Grafana    |
| Logging            | Loki       |
| Automation         | Bash       |
| Configuration      | YAML       |

---

# Engineering Concepts Demonstrated

This project demonstrates practical Kubernetes platform engineering concepts:

* Kubernetes cluster automation
* GitOps-based deployment workflows
* Helm application management
* Observability architecture
* Metrics and logging integration
* Infrastructure automation
* Declarative configuration management

---

# Future Improvements

Potential enhancements:

* Add AlertManager notification routing
* Add custom PrometheusRule examples
* Add Grafana dashboard provisioning
* Add GitHub Actions validation workflow
* Add Helm dependency automation
* Add Kubernetes security scanning
* Add multi-cluster ArgoCD ApplicationSets
* Add production ingress configuration

---

# Author

Platform Engineering / DevOps portfolio project focused on:

* Kubernetes operations
* GitOps workflows
* Cloud-native observability
* Infrastructure automation
* Secure platform engineering practices

