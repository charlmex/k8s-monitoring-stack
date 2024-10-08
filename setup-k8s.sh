#!/bin/bash

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Verify kubectl installation
kubectl version --client

# Install kind
echo "Installing kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Verify kind installation
kind --version

# Create kind cluster
echo "Creating kind cluster..."
cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
EOF
kind create cluster --config kind-config.yaml

# Verify cluster is created
kubectl get nodes

# Install Helm
echo "Installing Helm..."
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify Helm installation
helm version

# Add Helm repo and install NGINX using Helm (optional)
echo "Deploying NGINX using Helm..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-nginx bitnami/nginx

# Show pods
kubectl get pods

# Port-forward to access NGINX (optional)
#kubectl port-forward svc/my-nginx 8080:80




# Install ArgoCD
echo "Installing ArgoCD..."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD server to be ready
kubectl wait --for=condition=available --timeout=60s deployment/argocd-server -n argocd

# Expose the ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8082:443 &

echo "ArgoCD installed. Access it at http://localhost:8082."
echo "Default username: admin"
echo "Retrieve the initial password with: kubectl get pods -n argocd -o name | grep argocd-server | xargs -I {} kubectl logs {} -n argocd | grep 'admin' | awk '{print $NF}'"
