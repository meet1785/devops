#!/bin/bash

# Validation Script for DevOps Starter Repository
# This script validates the repository structure and contents

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "DevOps Starter Repository Validation"
echo "=========================================="
echo ""

# Function to check if file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1 (missing)"
        return 1
    fi
}

# Function to check if directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1/"
        return 0
    else
        echo -e "${RED}✗${NC} $1/ (missing)"
        return 1
    fi
}

ERRORS=0

# Check main files
echo "Checking main files..."
check_file "README.md" || ((ERRORS++))
check_file "Dockerfile" || ((ERRORS++))
check_file "docker-compose.yml" || ((ERRORS++))
check_file "Makefile" || ((ERRORS++))
check_file ".gitignore" || ((ERRORS++))
check_file "CONTRIBUTING.md" || ((ERRORS++))
echo ""

# Check application files
echo "Checking application files..."
check_dir "app" || ((ERRORS++))
check_file "app/app.py" || ((ERRORS++))
check_file "app/requirements.txt" || ((ERRORS++))
check_file "app/templates/index.html" || ((ERRORS++))
echo ""

# Check Docker files
echo "Checking Docker configuration..."
check_dir "docker" || ((ERRORS++))
check_file "docker/nginx.conf" || ((ERRORS++))
echo ""

# Check Kubernetes files
echo "Checking Kubernetes manifests..."
check_dir "kubernetes" || ((ERRORS++))
check_dir "kubernetes/deployments" || ((ERRORS++))
check_dir "kubernetes/services" || ((ERRORS++))
check_dir "kubernetes/configmaps" || ((ERRORS++))
check_dir "kubernetes/ingress" || ((ERRORS++))
check_file "kubernetes/deployments/app-deployment.yaml" || ((ERRORS++))
check_file "kubernetes/services/app-service.yaml" || ((ERRORS++))
check_file "kubernetes/configmaps/app-configmap.yaml" || ((ERRORS++))
check_file "kubernetes/ingress/app-ingress.yaml" || ((ERRORS++))
echo ""

# Check Terraform files
echo "Checking Terraform configuration..."
check_dir "terraform" || ((ERRORS++))
check_dir "terraform/aws" || ((ERRORS++))
check_file "terraform/aws/main.tf" || ((ERRORS++))
check_file "terraform/aws/variables.tf" || ((ERRORS++))
check_file "terraform/aws/outputs.tf" || ((ERRORS++))
echo ""

# Check Ansible files
echo "Checking Ansible configuration..."
check_dir "ansible" || ((ERRORS++))
check_file "ansible/playbook.yml" || ((ERRORS++))
check_file "ansible/inventory.ini" || ((ERRORS++))
check_dir "ansible/templates" || ((ERRORS++))
check_file "ansible/templates/devops-app.service.j2" || ((ERRORS++))
echo ""

# Check monitoring files
echo "Checking monitoring configuration..."
check_dir "monitoring" || ((ERRORS++))
check_file "monitoring/prometheus.yml" || ((ERRORS++))
check_dir "monitoring/grafana" || ((ERRORS++))
check_file "monitoring/grafana/dashboards/dashboard.yml" || ((ERRORS++))
echo ""

# Check scripts
echo "Checking automation scripts..."
check_dir "scripts" || ((ERRORS++))
check_file "scripts/deploy.sh" || ((ERRORS++))
check_file "scripts/backup.sh" || ((ERRORS++))
check_file "scripts/monitor.sh" || ((ERRORS++))
echo ""

# Check CI/CD workflows
echo "Checking CI/CD workflows..."
check_dir ".github" || ((ERRORS++))
check_dir ".github/workflows" || ((ERRORS++))
check_file ".github/workflows/ci-cd.yml" || ((ERRORS++))
check_file ".github/workflows/docker-publish.yml" || ((ERRORS++))
echo ""

# Check documentation
echo "Checking documentation..."
check_dir "docs" || ((ERRORS++))
check_file "docs/DOCKER.md" || ((ERRORS++))
check_file "docs/KUBERNETES.md" || ((ERRORS++))
check_file "docs/CICD.md" || ((ERRORS++))
check_file "docs/TERRAFORM.md" || ((ERRORS++))
check_file "docs/GETTING_STARTED.md" || ((ERRORS++))
echo ""

# Validate Python syntax
echo "Validating Python syntax..."
if python3 -m py_compile app/app.py 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Python syntax is valid"
else
    echo -e "${RED}✗${NC} Python syntax errors found"
    ((ERRORS++))
fi
echo ""

# Validate shell scripts
echo "Validating shell scripts..."
for script in scripts/*.sh; do
    if bash -n "$script" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $script syntax is valid"
    else
        echo -e "${RED}✗${NC} $script has syntax errors"
        ((ERRORS++))
    fi
done
echo ""

# Check script permissions
echo "Checking script permissions..."
for script in scripts/*.sh; do
    if [ -x "$script" ]; then
        echo -e "${GREEN}✓${NC} $script is executable"
    else
        echo -e "${YELLOW}⚠${NC} $script is not executable (but this is OK)"
    fi
done
echo ""

# Summary
echo "=========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo "The DevOps starter repository is complete and valid."
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    echo "Please review and fix the errors above."
    exit 1
fi
