#!/bin/bash

##############################################
# Modern CLI Productivity Tools Installer
##############################################

source "$(dirname "$0")/../install.sh" 2>/dev/null || true

log_header "💻 Installing Modern CLI Productivity Tools"

# Install starship prompt
install_starship() {
    if command -v starship &> /dev/null; then
        log_warning "starship already installed"
        return 0
    fi
    
    log_info "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    log_success "starship installed"
}

# Install fzf
install_fzf() {
    if command -v fzf &> /dev/null; then
        log_warning "fzf already installed"
        return 0
    fi
    
    log_info "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git $USER_HOME/.fzf
    chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.fzf
    sudo -u $ACTUAL_USER bash -c "$USER_HOME/.fzf/install --all"
    log_success "fzf installed"
}

# Install bat
install_bat() {
    if command -v bat &> /dev/null || command -v batcat &> /dev/null; then
        log_warning "bat already installed"
        return 0
    fi
    
    log_info "Installing bat..."
    local BAT_VERSION="0.24.0"
    wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz" -P /tmp
    tar -xzf "/tmp/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz" -C /tmp
    mv "/tmp/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu/bat" /usr/local/bin/
    rm -rf "/tmp/bat-v${BAT_VERSION}"*
    log_success "bat installed"
}

# Install eza (modern ls)
install_eza() {
    if command -v eza &> /dev/null; then
        log_warning "eza already installed"
        return 0
    fi
    
    log_info "Installing eza..."
    wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -P /tmp
    tar -xzf /tmp/eza_x86_64-unknown-linux-gnu.tar.gz -C /tmp
    mv /tmp/eza /usr/local/bin/
    rm /tmp/eza_x86_64-unknown-linux-gnu.tar.gz
    log_success "eza installed"
}

# Install zoxide
install_zoxide() {
    if command -v zoxide &> /dev/null; then
        log_warning "zoxide already installed"
        return 0
    fi
    
    log_info "Installing zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    log_success "zoxide installed"
}

# Install ripgrep
install_ripgrep() {
    if command -v rg &> /dev/null; then
        log_warning "ripgrep already installed"
        return 0
    fi
    
    log_info "Installing ripgrep..."
    local RG_VERSION="14.1.0"
    wget "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz" -P /tmp
    tar -xzf "/tmp/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz" -C /tmp
    mv "/tmp/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" /usr/local/bin/
    rm -rf "/tmp/ripgrep-${RG_VERSION}"*
    log_success "ripgrep installed"
}

# Install fd
install_fd() {
    if command -v fd &> /dev/null; then
        log_warning "fd already installed"
        return 0
    fi
    
    log_info "Installing fd..."
    local FD_VERSION="9.0.0"
    wget "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" -P /tmp
    tar -xzf "/tmp/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" -C /tmp
    mv "/tmp/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu/fd" /usr/local/bin/
    rm -rf "/tmp/fd-v${FD_VERSION}"*
    log_success "fd installed"
}

# Install jq and yq
install_jq_yq() {
    if ! command -v jq &> /dev/null; then
        log_info "Installing jq..."
        if [ "$PKG_MANAGER" = "apt" ]; then
            apt install -y jq
        else
            yum install -y jq
        fi
    fi
    
    if ! command -v yq &> /dev/null; then
        log_info "Installing yq..."
        local YQ_VERSION="4.40.5"
        wget "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -O /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
    fi
    
    log_success "jq and yq installed"
}

# Install tldr
install_tldr() {
    if command -v tldr &> /dev/null; then
        log_warning "tldr already installed"
        return 0
    fi
    
    log_info "Installing tldr..."
    local TLDR_VERSION="1.6.1"
    wget "https://github.com/dbrgn/tealdeer/releases/download/v${TLDR_VERSION}/tealdeer-linux-x86_64-musl" -O /usr/local/bin/tldr
    chmod +x /usr/local/bin/tldr
    sudo -u $ACTUAL_USER tldr --update
    log_success "tldr installed"
}

