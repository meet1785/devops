# Getting Started Guide

Welcome! This guide will help you get started with the DevOps starter repository.

## Prerequisites

Before you begin, ensure you have the following installed:

### Required
- **Git**: Version control
- **Docker**: Container platform (20.10+)
- **Docker Compose**: Multi-container orchestration (v2.0+)

### Optional (for specific features)
- **Python 3.11+**: For local development
- **kubectl**: Kubernetes CLI
- **Minikube** or **kind**: Local Kubernetes
- **Terraform**: Infrastructure as Code (1.0+)
- **Ansible**: Configuration management (2.9+)
- **Make**: Build automation

## Quick Start (5 minutes)

### 1. Clone the Repository

```bash
git clone https://github.com/meet1785/devops.git
cd devops
```

### 2. Start the Application

```bash
# Using Makefile (recommended)
make run

# Or using docker-compose directly
docker-compose up -d
```

### 3. Verify It's Running

```bash
# Check container status
make ps

# Check application health
make health
```

### 4. Access the Application

Open your browser and visit:
- **Application**: http://localhost:5000
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (admin/admin)

## What You'll See

The application displays:
- Welcome page with DevOps topics
- Available API endpoints
- System status

## Next Steps

### Learn Docker

1. Review the Dockerfile
2. Read [Docker Guide](DOCKER.md)
3. Try building the image:
   ```bash
   make build
   ```

### Learn Kubernetes

1. Start Minikube:
   ```bash
   minikube start
   ```
2. Deploy to Kubernetes:
   ```bash
   make k8s-apply
   ```
3. Read [Kubernetes Guide](KUBERNETES.md)

### Learn CI/CD

1. Review `.github/workflows/ci-cd.yml`
2. Read [CI/CD Guide](CICD.md)
3. Fork the repo and see workflows in action

### Learn Terraform

1. Review `terraform/aws/`
2. Read [Terraform Guide](TERRAFORM.md)
3. Initialize Terraform:
   ```bash
   make tf-init
   ```

### Learn Ansible

1. Review `ansible/playbook.yml`
2. Update `ansible/inventory.ini` with your servers
3. Check playbook syntax:
   ```bash
   make ansible-check
   ```

## Common Tasks

### View Logs
```bash
make logs
```

### Restart Services
```bash
make restart
```

### Stop Everything
```bash
make stop
```

### Clean Up
```bash
make clean
```

### Create Backup
```bash
make backup
```

### Monitor Health
```bash
make monitor
```

## Development Workflow

### 1. Make Changes
Edit application code in `app/app.py`

### 2. Test Locally
```bash
# Install dependencies
make install-deps

# Run development server
make dev
```

### 3. Build and Test
```bash
# Build Docker image
make build

# Run with docker-compose
make run

# Test endpoints
curl http://localhost:5000/health
```

### 4. Deploy
```bash
make deploy
```

## Troubleshooting

### Port Already in Use

If port 5000 is already in use:
```bash
# Find process
lsof -i :5000

# Or change port in docker-compose.yml
```

### Docker Issues

```bash
# Restart Docker daemon
sudo systemctl restart docker

# Clean up Docker resources
make prune
```

### Permission Denied

```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in
```

### Container Won't Start

```bash
# View logs
make logs

# Check container status
docker-compose ps

# Inspect container
docker inspect devops-demo-app
```

## Learning Resources

### Official Documentation
- [Docker Docs](https://docs.docker.com/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Terraform Docs](https://www.terraform.io/docs)
- [Ansible Docs](https://docs.ansible.com/)

### Tutorials
- Docker: Start with `docs/DOCKER.md`
- Kubernetes: Deploy with Minikube
- CI/CD: Check workflow runs
- Terraform: Plan infrastructure

### Practice Exercises

1. **Easy**: Change the welcome message
2. **Medium**: Add a new API endpoint
3. **Hard**: Set up auto-scaling in Kubernetes
4. **Expert**: Implement blue-green deployment

## Project Structure Overview

```
devops/
├── app/              # Application code
├── docker/           # Docker configs
├── kubernetes/       # K8s manifests
├── terraform/        # IaC code
├── ansible/          # Configuration management
├── monitoring/       # Observability setup
├── scripts/          # Automation scripts
├── docs/             # Documentation
└── .github/          # CI/CD workflows
```

## Getting Help

- Check the [documentation](../README.md)
- Review [existing issues](https://github.com/meet1785/devops/issues)
- Read the component guides
- Open a new issue

## Contributing

Want to contribute? Great!
1. Read [CONTRIBUTING.md](../CONTRIBUTING.md)
2. Pick an issue or suggest a feature
3. Submit a pull request

## What's Next?

Now that you're up and running:

1. ✅ Explore the application
2. ✅ Read the documentation
3. ✅ Try the practice exercises
4. ✅ Deploy to Kubernetes
5. ✅ Set up CI/CD
6. ✅ Build your own project!

---

**Happy Learning! 🚀**

Need help? Open an issue or check the docs!
