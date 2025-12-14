# 🚀 DevOps Starter Repository

A comprehensive, production-ready starter repository for learning and practicing DevOps concepts. This project includes a sample Flask application with complete DevOps tooling and infrastructure.

![DevOps](https://img.shields.io/badge/DevOps-Complete-blue)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-326CE5?logo=kubernetes)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=github-actions)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [DevOps Components](#devops-components)
- [Learning Path](#learning-path)
- [Documentation](#documentation)
- [Contributing](#contributing)

## 🎯 Overview

This repository serves as a complete DevOps practice environment, covering essential concepts and tools used in modern software development and operations. It includes:

- **Application**: Python Flask web application
- **Containerization**: Docker and Docker Compose
- **Orchestration**: Kubernetes manifests
- **CI/CD**: GitHub Actions pipelines
- **Infrastructure as Code**: Terraform configurations
- **Configuration Management**: Ansible playbooks
- **Monitoring**: Prometheus and Grafana setup
- **Automation**: Shell scripts for common tasks

## ✨ Features

### Application Features
- ✅ RESTful API endpoints
- ✅ Health check endpoints
- ✅ System information APIs
- ✅ Beautiful web interface
- ✅ Production-ready with Gunicorn

### DevOps Features
- 🐳 **Docker**: Multi-stage Dockerfile, Docker Compose setup
- ☸️ **Kubernetes**: Deployments, Services, ConfigMaps, Ingress
- 🔄 **CI/CD**: Automated testing, building, and deployment
- 🏗️ **IaC**: Terraform configurations for AWS/Azure
- 🔧 **Automation**: Ansible playbooks for configuration management
- 📊 **Monitoring**: Prometheus metrics, Grafana dashboards
- 🔒 **Security**: Vulnerability scanning, non-root containers
- 📜 **Scripts**: Deployment, backup, and monitoring scripts

## 📁 Project Structure

```
devops/
├── app/                          # Flask application
│   ├── app.py                    # Main application file
│   ├── requirements.txt          # Python dependencies
│   └── templates/                # HTML templates
├── docker/                       # Docker configurations
│   └── nginx.conf                # Nginx reverse proxy config
├── kubernetes/                   # Kubernetes manifests
│   ├── deployments/              # Deployment definitions
│   ├── services/                 # Service definitions
│   ├── configmaps/               # ConfigMap definitions
│   └── ingress/                  # Ingress rules
├── terraform/                    # Infrastructure as Code
│   └── aws/                      # AWS infrastructure
│       ├── main.tf               # Main Terraform configuration
│       ├── variables.tf          # Variable definitions
│       └── outputs.tf            # Output definitions
├── ansible/                      # Configuration management
│   ├── playbook.yml              # Main playbook
│   ├── inventory.ini             # Inventory file
│   └── templates/                # Jinja2 templates
├── monitoring/                   # Monitoring setup
│   ├── prometheus.yml            # Prometheus configuration
│   └── grafana/                  # Grafana dashboards
├── scripts/                      # Automation scripts
│   ├── deploy.sh                 # Deployment script
│   ├── backup.sh                 # Backup script
│   └── monitor.sh                # Health monitoring script
├── .github/                      # GitHub configurations
│   └── workflows/                # CI/CD workflows
│       ├── ci-cd.yml             # Main CI/CD pipeline
│       └── docker-publish.yml    # Docker image publishing
├── docs/                         # Documentation
│   ├── DOCKER.md                 # Docker guide
│   ├── KUBERNETES.md             # Kubernetes guide
│   └── CICD.md                   # CI/CD guide
├── Dockerfile                    # Docker image definition
├── docker-compose.yml            # Multi-container setup
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Python 3.11+ (for local development)
- kubectl (for Kubernetes)
- Terraform (for infrastructure)
- Ansible (for configuration management)

### Running with Docker Compose

```bash
# Clone the repository
git clone https://github.com/meet1785/devops.git
cd devops

# Start all services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

### Accessing Services

- **Application**: http://localhost:5000
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (admin/admin)
- **Nginx**: http://localhost:80

### Using Deployment Script

```bash
# Make script executable
chmod +x scripts/deploy.sh

# Run deployment
./scripts/deploy.sh deploy

# View logs
./scripts/deploy.sh logs

# Check health
./scripts/deploy.sh health
```

## 🛠️ DevOps Components

### 1. Docker 🐳

Multi-stage Dockerfile with security best practices:
- Non-root user
- Health checks
- Minimal base image
- Layer optimization

```bash
# Build image
docker build -t devops-demo-app .

# Run container
docker run -d -p 5000:5000 devops-demo-app
```

**Learn more**: [Docker Guide](docs/DOCKER.md)

### 2. Kubernetes ☸️

Complete Kubernetes manifests for production deployment:
- Deployments with rolling updates
- Services for networking
- ConfigMaps for configuration
- Ingress for external access
- Health probes
- Resource limits

```bash
# Deploy to Kubernetes
kubectl apply -f kubernetes/configmaps/
kubectl apply -f kubernetes/deployments/
kubectl apply -f kubernetes/services/
```

**Learn more**: [Kubernetes Guide](docs/KUBERNETES.md)

### 3. CI/CD 🔄

GitHub Actions workflows for automation:
- Automated testing
- Security scanning (Trivy)
- Docker image building
- Multi-environment deployment
- Manual approval gates

**Learn more**: [CI/CD Guide](docs/CICD.md)

### 4. Infrastructure as Code 🏗️

Terraform configurations for cloud infrastructure:
- AWS VPC setup
- EC2 instances
- Security groups
- Load balancers
- State management

```bash
# Initialize Terraform
cd terraform/aws
terraform init

# Plan infrastructure
terraform plan

# Apply changes
terraform apply
```

### 5. Configuration Management 🔧

Ansible playbooks for server configuration:
- Application deployment
- Package installation
- Service management
- User management
- Firewall configuration

```bash
# Run playbook
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

### 6. Monitoring 📊

Complete observability stack:
- Prometheus for metrics collection
- Grafana for visualization
- Health check endpoints
- Container metrics

```bash
# Access Prometheus
open http://localhost:9090

# Access Grafana
open http://localhost:3000
```

### 7. Automation Scripts 📜

Useful scripts for common operations:
- **deploy.sh**: Complete deployment automation
- **backup.sh**: Backup configurations and data
- **monitor.sh**: Continuous health monitoring

```bash
# Deploy application
./scripts/deploy.sh deploy

# Create backup
./scripts/backup.sh

# Start monitoring
./scripts/monitor.sh monitor
```

## 📚 Learning Path

### Beginner Level
1. ✅ Run the application locally
2. ✅ Build and run Docker container
3. ✅ Use Docker Compose for multi-container setup
4. ✅ Understand application structure

### Intermediate Level
1. ✅ Deploy to Kubernetes (Minikube)
2. ✅ Set up monitoring with Prometheus/Grafana
3. ✅ Configure CI/CD pipelines
4. ✅ Use Ansible for configuration management

### Advanced Level
1. ✅ Implement infrastructure with Terraform
2. ✅ Set up production Kubernetes cluster
3. ✅ Implement blue-green deployments
4. ✅ Configure auto-scaling
5. ✅ Implement comprehensive monitoring and alerting

## 📖 Documentation

Detailed documentation for each component:

- [Docker Guide](docs/DOCKER.md) - Container best practices
- [Kubernetes Guide](docs/KUBERNETES.md) - Orchestration patterns
- [CI/CD Guide](docs/CICD.md) - Pipeline automation

## 🎓 Practice Exercises

### Exercise 1: Docker
- Modify the Dockerfile to use a different base image
- Add a new dependency to the application
- Optimize the Docker image size

### Exercise 2: Kubernetes
- Scale the deployment to 5 replicas
- Add a new ConfigMap and use it in the deployment
- Set up horizontal pod autoscaling

### Exercise 3: CI/CD
- Add a new test to the pipeline
- Create a staging environment
- Implement deployment approvals

### Exercise 4: Infrastructure
- Modify Terraform to add a database
- Set up multi-region deployment
- Implement state locking

### Exercise 5: Monitoring
- Create a custom Grafana dashboard
- Set up alerting rules in Prometheus
- Add application-specific metrics

## 🔒 Security

Security best practices implemented:
- Non-root Docker containers
- Security scanning in CI/CD
- Secrets management
- Network policies
- RBAC in Kubernetes
- Encrypted communications

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Flask framework
- Docker and Kubernetes communities
- GitHub Actions
- Terraform by HashiCorp
- Ansible by Red Hat
- Prometheus and Grafana

## 📞 Support

If you have any questions or need help:
- Open an issue
- Check the documentation in the `docs/` folder
- Review the example configurations

## 🎯 Next Steps

1. Start with the Quick Start guide
2. Read the component-specific documentation
3. Try the practice exercises
4. Experiment with different configurations
5. Build your own projects using this template

---

**Happy Learning! 🚀**

Made with ❤️ for the DevOps community