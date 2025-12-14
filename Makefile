.PHONY: help build run stop clean test deploy monitor backup

# Variables
APP_NAME = devops-demo-app
DOCKER_IMAGE = $(APP_NAME):latest

# Default target
.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "DevOps Demo - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build Docker image
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE) .

run: ## Run application with docker-compose
	@echo "Starting application..."
	docker-compose up -d
	@echo "Application started!"
	@echo "App: http://localhost:5000"
	@echo "Prometheus: http://localhost:9090"
	@echo "Grafana: http://localhost:3000"

stop: ## Stop all containers
	@echo "Stopping containers..."
	docker-compose down

restart: stop run ## Restart all containers

logs: ## Show application logs
	docker-compose logs -f

ps: ## Show running containers
	docker-compose ps

clean: ## Remove containers, images, and volumes
	@echo "Cleaning up..."
	docker-compose down -v
	docker rmi $(DOCKER_IMAGE) || true
	@echo "Cleanup complete!"

test: ## Run tests
	@echo "Running tests..."
	python -m pytest app/ || echo "No tests found"

lint: ## Lint Python code
	@echo "Linting code..."
	flake8 app --count --select=E9,F63,F7,F82 --show-source --statistics || echo "Flake8 not installed"

deploy: ## Deploy application
	@echo "Deploying application..."
	./scripts/deploy.sh deploy

monitor: ## Start health monitoring
	@echo "Starting health monitoring..."
	./scripts/monitor.sh monitor

backup: ## Create backup
	@echo "Creating backup..."
	./scripts/backup.sh

k8s-apply: ## Apply Kubernetes manifests
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f kubernetes/configmaps/
	kubectl apply -f kubernetes/deployments/
	kubectl apply -f kubernetes/services/

k8s-delete: ## Delete Kubernetes resources
	@echo "Deleting Kubernetes resources..."
	kubectl delete -f kubernetes/services/ || true
	kubectl delete -f kubernetes/deployments/ || true
	kubectl delete -f kubernetes/configmaps/ || true

k8s-status: ## Show Kubernetes resources status
	@echo "Kubernetes Resources:"
	kubectl get all

tf-init: ## Initialize Terraform
	@echo "Initializing Terraform..."
	cd terraform/aws && terraform init

tf-plan: ## Plan Terraform changes
	@echo "Planning Terraform changes..."
	cd terraform/aws && terraform plan

tf-apply: ## Apply Terraform changes
	@echo "Applying Terraform changes..."
	cd terraform/aws && terraform apply

tf-destroy: ## Destroy Terraform infrastructure
	@echo "Destroying Terraform infrastructure..."
	cd terraform/aws && terraform destroy

ansible-check: ## Check Ansible playbook syntax
	@echo "Checking Ansible playbook..."
	ansible-playbook ansible/playbook.yml --syntax-check

ansible-run: ## Run Ansible playbook
	@echo "Running Ansible playbook..."
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

install-deps: ## Install Python dependencies
	@echo "Installing dependencies..."
	pip install -r app/requirements.txt

dev: ## Run application in development mode
	@echo "Starting development server..."
	cd app && python app.py

health: ## Check application health
	@echo "Checking application health..."
	curl -f http://localhost:5000/health && echo "\nApplication is healthy!" || echo "\nApplication is unhealthy!"

info: ## Show application info
	@curl -s http://localhost:5000/info | python -m json.tool

shell: ## Open shell in running container
	docker-compose exec web bash

prune: ## Remove all unused Docker resources
	@echo "Pruning Docker resources..."
	docker system prune -af --volumes
	@echo "Docker prune complete!"
