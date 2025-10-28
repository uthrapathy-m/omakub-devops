#!/bin/bash

#############################################
# DevOps Workspace Installer
# Inspired by Omakub - Custom DevOps Tool Setup
# Author: DevOps Team
# Description: Interactive installer for complete DevOps workspace
#############################################

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/installers"
GENERATORS_DIR="$SCRIPT_DIR/generators"
CONFIG_DIR="$SCRIPT_DIR/config"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

log_header() {
    echo -e "\n${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${BOLD}$1${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Show banner
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║            🚀 DevOps Workspace Installer 🚀                        ║
║                                                                    ║
║        Your Complete DevOps Toolkit in One Installation           ║
║                                                                    ║
║     📦 Containers | ☁️  Cloud | 🏗️  IaC | 🔒 Security             ║
║     📊 Monitoring | 🚀 CI/CD | 💻 Productivity | 🎨 Beauty        ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VERSION=$VERSION_ID
        ARCH=$(uname -m)
    else
        log_error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi

    case $OS in
        ubuntu|debian)
            PKG_MANAGER="apt"
            ;;
        centos|rhel|fedora|amzn)
            PKG_MANAGER="yum"
            ;;
        *)
            log_error "Unsupported OS: $OS"
            exit 1
            ;;
    esac

    log_success "Detected: $OS $VERSION ($ARCH) - Package Manager: $PKG_MANAGER"
}

# Check privileges
check_privileges() {
    if [ "$EUID" -ne 0 ]; then
        log_warning "This script requires sudo privileges."
        exec sudo bash "$0" "$@"
    fi
}

# Get actual user
get_actual_user() {
    if [ -n "$SUDO_USER" ]; then
        ACTUAL_USER=$SUDO_USER
        USER_HOME=$(eval echo ~$SUDO_USER)
    else
        ACTUAL_USER=$USER
        USER_HOME=$HOME
    fi
    export ACTUAL_USER USER_HOME
}

# Main menu
show_menu() {
    show_banner
    echo -e "${WHITE}${BOLD}Select Installation Type:${NC}\n"
    echo -e "${GREEN}1)${NC}  🚀 Complete DevOps Workspace (Everything)"
    echo -e "${GREEN}2)${NC}  📦 Container & Orchestration Tools"
    echo -e "${GREEN}3)${NC}  ☁️  Cloud Provider CLIs"
    echo -e "${GREEN}4)${NC}  🏗️  Infrastructure as Code Tools"
    echo -e "${GREEN}5)${NC}  🔒 Security & Compliance Tools"
    echo -e "${GREEN}6)${NC}  📊 Monitoring & Observability"
    echo -e "${GREEN}7)${NC}  🚀 CI/CD & GitOps Tools"
    echo -e "${GREEN}8)${NC}  💻 Modern CLI Productivity Tools"
    echo -e "${GREEN}9)${NC}  🎨 Shell Enhancement & Beautification"
    echo -e "${GREEN}10)${NC} 🛠️  Custom Installation (Choose specific tools)"
    echo -e "${GREEN}11)${NC} 📚 Install Custom Generators Only"
    echo -e "${GREEN}12)${NC} ⚙️  Configure Shell & Aliases Only"
    echo -e "${GREEN}13)${NC} ❌ Exit"
    echo ""
}

# Execute installation category
install_category() {
    local category=$1
    local script="${INSTALL_DIR}/${category}.sh"
    
    if [ -f "$script" ]; then
        log_info "Running installation: $category"
        bash "$script"
    else
        log_error "Installation script not found: $script"
        return 1
    fi
}

