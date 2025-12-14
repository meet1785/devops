#!/bin/bash

# Health Monitoring Script
# Continuously monitors the application health

set -e

# Configuration
CHECK_INTERVAL=30
ALERT_THRESHOLD=3
FAILURE_COUNT=0

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

print_error() {
    echo -e "${RED}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

check_health() {
    if curl -f http://localhost:5000/health &> /dev/null; then
        return 0
    else
        return 1
    fi
}

send_alert() {
    local message="$1"
    print_error "ALERT: $message"
    # Add your alerting mechanism here (email, Slack, PagerDuty, etc.)
    # Example: curl -X POST https://hooks.slack.com/... -d "{\"text\":\"$message\"}"
}

monitor() {
    print_status "Starting health monitoring..."
    print_status "Checking every $CHECK_INTERVAL seconds"
    print_status "Alert threshold: $ALERT_THRESHOLD failures"
    echo ""
    
    while true; do
        if check_health; then
            print_status "✓ Application is healthy"
            FAILURE_COUNT=0
        else
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            print_warning "✗ Health check failed (attempt $FAILURE_COUNT/$ALERT_THRESHOLD)"
            
            if [ $FAILURE_COUNT -ge $ALERT_THRESHOLD ]; then
                send_alert "Application is unhealthy! Failed $FAILURE_COUNT consecutive checks."
                
                # Attempt auto-recovery
                print_status "Attempting automatic recovery..."
                docker-compose restart web || print_error "Failed to restart application"
                
                sleep 10
                if check_health; then
                    print_status "✓ Recovery successful"
                    FAILURE_COUNT=0
                    send_alert "Application recovered successfully"
                else
                    print_error "✗ Recovery failed"
                fi
            fi
        fi
        
        sleep $CHECK_INTERVAL
    done
}

# Main
case "${1:-monitor}" in
    monitor)
        monitor
        ;;
    check)
        if check_health; then
            print_status "✓ Application is healthy"
            exit 0
        else
            print_error "✗ Application is unhealthy"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {monitor|check}"
        exit 1
        ;;
esac
