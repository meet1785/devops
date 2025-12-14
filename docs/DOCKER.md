# Docker Guide

## Overview
This guide covers Docker concepts and usage in the DevOps Demo project.

## What is Docker?
Docker is a platform for developing, shipping, and running applications in containers. Containers are lightweight, portable, and self-sufficient units that package software and all its dependencies.

## Key Concepts

### 1. Dockerfile
A text file containing instructions to build a Docker image.

Our Dockerfile uses:
- **Multi-stage builds** for smaller images
- **Non-root user** for security
- **Health checks** for monitoring
- **Environment variables** for configuration

### 2. Docker Images
Read-only templates used to create containers.

### 3. Docker Containers
Running instances of Docker images.

### 4. Docker Compose
Tool for defining and running multi-container Docker applications.

## Common Commands

### Building and Running

```bash
# Build the Docker image
docker build -t devops-demo-app .

# Run a container
docker run -d -p 5000:5000 devops-demo-app

# Run with environment variables
docker run -d -p 5000:5000 -e ENVIRONMENT=production devops-demo-app

# Stop a container
docker stop <container_id>

# Remove a container
docker rm <container_id>
```

### Using Docker Compose

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f

# Restart a service
docker-compose restart web

# View running containers
docker-compose ps
```

### Image Management

```bash
# List images
docker images

# Remove an image
docker rmi devops-demo-app

# Pull an image
docker pull python:3.11-slim

# Tag an image
docker tag devops-demo-app:latest myrepo/devops-demo-app:v1.0
```

### Container Management

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Execute command in container
docker exec -it <container_id> bash

# View container logs
docker logs <container_id>

# Inspect container
docker inspect <container_id>
```

## Best Practices

1. **Use Multi-stage Builds**: Reduces final image size
2. **Run as Non-root User**: Improves security
3. **Use .dockerignore**: Exclude unnecessary files
4. **Tag Images Properly**: Use semantic versioning
5. **Keep Images Small**: Use alpine or slim base images
6. **One Process per Container**: Follow single responsibility principle
7. **Use Health Checks**: Enable monitoring and orchestration
8. **Don't Store Secrets in Images**: Use environment variables or secrets management

## Dockerfile Breakdown

```dockerfile
# Multi-stage build for efficiency
FROM python:3.11-slim as builder
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Production stage
FROM python:3.11-slim
RUN useradd -m -u 1000 appuser
WORKDIR /app
COPY --from=builder /root/.local /home/appuser/.local
COPY app/ .
USER appuser
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
```

## Docker Compose Services

Our setup includes:
- **web**: Flask application
- **prometheus**: Metrics collection
- **grafana**: Visualization
- **redis**: Caching layer
- **nginx**: Reverse proxy

## Troubleshooting

### Container won't start
```bash
docker logs <container_id>
docker inspect <container_id>
```

### Port already in use
```bash
# Find process using port
lsof -i :5000
# Or change port in docker-compose.yml
```

### Out of disk space
```bash
# Remove unused containers, images, networks
docker system prune -a
```

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Best Practices Guide](https://docs.docker.com/develop/dev-best-practices/)
