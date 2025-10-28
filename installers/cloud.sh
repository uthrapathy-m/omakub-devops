#!/bin/bash

##############################################
# Cloud Provider CLIs Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "☁️  Installing Cloud Provider CLIs"

# Install AWS CLI v2
install_aws_cli() {
    if command -v aws &> /dev/null; then
        log_warning "AWS CLI already installed: $(aws --version)"
        return 0
    fi
    
    log_info "Installing AWS CLI v2..."
    cd /tmp
    
    if [ "$ARCH" = "x86_64" ]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    elif [ "$ARCH" = "aarch64" ]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
    else
        log_error "Unsupported architecture: $ARCH"
        return 1
    fi
    
    unzip -q awscliv2.zip
    ./aws/install --update || ./aws/install
    rm -rf awscliv2.zip aws
    
    log_success "AWS CLI v2 installed: $(aws --version)"
}

# Install Azure CLI
install_azure_cli() {
    if command -v az &> /dev/null; then
        log_warning "Azure CLI already installed: $(az version --output tsv | head -1)"
        return 0
    fi
    
    log_info "Installing Azure CLI..."
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    else
        rpm --import https://packages.microsoft.com/keys/microsoft.asc
        echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
        $INSTALL_CMD azure-cli
    fi
    
    log_success "Azure CLI installed: $(az version --output tsv | head -1)"
}

# Install Google Cloud SDK
install_gcloud() {
    if command -v gcloud &> /dev/null; then
        log_warning "Google Cloud SDK already installed: $(gcloud --version | head -1)"
        return 0
    fi
    
    log_info "Installing Google Cloud SDK..."
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
        apt update
        $INSTALL_CMD google-cloud-sdk
    else
        tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
        $INSTALL_CMD google-cloud-sdk
    fi
    
    log_success "Google Cloud SDK installed: $(gcloud --version | head -1)"
}

# Install eksctl
install_eksctl() {
    if command -v eksctl &> /dev/null; then
        log_warning "eksctl already installed: $(eksctl version)"
        return 0
    fi
    
    log_info "Installing eksctl..."
    cd /tmp
    
    if [ "$ARCH" = "x86_64" ]; then
        local arch_name="amd64"
    elif [ "$ARCH" = "aarch64" ]; then
        local arch_name="arm64"
    else
        log_error "Unsupported architecture: $ARCH"
        return 1
    fi
    
    curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_${arch_name}.tar.gz" | tar xz -C /tmp
    mv /tmp/eksctl /usr/local/bin
    chmod +x /usr/local/bin/eksctl
    
    log_success "eksctl installed: $(eksctl version)"
}

# Main installation
main() {
    install_aws_cli
    install_azure_cli
    install_gcloud
    install_eksctl
    
    log_success "Cloud Provider CLIs installation complete!"
}

main
