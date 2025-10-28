#!/bin/bash

##############################################
# Networking & Debugging Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🌐 Installing Networking & Debugging Tools"

# Install mtr
install_mtr() {
    if command -v mtr &> /dev/null; then
        log_warning "mtr already installed"
        return 0
    fi
    
    log_info "Installing mtr..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y mtr
    else
        yum install -y mtr
    fi
    log_success "mtr installed"
}

# Install nmap
install_nmap() {
    if command -v nmap &> /dev/null; then
        log_warning "nmap already installed"
        return 0
    fi
    
    log_info "Installing nmap..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y nmap
    else
        yum install -y nmap
    fi
    log_success "nmap installed"
}

# Install httpie
install_httpie() {
    if command -v http &> /dev/null; then
        log_warning "httpie already installed"
        return 0
    fi
    
    log_info "Installing httpie..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y httpie
    else
        yum install -y httpie
    fi
    log_success "httpie installed"
}

# Install curl (if not present)
install_curl() {
    if command -v curl &> /dev/null; then
        log_warning "curl already installed"
        return 0
    fi
    
    log_info "Installing curl..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y curl
    else
        yum install -y curl
    fi
    log_success "curl installed"
}

# Install grpcurl
install_grpcurl() {
    if command -v grpcurl &> /dev/null; then
        log_warning "grpcurl already installed"
        return 0
    fi
    
    log_info "Installing grpcurl..."
    local GRPCURL_VERSION=$(curl -s https://api.github.com/repos/fullstorydev/grpcurl/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/fullstorydev/grpcurl/releases/download/${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION#v}_linux_x86_64.tar.gz" -P /tmp
    tar -xzf "/tmp/grpcurl_${GRPCURL_VERSION#v}_linux_x86_64.tar.gz" -C /tmp
    mv /tmp/grpcurl /usr/local/bin/
    chmod +x /usr/local/bin/grpcurl
    rm "/tmp/grpcurl_${GRPCURL_VERSION#v}_linux_x86_64.tar.gz"
    log_success "grpcurl installed"
}

# Main installation
main() {
    install_mtr
    install_nmap
    install_httpie
    install_curl
    install_grpcurl
    
    log_success "Networking & Debugging tools installation complete!"
}

main
