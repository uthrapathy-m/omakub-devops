#!/bin/bash

##############################################
# Development Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🛠️  Installing Development Tools"

# Install Git
install_git() {
    if command -v git &> /dev/null; then
        log_warning "git already installed"
        return 0
    fi
    
    log_info "Installing Git..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y git
    else
        yum install -y git
    fi
    log_success "git installed"
}

# Install Make
install_make() {
    if command -v make &> /dev/null; then
        log_warning "make already installed"
        return 0
    fi
    
    log_info "Installing Make..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y build-essential
    else
        yum groupinstall -y "Development Tools"
    fi
    log_success "make installed"
}

# Install Python3 and pip3
install_python() {
    if command -v python3 &> /dev/null; then
        log_warning "python3 already installed"
    else
        log_info "Installing Python3..."
        if [ "$PKG_MANAGER" = "apt" ]; then
            apt install -y python3
        else
            yum install -y python3
        fi
    fi
    
    if ! command -v pip3 &> /dev/null; then
        log_info "Installing pip3..."
        if [ "$PKG_MANAGER" = "apt" ]; then
            apt install -y python3-pip
        else
            yum install -y python3-pip
        fi
    fi
    
    log_success "python3 and pip3 installed"
}

# Install Go
install_go() {
    if command -v go &> /dev/null; then
        log_warning "go already installed"
        return 0
    fi
    
    log_info "Installing Go..."
    local GO_VERSION="1.22.0"
    wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -P /tmp
    rm -rf /usr/local/go
    tar -C /usr/local -xzf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"
    
    # Add to PATH for all users
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
    echo 'export PATH=$PATH:$HOME/go/bin' >> /etc/profile
    
    rm "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"
    log_success "go installed"
}

# Install Node.js and npm
install_node() {
    if command -v node &> /dev/null; then
        log_warning "node already installed"
        return 0
    fi
    
    log_info "Installing Node.js and npm..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y nodejs
    else
        yum install -y nodejs
    fi
    log_success "node and npm installed"
}

# Main installation
main() {
    install_git
    install_make
    install_python
    install_go
    install_node
    
    log_success "Development tools installation complete!"
}

main
