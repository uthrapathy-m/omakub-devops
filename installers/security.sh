#!/bin/bash

##############################################
# Security & Compliance Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🔒 Installing Security & Compliance Tools"

# Install Trivy
install_trivy() {
    if command -v trivy &> /dev/null; then
        log_warning "trivy already installed"
        return 0
    fi
    
    log_info "Installing Trivy..."
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy.gpg
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/trivy.list
    apt update
    apt install -y trivy
    log_success "trivy installed"
}

# Install Hadolint
install_hadolint() {
    if command -v hadolint &> /dev/null; then
        log_warning "hadolint already installed"
        return 0
    fi
    
    log_info "Installing Hadolint..."
    local HADOLINT_VERSION=$(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" -O /usr/local/bin/hadolint
    chmod +x /usr/local/bin/hadolint
    log_success "hadolint installed"
}

# Install kube-bench
install_kube_bench() {
    if command -v kube-bench &> /dev/null; then
        log_warning "kube-bench already installed"
        return 0
    fi
    
    log_info "Installing kube-bench..."
    local KB_VERSION=$(curl -s https://api.github.com/repos/aquasecurity/kube-bench/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/aquasecurity/kube-bench/releases/download/${KB_VERSION}/kube-bench_${KB_VERSION#v}_linux_amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/kube-bench_${KB_VERSION#v}_linux_amd64.tar.gz" -C /tmp
    mv /tmp/kube-bench /usr/local/bin/
    chmod +x /usr/local/bin/kube-bench
    rm "/tmp/kube-bench_${KB_VERSION#v}_linux_amd64.tar.gz"
    log_success "kube-bench installed"
}

# Install kubesec
install_kubesec() {
    if command -v kubesec &> /dev/null; then
        log_warning "kubesec already installed"
        return 0
    fi
    
    log_info "Installing kubesec..."
    wget https://github.com/controlplaneio/kubesec/releases/latest/download/kubesec_linux_amd64.tar.gz -P /tmp
    tar -xzf /tmp/kubesec_linux_amd64.tar.gz -C /tmp
    mv /tmp/kubesec /usr/local/bin/
    chmod +x /usr/local/bin/kubesec
    rm /tmp/kubesec_linux_amd64.tar.gz
    log_success "kubesec installed"
}

# Install git-secrets
install_git_secrets() {
    if command -v git-secrets &> /dev/null; then
        log_warning "git-secrets already installed"
        return 0
    fi
    
    log_info "Installing git-secrets..."
    git clone https://github.com/awslabs/git-secrets.git /tmp/git-secrets
    cd /tmp/git-secrets
    make install
    cd -
    rm -rf /tmp/git-secrets
    log_success "git-secrets installed"
}

# Install age
install_age() {
    if command -v age &> /dev/null; then
        log_warning "age already installed"
        return 0
    fi
    
    log_info "Installing age..."
    local AGE_VERSION=$(curl -s https://api.github.com/repos/FiloSottile/age/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/age-${AGE_VERSION}-linux-amd64.tar.gz" -C /tmp
    mv /tmp/age/age /usr/local/bin/
    mv /tmp/age/age-keygen /usr/local/bin/
    rm -rf "/tmp/age-${AGE_VERSION}-linux-amd64.tar.gz" /tmp/age
    log_success "age installed"
}

# Install SOPS
install_sops() {
    if command -v sops &> /dev/null; then
        log_warning "sops already installed"
        return 0
    fi
    
    log_info "Installing SOPS..."
    local SOPS_VERSION=$(curl -s https://api.github.com/repos/mozilla/sops/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64" -O /usr/local/bin/sops
    chmod +x /usr/local/bin/sops
    log_success "sops installed"
}

# Install Vault
install_vault() {
    if command -v vault &> /dev/null; then
        log_warning "vault already installed"
        return 0
    fi
    
    log_info "Installing Vault..."
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update
    apt install -y vault
    log_success "vault installed"
}

# Install Cosign
install_cosign() {
    if command -v cosign &> /dev/null; then
        log_warning "cosign already installed"
        return 0
    fi
    
    log_info "Installing Cosign..."
    local COSIGN_VERSION=$(curl -s https://api.github.com/repos/sigstore/cosign/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64" -O /usr/local/bin/cosign
    chmod +x /usr/local/bin/cosign
    log_success "cosign installed"
}

# Main installation
main() {
    install_trivy
    install_hadolint
    install_kube_bench
    install_kubesec
    install_git_secrets
    install_age
    install_sops
    install_vault
    install_cosign
    
    log_success "Security & Compliance tools installation complete!"
}

main
