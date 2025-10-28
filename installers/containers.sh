#!/bin/bash

##############################################
# Container & Orchestration Tools Installer
##############################################

source "$(dirname "$0")/../install.sh" 2>/dev/null || true

log_header "📦 Installing Container & Orchestration Tools"

# Install Docker
install_docker() {
    if command -v docker &> /dev/null; then
        log_warning "Docker already installed: $(docker --version)"
        return 0
    fi
    
    log_info "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    usermod -aG docker $ACTUAL_USER
    systemctl enable docker
    systemctl start docker
    log_success "Docker installed"
}

# Install Docker Compose
install_docker_compose() {
    if command -v docker-compose &> /dev/null; then
        log_warning "Docker Compose already installed"
        return 0
    fi
    
    log_info "Installing Docker Compose..."
    local version="v2.24.5"
    curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    log_success "Docker Compose installed"
}

# Install kubectl
install_kubectl() {
    if command -v kubectl &> /dev/null; then
        log_warning "kubectl already installed"
        return 0
    fi
    
    log_info "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    log_success "kubectl installed"
}

# Install Helm
install_helm() {
    if command -v helm &> /dev/null; then
        log_warning "Helm already installed"
        return 0
    fi
    
    log_info "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    log_success "Helm installed"
}

# Install k9s
install_k9s() {
    if command -v k9s &> /dev/null; then
        log_warning "k9s already installed"
        return 0
    fi
    
    log_info "Installing k9s..."
    local K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/k9s_Linux_amd64.tar.gz" -C /tmp
    mv /tmp/k9s /usr/local/bin/
    chmod +x /usr/local/bin/k9s
    rm /tmp/k9s_Linux_amd64.tar.gz
    log_success "k9s installed"
}

# Install kubectx and kubens
install_kubectx() {
    if command -v kubectx &> /dev/null; then
        log_warning "kubectx already installed"
        return 0
    fi
    
    log_info "Installing kubectx and kubens..."
    git clone https://github.com/ahmetb/kubectx /opt/kubectx
    ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
    ln -sf /opt/kubectx/kubens /usr/local/bin/kubens
    log_success "kubectx and kubens installed"
}

# Install krew
install_krew() {
    if [ -d "$USER_HOME/.krew" ]; then
        log_warning "krew already installed"
        return 0
    fi
    
    log_info "Installing krew..."
    cd /tmp
    OS="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    KREW="krew-${OS}_${ARCH}"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
    tar zxvf "${KREW}.tar.gz"
    ./"${KREW}" install krew
    rm "${KREW}.tar.gz" "${KREW}"
    log_success "krew installed"
}

# Install stern
install_stern() {
    if command -v stern &> /dev/null; then
        log_warning "stern already installed"
        return 0
    fi
    
    log_info "Installing stern..."
    local STERN_VERSION=$(curl -s https://api.github.com/repos/stern/stern/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/stern/stern/releases/download/${STERN_VERSION}/stern_${STERN_VERSION#v}_linux_amd64.tar.gz" -P /tmp
    tar -xzf "/tmp/stern_${STERN_VERSION#v}_linux_amd64.tar.gz" -C /tmp
    mv /tmp/stern /usr/local/bin/
    chmod +x /usr/local/bin/stern
    rm /tmp/stern_*.tar.gz
    log_success "stern installed"
}

# Install kustomize
install_kustomize() {
    if command -v kustomize &> /dev/null; then
        log_warning "kustomize already installed"
        return 0
    fi
    
    log_info "Installing kustomize..."
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
    mv kustomize /usr/local/bin/
    log_success "kustomize installed"
}

# Install kubeval
install_kubeval() {
    if command -v kubeval &> /dev/null; then
        log_warning "kubeval already installed"
        return 0
    fi
    
    log_info "Installing kubeval..."
    wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz -P /tmp
    tar xf /tmp/kubeval-linux-amd64.tar.gz -C /tmp
    mv /tmp/kubeval /usr/local/bin
    chmod +x /usr/local/bin/kubeval
    rm /tmp/kubeval-linux-amd64.tar.gz
    log_success "kubeval installed"
}

# Install popeye
install_popeye() {
    if command -v popeye &> /dev/null; then
        log_warning "popeye already installed"
        return 0
    fi
    
    log_info "Installing popeye..."
    local POPEYE_VERSION=$(curl -s https://api.github.com/repos/derailed/popeye/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/derailed/popeye/releases/download/${POPEYE_VERSION}/popeye_Linux_x86_64.tar.gz" -P /tmp
    tar -xzf "/tmp/popeye_Linux_x86_64.tar.gz" -C /tmp
    mv /tmp/popeye /usr/local/bin/
    chmod +x /usr/local/bin/popeye
    rm /tmp/popeye_Linux_x86_64.tar.gz
    log_success "popeye installed"
}

# Install lazydocker
install_lazydocker() {
    if command -v lazydocker &> /dev/null; then
        log_warning "lazydocker already installed"
        return 0
    fi
    
    log_info "Installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    log_success "lazydocker installed"
}

# Install minikube
install_minikube() {
    if command -v minikube &> /dev/null; then
        log_warning "minikube already installed"
        return 0
    fi
    
    log_info "Installing minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    log_success "minikube installed"
}

# Main installation
main() {
    install_docker
    install_docker_compose
    install_kubectl
    install_helm
    install_k9s
    install_kubectx
    install_krew
    install_stern
    install_kustomize
    install_kubeval
    install_popeye
    install_lazydocker
    install_minikube
    
    log_success "Container & Orchestration tools installation complete!"
}

main
