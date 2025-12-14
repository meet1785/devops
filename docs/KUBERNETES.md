# Kubernetes Guide

## Overview
Kubernetes (K8s) is an open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.

## Key Concepts

### 1. Pods
The smallest deployable units in Kubernetes. A pod can contain one or more containers.

### 2. Deployments
Manage the desired state of pods. Handle rolling updates and rollbacks.

### 3. Services
Expose pods to network traffic. Provide stable endpoints for pods.

### 4. ConfigMaps
Store non-confidential configuration data in key-value pairs.

### 5. Ingress
Manages external access to services, typically HTTP/HTTPS.

## Project Structure

```
kubernetes/
├── deployments/     # Application deployments
├── services/        # Service definitions
├── configmaps/      # Configuration data
└── ingress/         # Ingress rules
```

## Common Commands

### Cluster Management

```bash
# Get cluster info
kubectl cluster-info

# View nodes
kubectl get nodes

# View all resources
kubectl get all
```

### Deployment Management

```bash
# Apply configuration
kubectl apply -f kubernetes/deployments/app-deployment.yaml

# Get deployments
kubectl get deployments

# Describe deployment
kubectl describe deployment devops-demo-app

# Scale deployment
kubectl scale deployment devops-demo-app --replicas=5

# Update image
kubectl set image deployment/devops-demo-app app=devops-demo-app:v2

# Rollback deployment
kubectl rollout undo deployment/devops-demo-app

# View rollout status
kubectl rollout status deployment/devops-demo-app
```

### Pod Management

```bash
# Get pods
kubectl get pods

# Describe pod
kubectl describe pod <pod-name>

# View logs
kubectl logs <pod-name>

# Execute command in pod
kubectl exec -it <pod-name> -- bash

# Port forward
kubectl port-forward <pod-name> 5000:5000
```

### Service Management

```bash
# Get services
kubectl get services

# Describe service
kubectl describe service devops-demo-service

# Expose deployment
kubectl expose deployment devops-demo-app --type=LoadBalancer --port=80
```

### ConfigMap Management

```bash
# Create ConfigMap
kubectl create configmap app-config --from-file=config.properties

# Get ConfigMaps
kubectl get configmaps

# View ConfigMap
kubectl describe configmap app-config

# Apply from file
kubectl apply -f kubernetes/configmaps/app-configmap.yaml
```

## Deployment Strategy

### Rolling Update (Default)
Updates pods gradually, ensuring availability.

```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
```

### Blue-Green Deployment
Run two versions simultaneously, switch traffic.

### Canary Deployment
Gradually roll out to subset of users.

## Health Checks

### Liveness Probe
Checks if container is alive. Restarts if fails.

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 5000
  initialDelaySeconds: 30
  periodSeconds: 10
```

### Readiness Probe
Checks if container is ready for traffic.

```yaml
readinessProbe:
  httpGet:
    path: /health
    port: 5000
  initialDelaySeconds: 10
  periodSeconds: 5
```

## Resource Management

```yaml
resources:
  requests:
    memory: "128Mi"
    cpu: "100m"
  limits:
    memory: "256Mi"
    cpu: "200m"
```

## Quick Start

1. **Start local cluster (Minikube)**
```bash
minikube start
```

2. **Build and load image**
```bash
docker build -t devops-demo-app:latest .
minikube image load devops-demo-app:latest
```

3. **Deploy application**
```bash
kubectl apply -f kubernetes/configmaps/
kubectl apply -f kubernetes/deployments/
kubectl apply -f kubernetes/services/
```

4. **Access application**
```bash
minikube service devops-demo-service
```

## Production Deployment

For production, consider:
- **Namespaces**: Isolate resources
- **RBAC**: Role-based access control
- **Network Policies**: Control pod communication
- **Resource Quotas**: Limit resource usage
- **Pod Security Policies**: Security constraints
- **Horizontal Pod Autoscaler**: Auto-scaling

## Troubleshooting

### Pod not starting
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events
```

### Service not accessible
```bash
kubectl describe service <service-name>
kubectl get endpoints
```

### Check resource usage
```bash
kubectl top nodes
kubectl top pods
```

## Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Kubernetes Patterns](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)
