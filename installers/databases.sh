#!/bin/bash

##############################################
# Database Clients Installer
##############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "🗄️  Installing Database Clients"

# Install MySQL client
install_mysql() {
    if command -v mysql &> /dev/null; then
        log_warning "mysql client already installed"
        return 0
    fi
    
    log_info "Installing MySQL client..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y mysql-client
    else
        yum install -y mysql
    fi
    log_success "mysql client installed"
}

# Install PostgreSQL client
install_psql() {
    if command -v psql &> /dev/null; then
        log_warning "psql already installed"
        return 0
    fi
    
    log_info "Installing PostgreSQL client..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y postgresql-client
    else
        yum install -y postgresql
    fi
    log_success "psql installed"
}

# Install Redis CLI
install_redis_cli() {
    if command -v redis-cli &> /dev/null; then
        log_warning "redis-cli already installed"
        return 0
    fi
    
    log_info "Installing Redis CLI..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y redis-tools
    else
        yum install -y redis
    fi
    log_success "redis-cli installed"
}

# Install MongoDB Shell
install_mongosh() {
    if command -v mongosh &> /dev/null; then
        log_warning "mongosh already installed"
        return 0
    fi
    
    log_info "Installing MongoDB Shell..."
    wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    apt update
    apt install -y mongodb-mongosh
    log_success "mongosh installed"
}

# Main installation
main() {
    install_mysql
    install_psql
    install_redis_cli
    install_mongosh
    
    log_success "Database clients installation complete!"
}

main
