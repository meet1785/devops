#!/bin/bash

# Backup Script for DevOps Demo Application
# This script creates backups of important data and configurations

set -e

# Configuration
BACKUP_DIR="${BACKUP_DIR:-/tmp/backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="devops-demo-backup-$TIMESTAMP"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Create backup directory
mkdir -p "$BACKUP_PATH"

print_info "Starting backup process..."

# Backup application files
print_info "Backing up application files..."
tar -czf "$BACKUP_PATH/app.tar.gz" app/ 2>/dev/null || print_warning "No app directory found"

# Backup configurations
print_info "Backing up configurations..."
tar -czf "$BACKUP_PATH/configs.tar.gz" \
    kubernetes/ \
    terraform/ \
    ansible/ \
    monitoring/ \
    docker-compose.yml \
    Dockerfile \
    2>/dev/null || print_warning "Some config files not found"

# Backup Docker volumes
print_info "Backing up Docker volumes..."
docker run --rm -v devops_prometheus-data:/data -v "$BACKUP_PATH":/backup \
    alpine tar -czf /backup/prometheus-data.tar.gz -C /data . 2>/dev/null || print_warning "Prometheus volume not found"

docker run --rm -v devops_grafana-data:/data -v "$BACKUP_PATH":/backup \
    alpine tar -czf /backup/grafana-data.tar.gz -C /data . 2>/dev/null || print_warning "Grafana volume not found"

# Create backup manifest
print_info "Creating backup manifest..."
cat > "$BACKUP_PATH/manifest.txt" << EOF
Backup Created: $TIMESTAMP
Hostname: $(hostname)
User: $(whoami)
Files:
$(ls -lh "$BACKUP_PATH")
EOF

# Compress entire backup
print_info "Compressing backup..."
cd "$BACKUP_DIR"
tar -czf "$BACKUP_NAME.tar.gz" "$BACKUP_NAME"
rm -rf "$BACKUP_NAME"

print_info "Backup completed successfully!"
print_info "Backup location: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
print_info "Backup size: $(du -h "$BACKUP_DIR/$BACKUP_NAME.tar.gz" | cut -f1)"

# Clean up old backups (keep last 5)
print_info "Cleaning up old backups..."
cd "$BACKUP_DIR"
ls -t devops-demo-backup-*.tar.gz | tail -n +6 | xargs -r rm
print_info "Cleanup completed."