# Custom installation with checkboxes
custom_install() {
    log_header "🛠️  Custom Installation"
    
    echo -e "${YELLOW}${BOLD}Select categories to install (y/n):${NC}\n"
    
    read -p "📦 Container & Orchestration? (y/n): " install_containers
    read -p "☁️  Cloud Provider CLIs? (y/n): " install_cloud
    read -p "🏗️  Infrastructure as Code? (y/n): " install_iac
    read -p "🔒 Security & Compliance? (y/n): " install_security
    read -p "📊 Monitoring & Observability? (y/n): " install_monitoring
    read -p "🚀 CI/CD & GitOps? (y/n): " install_cicd
    read -p "💻 Modern CLI Productivity? (y/n): " install_productivity
    read -p "🌐 Networking & Debugging? (y/n): " install_networking
    read -p "🗄️  Database Clients? (y/n): " install_databases
    read -p "📝 Text Editors (Neovim)? (y/n): " install_editors
    read -p "🛠️  Development Tools? (y/n): " install_devtools
    read -p "🎨 Custom Generators? (y/n): " install_generators
    read -p "⚙️  Shell Configuration? (y/n): " install_shell
    
    echo ""
    
    [[ $install_containers == "y" ]] && install_category "containers"
    [[ $install_cloud == "y" ]] && install_category "cloud"
    [[ $install_iac == "y" ]] && install_category "iac"
    [[ $install_security == "y" ]] && install_category "security"
    [[ $install_monitoring == "y" ]] && install_category "monitoring"
    [[ $install_cicd == "y" ]] && install_category "cicd"
    [[ $install_productivity == "y" ]] && install_category "productivity"
    [[ $install_networking == "y" ]] && install_category "networking"
    [[ $install_databases == "y" ]] && install_category "databases"
    [[ $install_editors == "y" ]] && install_category "editors"
    [[ $install_devtools == "y" ]] && install_category "devtools"
    [[ $install_generators == "y" ]] && bash "$CONFIG_DIR/install-generators.sh"
    [[ $install_shell == "y" ]] && bash "$CONFIG_DIR/setup-shell.sh"
}

# Complete installation
complete_install() {
    log_header "🚀 Complete DevOps Workspace Installation"
    
    install_category "containers"
    install_category "cloud"
    install_category "iac"
    install_category "security"
    install_category "monitoring"
    install_category "cicd"
    install_category "productivity"
    install_category "networking"
    install_category "databases"
    install_category "editors"
    install_category "devtools"
    bash "$CONFIG_DIR/install-generators.sh"
    bash "$CONFIG_DIR/setup-shell.sh"
}

# Show completion summary
show_summary() {
    log_header "✨ Installation Complete! ✨"
    
    echo -e "${CYAN}${BOLD}Your DevOps Workspace is Ready!${NC}\n"
    
    echo -e "${GREEN}${BOLD}Next Steps:${NC}"
    echo "1. Reload your shell: source ~/.bashrc"
    echo "2. Test generators: dockerfile-gen, k8s-manifest-gen, compose-gen"
    echo "3. Check aliases: devops-alias"
    echo "4. View installed tools: installed-tools"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Quick Tips:${NC}"
    echo "• Use 'k' for kubectl, 'd' for docker, 'tf' for terraform"
    echo "• Press Ctrl+R for fuzzy history search (fzf)"
    echo "• Use 'lazydocker' for Docker TUI or 'k9s' for K8s"
    echo "• Run 'sec-scan' for security scanning"
    echo "• Use 'cluster-health' to check K8s cluster status"
    echo ""
    
    echo -e "${CYAN}${BOLD}Documentation:${NC}"
    echo "• README.md - Full documentation"
    echo "• config/aliases.sh - All available aliases"
    echo "• generators/ - Custom generator scripts"
    echo ""
    
    echo -e "${GREEN}${BOLD}Happy DevOps! 🚀${NC}\n"
}

# Main execution
main() {
    check_privileges
    get_actual_user
    detect_os
    
    show_menu
    read -p "Enter your choice [1-13]: " choice
    
    case $choice in
        1)
            complete_install
            ;;
        2)
            install_category "containers"
            ;;
        3)
            install_category "cloud"
            ;;
        4)
            install_category "iac"
            ;;
        5)
            install_category "security"
            ;;
        6)
            install_category "monitoring"
            ;;
        7)
            install_category "cicd"
            ;;
        8)
            install_category "productivity"
            ;;
        9)
            bash "$CONFIG_DIR/setup-shell.sh"
            ;;
        10)
            custom_install
            ;;
        11)
            bash "$CONFIG_DIR/install-generators.sh"
            ;;
        12)
            bash "$CONFIG_DIR/setup-shell.sh"
            ;;
        13)
            log_info "Exiting..."
            exit 0
            ;;
        *)
            log_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac
    
    show_summary
}

# Run main
main "$@"
