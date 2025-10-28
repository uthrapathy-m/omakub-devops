#!/bin/bash

##############################################
# CI/CD & GitOps Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🚀 Installing CI/CD & GitOps Tools"

# Install GitHub CLI
install_gh() {
    if command -v gh &> /dev/null; then
        log_warning "gh (GitHub CLI) already installed"
        return 0
    fi
    
    log_info "Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    apt update
    apt install -y gh
    log_success "GitHub CLI installed"
}

# Install GitLab CLI
install_glab() {
    if command -v glab &> /dev/null; then
        log_warning "glab (GitLab CLI) already installed"
        return 0
    fi
    
    log_info "Installing GitLab CLI..."
    local GLAB_VERSION=$(curl -s https://api.github.com/repos/profclems/glab/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/profclems/glab/releases/download/${GLAB_VERSION}/glab_${GLAB_VERSION#v}_Linux_x86_64.tar.gz" -P /tmp
    tar -xzf "/tmp/glab_${GLAB_VERSION#v}_Linux_x86_64.tar.gz" -C /tmp
    mv /tmp/bin/glab /usr/local/bin/
    chmod +x /usr/local/bin/glab
    rm -rf "/tmp/glab_${GLAB_VERSION#v}_Linux_x86_64.tar.gz" /tmp/bin
    log_success "GitLab CLI installed"
}

# Install Act (Run GitHub Actions locally)
install_act() {
    if command -v act &> /dev/null; then
        log_warning "act already installed"
        return 0
    fi
    
    log_info "Installing act..."
    curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash
    mv ./bin/act /usr/local/bin/
    rm -rf ./bin
    log_success "act installed"
}

# Install ArgoCD CLI
install_argocd() {
    if command -v argocd &> /dev/null; then
        log_warning "argocd CLI already installed"
        return 0
    fi
    
    log_info "Installing ArgoCD CLI..."
    local ARGOCD_VERSION=$(curl -s https://api.github.com/repos/argoproj/argo-cd/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64" -O /usr/local/bin/argocd
    chmod +x /usr/local/bin/argocd
    log_success "ArgoCD CLI installed"
}

# Install Flux CLI
install_flux() {
    if command -v flux &> /dev/null; then
        log_warning "flux already installed"
        return 0
    fi
    
    log_info "Installing Flux CLI..."
    curl -s https://fluxcd.io/install.sh | bash
    log_success "Flux CLI installed"
}

# Main installation
main() {
    install_gh
    install_glab
    install_act
    install_argocd
    install_flux
    
    log_success "CI/CD & GitOps tools installation complete!"
}

main
