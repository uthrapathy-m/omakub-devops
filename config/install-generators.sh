#!/bin/bash

#############################################
# Install Custom DevOps Generators
#############################################

source "$(dirname "$0")/../install.sh" 2>/dev/null || true

log_header "📚 Installing Custom DevOps Generators"

GENERATORS_DIR="$(dirname "$0")/../generators"

# Make all generators executable
chmod +x "$GENERATORS_DIR"/* 2>/dev/null

# Copy generators to /usr/local/bin
log_info "Installing generators..."

for generator in "$GENERATORS_DIR"/*; do
    if [ -f "$generator" ]; then
        generator_name=$(basename "$generator")
        cp "$generator" "/usr/local/bin/$generator_name"
        chmod +x "/usr/local/bin/$generator_name"
        log_success "Installed: $generator_name"
    fi
done

log_success "All generators installed!"
echo ""
echo -e "${CYAN}${BOLD}Available generators:${NC}"
echo "• dockerfile-gen      - Generate Dockerfiles"
echo "• k8s-manifest-gen    - Generate K8s manifests"
echo "• compose-gen         - Generate docker-compose.yml"
echo "• helm-scaffold       - Create Helm charts"
echo "• sec-scan            - Security scanner wrapper"
echo "• cluster-health      - K8s cluster health check"
echo "• log-tail            - Multi-source log tailer"
echo ""
