#!/bin/bash

##############################################
# Text Editors Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "📝 Installing Text Editors"

# Install Neovim
install_nvim() {
    if command -v nvim &> /dev/null; then
        log_warning "nvim already installed"
        return 0
    fi
    
    log_info "Installing Neovim..."
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -P /tmp
    tar -xzf /tmp/nvim-linux64.tar.gz -C /tmp
    mv /tmp/nvim-linux64 /opt/nvim
    ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim-linux64.tar.gz
    log_success "nvim installed"
}

# Install Vim
install_vim() {
    if command -v vim &> /dev/null; then
        log_warning "vim already installed"
        return 0
    fi
    
    log_info "Installing Vim..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y vim
    else
        yum install -y vim
    fi
    log_success "vim installed"
}

# Install Nano
install_nano() {
    if command -v nano &> /dev/null; then
        log_warning "nano already installed"
        return 0
    fi
    
    log_info "Installing Nano..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y nano
    else
        yum install -y nano
    fi
    log_success "nano installed"
}

# Main installation
main() {
    install_nvim
    install_vim
    install_nano
    
    log_success "Text editors installation complete!"
}

main
