#!/bin/bash

##############################################
# Monitoring & Observability Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "📊 Installing Monitoring & Observability Tools"

# Install Prometheus (binary)
install_prometheus() {
    if command -v prometheus &> /dev/null; then
        log_warning "prometheus already installed"
        return 0
    fi
    
    log_info "Installing Prometheus..."
    local PROM_VERSION=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
    wget "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/prometheus-${PROM_VERSION}.linux-amd64.tar.gz" -C /tmp
    
    mv "/tmp/prometheus-${PROM_VERSION}.linux-amd64/prometheus" /usr/local/bin/
    mv "/tmp/prometheus-${PROM_VERSION}.linux-amd64/promtool" /usr/local/bin/
    chmod +x /usr/local/bin/prometheus /usr/local/bin/promtool
    
    rm -rf "/tmp/prometheus-${PROM_VERSION}.linux-amd64"*
    log_success "prometheus installed"
}

# Install Grafana (binary)
install_grafana() {
    if command -v grafana-server &> /dev/null; then
        log_warning "grafana already installed"
        return 0
    fi
    
    log_info "Installing Grafana..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y software-properties-common wget
        wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
        echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list
        apt update
        apt install -y grafana
    else
        cat <<EOF | tee /etc/yum.repos.d/grafana.repo
[grafana]
name=grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF
        yum install -y grafana
    fi
    log_success "grafana installed"
}

# Install Node Exporter
install_node_exporter() {
    if command -v node_exporter &> /dev/null; then
        log_warning "node_exporter already installed"
        return 0
    fi
    
    log_info "Installing Node Exporter..."
    local NE_VERSION=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
    wget "https://github.com/prometheus/node_exporter/releases/download/v${NE_VERSION}/node_exporter-${NE_VERSION}.linux-amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/node_exporter-${NE_VERSION}.linux-amd64.tar.gz" -C /tmp
    mv "/tmp/node_exporter-${NE_VERSION}.linux-amd64/node_exporter" /usr/local/bin/
    chmod +x /usr/local/bin/node_exporter
    rm -rf "/tmp/node_exporter-${NE_VERSION}.linux-amd64"*
    log_success "node_exporter installed"
}

# Main installation
main() {
    install_prometheus
    install_grafana
    install_node_exporter
    
    log_success "Monitoring & Observability tools installation complete!"
}

main
