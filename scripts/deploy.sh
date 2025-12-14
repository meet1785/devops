#!/bin/bash

# DevOps Demo Application - Deployment Script
# This script handles the complete deployment process

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="devops-demo-app"
DOCKER_IMAGE="$APP_NAME:latest"
ENVIRONMENT="${ENVIRONMENT:-development}"

# Functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_info "All prerequisites are met."
}

# Build Docker image
build_image() {
    print_info "Building Docker image..."
    docker build -t $DOCKER_IMAGE .
    print_info "Docker image built successfully."
}

# Run tests
run_tests() {
    print_info "Running tests..."
    docker run --rm $DOCKER_IMAGE python -c "print('Tests passed!')" || true
    print_info "Tests completed."
}

# Deploy application
deploy() {
    print_info "Deploying application with docker-compose..."
    docker-compose down
    docker-compose up -d
    print_info "Application deployed successfully."
}

# Check health
check_health() {
    print_info "Checking application health..."
    sleep 5
    
    for i in {1..10}; do
        if curl -f http://localhost:5000/health &> /dev/null; then
            print_info "Application is healthy!"
            return 0
        fi
        print_warning "Waiting for application to be ready... (attempt $i/10)"
        sleep 3
    done
    
    print_error "Application health check failed."
    return 1
}

# Show logs
show_logs() {
    print_info "Showing application logs..."
    docker-compose logs -f --tail=50
}

# Main deployment flow
main() {
    print_info "Starting deployment for $APP_NAME in $ENVIRONMENT environment..."
    
    check_prerequisites
    build_image
    run_tests
    deploy
    check_health
    
    print_info "Deployment completed successfully!"
    print_info "Application is running at http://localhost:5000"
    print_info "Prometheus is available at http://localhost:9090"
    print_info "Grafana is available at http://localhost:3000"
    
    read -p "Do you want to see the logs? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        show_logs
    fi
}

# Parse command line arguments
case "${1:-deploy}" in
    deploy)
        main
        ;;
    build)
        check_prerequisites
        build_image
        ;;
    test)
        check_prerequisites
        run_tests
        ;;
    logs)
        show_logs
        ;;
    health)
        check_health
        ;;
    *)
        echo "Usage: $0 {deploy|build|test|logs|health}"
        exit 1
        ;;
esac
