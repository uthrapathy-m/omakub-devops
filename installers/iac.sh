#!/bin/bash

##############################################
# Infrastructure as Code Tools Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🏗️  Installing Infrastructure as Code Tools"

# Install Terraform
install_terraform() {
    if command -v terraform &> /dev/null; then
        log_warning "terraform already installed"
        return 0
    fi
    
    log_info "Installing Terraform..."
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update && apt install -y terraform
    log_success "terraform installed"
}

# Install Terragrunt
install_terragrunt() {
    if command -v terragrunt &> /dev/null; then
        log_warning "terragrunt already installed"
        return 0
    fi
    
    log_info "Installing Terragrunt..."
    local TG_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget "https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64" -O /usr/local/bin/terragrunt
    chmod +x /usr/local/bin/terragrunt
    log_success "terragrunt installed"
}

# Install Ansible
install_ansible() {
    if command -v ansible &> /dev/null; then
        log_warning "ansible already installed"
        return 0
    fi
    
    log_info "Installing Ansible..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt update
        apt install -y software-properties-common
        add-apt-repository --yes --update ppa:ansible/ansible
        apt install -y ansible
    else
        yum install -y ansible
    fi
    log_success "ansible installed"
}

# Install Packer
install_packer() {
    if command -v packer &> /dev/null; then
        log_warning "packer already installed"
        return 0
    fi
    
    log_info "Installing Packer..."
    local PACKER_VERSION=$(curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
    wget "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" -P /tmp
    unzip "/tmp/packer_${PACKER_VERSION}_linux_amd64.zip" -d /tmp
    mv /tmp/packer /usr/local/bin/
    chmod +x /usr/local/bin/packer
    rm "/tmp/packer_${PACKER_VERSION}_linux_amd64.zip"
    log_success "packer installed"
}

# Install tfsec
install_tfsec() {
    if command -v tfsec &> /dev/null; then
        log_warning "tfsec already installed"
        return 0
    fi
    
    log_info "Installing tfsec..."
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
    log_success "tfsec installed"
}

# Install Checkov
install_checkov() {
    if command -v checkov &> /dev/null; then
        log_warning "checkov already installed"
        return 0
    fi
    
    log_info "Installing Checkov..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y python3-pip
    else
        yum install -y python3-pip
    fi
    pip3 install checkov
    log_success "checkov installed"
}

# Main installation
main() {
    install_terraform
    install_terragrunt
    install_ansible
    install_packer
    install_tfsec
    install_checkov
    
    log_success "Infrastructure as Code tools installation complete!"
}

main