# Install ncdu
install_ncdu() {
    if command -v ncdu &> /dev/null; then
        log_warning "ncdu already installed"
        return 0
    fi
    
    log_info "Installing ncdu..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y ncdu
    else
        yum install -y ncdu
    fi
    log_success "ncdu installed"
}

# Install duf
install_duf() {
    if command -v duf &> /dev/null; then
        log_warning "duf already installed"
        return 0
    fi
    
    log_info "Installing duf..."
    local DUF_VERSION="0.8.1"
    wget "https://github.com/muesli/duf/releases/download/v${DUF_VERSION}/duf_${DUF_VERSION}_linux_x86_64.tar.gz" -P /tmp
    tar -xzf "/tmp/duf_${DUF_VERSION}_linux_x86_64.tar.gz" -C /tmp
    mv /tmp/duf /usr/local/bin/
    rm "/tmp/duf_${DUF_VERSION}_linux_x86_64.tar.gz"
    log_success "duf installed"
}

# Install delta (git diff)
install_delta() {
    if command -v delta &> /dev/null; then
        log_warning "delta already installed"
        return 0
    fi
    
    log_info "Installing delta..."
    local DELTA_VERSION="0.17.0"
    wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz" -P /tmp
    tar -xzf "/tmp/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz" -C /tmp
    mv "/tmp/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl/delta" /usr/local/bin/
    rm -rf "/tmp/delta-${DELTA_VERSION}"*
    
    # Configure git to use delta
    sudo -u $ACTUAL_USER git config --global core.pager delta
    sudo -u $ACTUAL_USER git config --global interactive.diffFilter "delta --color-only"
    sudo -u $ACTUAL_USER git config --global delta.navigate true
    
    log_success "delta installed and configured"
}

# Install lazygit
install_lazygit() {
    if command -v lazygit &> /dev/null; then
        log_warning "lazygit already installed"
        return 0
    fi
    
    log_info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp
    install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
    log_success "lazygit installed"
}

# Install glow (markdown renderer)
install_glow() {
    if command -v glow &> /dev/null; then
        log_warning "glow already installed"
        return 0
    fi
    
    log_info "Installing glow..."
    local GLOW_VERSION="1.5.1"
    wget "https://github.com/charmbracelet/glow/releases/download/v${GLOW_VERSION}/glow_${GLOW_VERSION}_linux_x86_64.tar.gz" -P /tmp
    tar -xzf "/tmp/glow_${GLOW_VERSION}_linux_x86_64.tar.gz" -C /tmp
    mv /tmp/glow /usr/local/bin/
    rm "/tmp/glow_${GLOW_VERSION}_linux_x86_64.tar.gz"
    log_success "glow installed"
}

# Install btop
install_btop() {
    if command -v btop &> /dev/null; then
        log_warning "btop already installed"
        return 0
    fi
    
    log_info "Installing btop..."
    local BTOP_VERSION="1.3.2"
    wget "https://github.com/aristocratos/btop/releases/download/v${BTOP_VERSION}/btop-x86_64-linux-musl.tbz" -P /tmp
    tar -xjf "/tmp/btop-x86_64-linux-musl.tbz" -C /tmp
    cd /tmp/btop
    make install
    cd -
    rm -rf /tmp/btop /tmp/btop-x86_64-linux-musl.tbz
    log_success "btop installed"
}

# Install htop
install_htop() {
    if command -v htop &> /dev/null; then
        log_warning "htop already installed"
        return 0
    fi
    
    log_info "Installing htop..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y htop
    else
        yum install -y htop
    fi
    log_success "htop installed"
}

# Install tmux
install_tmux() {
    if command -v tmux &> /dev/null; then
        log_warning "tmux already installed"
        return 0
    fi
    
    log_info "Installing tmux..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y tmux
    else
        yum install -y tmux
    fi
    log_success "tmux installed"
}

# Main installation
main() {
    install_starship
    install_fzf
    install_bat
    install_eza
    install_zoxide
    install_ripgrep
    install_fd
    install_jq_yq
    install_tldr
    install_ncdu
    install_duf
    install_delta
    install_lazygit
    install_glow
    install_btop
    install_htop
    install_tmux
    
    log_success "Modern CLI Productivity tools installation complete!"
}

main
