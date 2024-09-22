# k8s-monitoring-stack
This repository contains Helm charts and configuration files for deploying a comprehensive monitoring and logging stack on a Kubernetes cluster using Prometheus, Grafana, and Loki, managed by ArgoCD. It includes custom Helm values files for Prometheus retention settings, Grafana persistence, and resource management.

# Monitoring Stack

This repository contains configurations and scripts for setting up a Kubernetes monitoring stack using `kube-prometheus-stack`, `loki-stack`, and ArgoCD. It includes instructions for creating a local Kubernetes cluster using `kind`, installing necessary tools, and deploying monitoring solutions.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Deployment](#deployment)
- [Monitoring Solutions](#monitoring-solutions)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- [Docker](https://www.docker.com/get-started)

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/charlmex/k8s-monitoring-stack.git
   cd k8s-monitoring-stack


2. Run the setup script to install kubectl, kind, Helm, and create a Kubernetes cluster:

   ```bash
   chmod +x setup-k8s.sh
   ./setup-k8s.sh

This script will:

- Install kubectl
- Install kind
- Create a local Kubernetes cluster
- Install Helm
- Install ArgoCD

After running the setup script, you can deploy the monitoring solutions.

To access the AgroCD UI, Open your browser and navigate to https://localhost:8081.


## Monitoring Solutions

# Prometheus and Grafana

Use the kube-prometheus-stack Helm chart to deploy Prometheus and Grafana.
Configure custom values file to tailor the deployment to your needs.

# Loki

Deploy the loki-stack for log aggregation.
Use a custom loki-values.yaml file for your configurations.



## Accessing Grafana and Prometheus

Once the applications are deployed, you can access Grafana and Prometheus.

# Grafana

   Get the Grafana service URL:

   ```bash
   kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80

 Access Grafana at http://localhost:3000. The default credentials are usually:

Username: admin
Password: prom-operator 


#  Prometheus

   Get the Prometheus service URL:

   ```bash
   kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090

Access Prometheus at http://localhost:9090



### Integrating Loki as datasource oin grafana

1. Log in to Grafana: Use the credentials mentioned above.
2. Add DataSource:
- Navigate to Configuration > Data Sources.
- Click on Add data source.
- Select Loki from the list.

3. Configure Loki DataSource:
In the URL field, enter the service name for Loki:

http://loki-stack:3100

Click Save & Test to verify the connection.

### Notes:

- Modify the instructions as needed based on your specific setup or preferences.
- Make sure to test the commands to ensure they work as expected.
- Add any additional sections that you think would be useful, like troubleshooting tips or FAQs.
