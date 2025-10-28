#!/bin/bash

#############################################
# DevOps Workspace - Installation Verification
# Checks all installed tools and their versions
#############################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Counters
TOTAL=0
INSTALLED=0
MISSING=0

show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║        ✅ DevOps Workspace - Installation Verification            ║
║                                                                    ║
║           Checking all tools and their versions                   ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
}

log_header() {
    echo -e "\n${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${BOLD}$1${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

check_tool() {
    local tool=$1
    local version_cmd=$2
    TOTAL=$((TOTAL + 1))
    
    if command -v "$tool" &> /dev/null; then
        local version=$($version_cmd 2>&1 | head -1)
        echo -e "${GREEN}✓${NC} $tool: ${BLUE}$version${NC}"
        INSTALLED=$((INSTALLED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $tool: Not installed"
        MISSING=$((MISSING + 1))
        return 1
    fi
}

# Container & Orchestration Tools
check_containers() {
    log_header "📦 Container & Orchestration Tools"
    
    check_tool "docker" "docker --version"
    check_tool "docker-compose" "docker-compose --version"
    check_tool "kubectl" "kubectl version --client"
    check_tool "helm" "helm version --short"
    check_tool "k9s" "k9s version --short"
    check_tool "kubectx" "kubectx -h 2>&1 | head -1 | grep -o 'kubectx' || echo 'installed'"
    check_tool "kubens" "kubens -h 2>&1 | head -1 | grep -o 'kubens' || echo 'installed'"
    check_tool "stern" "stern --version"
    check_tool "kustomize" "kustomize version --short"
    check_tool "kubeval" "kubeval --version"
    check_tool "popeye" "popeye version"
    check_tool "lazydocker" "lazydocker --version"
    check_tool "minikube" "minikube version --short"
}

# Cloud Provider CLIs
check_cloud() {
    log_header "☁️  Cloud Provider CLIs"
    
    check_tool "aws" "aws --version"
    check_tool "az" "az --version"
    check_tool "gcloud" "gcloud --version"
    check_tool "eksctl" "eksctl version"
}

# Infrastructure as Code
check_iac() {
    log_header "🏗️  Infrastructure as Code Tools"
    
    check_tool "terraform" "terraform version"
    check_tool "terragrunt" "terragrunt --version"
    check_tool "ansible" "ansible --version"
    check_tool "packer" "packer version"
    check_tool "tfsec" "tfsec --version"
    check_tool "checkov" "checkov --version"
}

# Security & Compliance
check_security() {
    log_header "🔒 Security & Compliance Tools"
    
    check_tool "trivy" "trivy --version"
    check_tool "hadolint" "hadolint --version"
    check_tool "kube-bench" "kube-bench version"
    check_tool "kubesec" "kubesec version"
    check_tool "git-secrets" "git-secrets --version"
    check_tool "age" "age --version"
    check_tool "sops" "sops --version"
    check_tool "vault" "vault version"
    check_tool "cosign" "cosign version"
}

# Modern CLI Productivity
check_productivity() {
    log_header "💻 Modern CLI Productivity Tools"
    
    check_tool "starship" "starship --version"
    check_tool "fzf" "fzf --version"
    check_tool "bat" "bat --version"
    check_tool "eza" "eza --version"
    check_tool "zoxide" "zoxide --version"
    check_tool "rg" "rg --version"
    check_tool "fd" "fd --version"
    check_tool "jq" "jq --version"
    check_tool "yq" "yq --version"
    check_tool "tldr" "tldr --version"
    check_tool "ncdu" "ncdu --version"
    check_tool "duf" "duf --version"
    check_tool "delta" "delta --version"
    check_tool "lazygit" "lazygit --version"
    check_tool "glow" "glow --version"
    check_tool "btop" "btop --version"
    check_tool "htop" "htop --version"
}

# CI/CD & GitOps
check_cicd() {
    log_header "🚀 CI/CD & GitOps Tools"
    
    check_tool "gh" "gh --version"
    check_tool "glab" "glab --version"
    check_tool "act" "act --version"
    check_tool "argocd" "argocd version --short --client"
    check_tool "flux" "flux --version"
}

# Networking & Debugging
check_networking() {
    log_header "🌐 Networking & Debugging Tools"
    
    check_tool "mtr" "mtr --version"
    check_tool "nmap" "nmap --version"
    check_tool "httpie" "http --version"
    check_tool "curl" "curl --version"
    check_tool "grpcurl" "grpcurl --version"
}

# Database Clients
check_databases() {
    log_header "🗄️  Database Clients"
    
    check_tool "mysql" "mysql --version"
    check_tool "psql" "psql --version"
    check_tool "redis-cli" "redis-cli --version"
    check_tool "mongosh" "mongosh --version"
}

# Text Editors
check_editors() {
    log_header "📝 Text Editors"
    
    check_tool "nvim" "nvim --version"
    check_tool "vim" "vim --version"
    check_tool "nano" "nano --version"
}

# Development Tools
check_devtools() {
    log_header "🛠️  Development Tools"
    
    check_tool "git" "git --version"
    check_tool "make" "make --version"
    check_tool "python3" "python3 --version"
    check_tool "pip3" "pip3 --version"
    check_tool "go" "go version"
    check_tool "node" "node --version"
    check_tool "npm" "npm --version"
}

# Custom Generators
check_generators() {
    log_header "🎨 Custom DevOps Generators"
    
    check_tool "dockerfile-gen" "echo 'Custom Dockerfile Generator'"
    check_tool "sec-scan" "echo 'Security Scanner Wrapper'"
    check_tool "cluster-health" "echo 'Kubernetes Health Checker'"
}

# Shell Configuration
check_shell() {
    log_header "⚙️  Shell Configuration"
    
    echo -n "Checking ~/.bashrc... "
    if [ -f ~/.bashrc ]; then
        if grep -q "DEVOPS WORKSPACE" ~/.bashrc 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Enhanced prompt configured"
            INSTALLED=$((INSTALLED + 1))
        else
            echo -e "${YELLOW}⚠${NC} Standard bashrc (prompt not configured)"
        fi
    else
        echo -e "${RED}✗${NC} Not found"
        MISSING=$((MISSING + 1))
    fi
    TOTAL=$((TOTAL + 1))
    
    echo -n "Checking ~/.bash_aliases... "
    if [ -f ~/.bash_aliases ]; then
        local alias_count=$(grep -c "^alias" ~/.bash_aliases 2>/dev/null || echo "0")
        echo -e "${GREEN}✓${NC} Loaded ($alias_count aliases)"
        INSTALLED=$((INSTALLED + 1))
    else
        echo -e "${RED}✗${NC} Not found"
        MISSING=$((MISSING + 1))
    fi
    TOTAL=$((TOTAL + 1))
    
    echo -n "Checking starship config... "
    if [ -f ~/.config/starship.toml ]; then
        echo -e "${GREEN}✓${NC} Configured"
        INSTALLED=$((INSTALLED + 1))
    else
        echo -e "${YELLOW}⚠${NC} Not configured"
    fi
    TOTAL=$((TOTAL + 1))
}

# Terminal Enhancements
check_terminal() {
    log_header "📦 Terminal Enhancements"
    
    check_tool "tmux" "tmux -V"
    check_tool "asciinema" "asciinema --version"
}

# Show Summary
show_summary() {
    log_header "📊 Installation Summary"
    
    local percentage=$((INSTALLED * 100 / TOTAL))
    
    echo -e "${CYAN}${BOLD}Total Tools Checked:${NC} $TOTAL"
    echo -e "${GREEN}${BOLD}Installed:${NC} $INSTALLED"
    echo -e "${RED}${BOLD}Missing:${NC} $MISSING"
    echo -e "${BLUE}${BOLD}Success Rate:${NC} ${percentage}%"
    echo ""
    
    if [ $percentage -ge 80 ]; then
        echo -e "${GREEN}${BOLD}🎉 Excellent! Your DevOps workspace is well configured!${NC}"
    elif [ $percentage -ge 60 ]; then
        echo -e "${YELLOW}${BOLD}👍 Good! Most tools are installed.${NC}"
    elif [ $percentage -ge 40 ]; then
        echo -e "${YELLOW}${BOLD}⚠️  Partial installation. Consider running the installer again.${NC}"
    else
        echo -e "${RED}${BOLD}❌ Low installation rate. Please run the installer.${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}${BOLD}Quick Actions:${NC}"
    echo "• View all aliases: ${BLUE}devops-alias${NC} or ${BLUE}cat ~/.bash_aliases${NC}"
    echo "• Reload shell: ${BLUE}source ~/.bashrc${NC}"
    echo "• Test fuzzy finder: Press ${BLUE}Ctrl+R${NC}"
    echo "• Generate Dockerfile: ${BLUE}dockerfile-gen${NC}"
    echo "• Security scan: ${BLUE}sec-scan .${NC}"
    echo "• Cluster health: ${BLUE}cluster-health${NC}"
    echo ""
    
    if [ $MISSING -gt 0 ]; then
        echo -e "${YELLOW}${BOLD}To install missing tools:${NC}"
        echo "  cd omakub-devops"
        echo "  sudo ./install.sh"
        echo ""
    fi
}

# Main execution
main() {
    show_banner
    
    # Check which category to verify (or all)
    if [ $# -eq 0 ]; then
        # Check all
        check_containers
        check_cloud
        check_iac
        check_security
        check_productivity
        check_cicd
        check_networking
        check_databases
        check_editors
        check_devtools
        check_generators
        check_shell
        check_terminal
    else
        # Check specific category
        case $1 in
            containers) check_containers ;;
            cloud) check_cloud ;;
            iac) check_iac ;;
            security) check_security ;;
            productivity) check_productivity ;;
            cicd) check_cicd ;;
            networking) check_networking ;;
            databases) check_databases ;;
            editors) check_editors ;;
            devtools) check_devtools ;;
            generators) check_generators ;;
            shell) check_shell ;;
            all) main ;;
            *)
                echo "Usage: $0 [category]"
                echo "Categories: containers, cloud, iac, security, productivity, cicd,"
                echo "           networking, databases, editors, devtools, generators, shell, all"
                exit 1
                ;;
        esac
    fi
    
    show_summary
}

main "$@"
