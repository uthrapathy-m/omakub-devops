#!/bin/bash

#############################################
# DevOps Workspace - Shell Configuration Setup
# Enhanced bash prompt with K8s context, git status, and more
#############################################

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

# Initialize
init_common

log_header "⚙️  Setting Up Shell Configuration"

# Backup existing bashrc
backup_bashrc() {
    if [ -f "$USER_HOME/.bashrc" ]; then
        log_info "Backing up existing .bashrc..."
        cp "$USER_HOME/.bashrc" "$USER_HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
        log_success "Backup created"
    fi
}

# Install enhanced prompt
setup_prompt() {
    log_info "Setting up enhanced prompt..."
    
    cat >> "$USER_HOME/.bashrc" << 'PROMPT_EOF'

# ============================================
# DEVOPS WORKSPACE - ENHANCED PROMPT
# ============================================

# Color definitions
COLOR_RESET='\[\033[0m\]'
COLOR_USER='\[\033[01;36m\]'      # Cyan
COLOR_HOST='\[\033[01;36m\]'      # Cyan
COLOR_PATH='\[\033[01;34m\]'      # Blue
COLOR_GIT_CLEAN='\[\033[0;32m\]'  # Green
COLOR_GIT_DIRTY='\[\033[0;33m\]'  # Yellow
COLOR_GIT_UNCOMMIT='\[\033[0;31m\]' # Red
COLOR_K8S='\[\033[0;35m\]'        # Magenta
COLOR_CLOUD='\[\033[0;36m\]'      # Cyan

# Git branch and status
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

git_status_color() {
    local git_status="$(git status 2> /dev/null)"
    
    if [[ -z $git_status ]]; then
        echo ""
        return
    fi
    
    if [[ $git_status =~ "nothing to commit" ]]; then
        echo -e "$COLOR_GIT_CLEAN"
    elif [[ $git_status =~ "Changes to be committed" ]]; then
        echo -e "$COLOR_GIT_UNCOMMIT"
    else
        echo -e "$COLOR_GIT_DIRTY"
    fi
}

# Kubernetes context
k8s_context() {
    if command -v kubectl &> /dev/null; then
        local ctx=$(kubectl config current-context 2>/dev/null)
        if [ -n "$ctx" ]; then
            local ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
            if [ -n "$ns" ]; then
                echo " ${COLOR_K8S}☸ $ctx:$ns${COLOR_RESET}"
            else
                echo " ${COLOR_K8S}☸ $ctx${COLOR_RESET}"
            fi
        fi
    fi
}

# AWS Profile
aws_profile() {
    if [ -n "$AWS_PROFILE" ]; then
        echo " ${COLOR_CLOUD}☁ $AWS_PROFILE${COLOR_RESET}"
    fi
}

# Build prompt
build_prompt() {
    local user_host="${COLOR_USER}\u${COLOR_RESET}@${COLOR_HOST}\h${COLOR_RESET}"
    local path="${COLOR_PATH}\w${COLOR_RESET}"
    local git_info="\$(git_status_color)\$(parse_git_branch)${COLOR_RESET}"
    local k8s_info="\$(k8s_context)"
    local cloud_info="\$(aws_profile)"
    
    # Export PS1
    export PS1="${user_host}:${path}${git_info}${k8s_info}${cloud_info}\$ "
}

# Initialize prompt
build_prompt

PROMPT_EOF
    
    log_success "Enhanced prompt configured"
}

# Setup starship (if installed)
setup_starship() {
    if command -v starship &> /dev/null; then
        log_info "Configuring starship prompt..."
        
        mkdir -p "$USER_HOME/.config"
        cat > "$USER_HOME/.config/starship.toml" << 'STARSHIP_EOF'
# DevOps Workspace - Starship Configuration

format = """
[╭─](bold green)$username[@](bold white)$hostname $directory$git_branch$git_status$kubernetes$aws$docker_context
[╰─](bold green)$character"""

[username]
style_user = "bold cyan"
style_root = "bold red"
format = "[$user]($style)"
show_always = true

[hostname]
ssh_only = false
format = "[$hostname](bold cyan)"

[directory]
style = "bold blue"
truncation_length = 3
truncate_to_repo = true
format = " [$path]($style)[$read_only]($read_only_style) "

[git_branch]
symbol = " "
format = "[$symbol$branch]($style) "
style = "bold purple"

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "bold red"
conflicted = "🏳"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
untracked = "?"
stashed = "$"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"

[kubernetes]
format = '[$symbol$context( \($namespace\))]($style) '
symbol = "☸ "
style = "bold magenta"
disabled = false
detect_files = ['k8s']
detect_folders = ['k8s']

[aws]
format = '[$symbol($profile )(\($region\) )]($style)'
symbol = "☁️  "
style = "bold yellow"

[docker_context]
format = '[$symbol$context]($style) '
symbol = "🐳 "
style = "bold blue"
only_with_files = true

[terraform]
format = '[$symbol$workspace]($style) '
symbol = "💠 "
style = "bold purple"

[python]
symbol = "🐍 "
style = "bold green"
format = '[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)'

[nodejs]
symbol = "⬢ "
style = "bold green"
format = '[$symbol($version )]($style)'

[golang]
symbol = "🐹 "
style = "bold cyan"
format = '[$symbol($version )]($style)'

[rust]
symbol = "🦀 "
style = "bold red"
format = '[$symbol($version )]($style)'

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

STARSHIP_EOF

        # Add starship init to bashrc if not present
        if ! grep -q "starship init bash" "$USER_HOME/.bashrc"; then
            echo '' >> "$USER_HOME/.bashrc"
            echo '# Starship prompt' >> "$USER_HOME/.bashrc"
            echo 'eval "$(starship init bash)"' >> "$USER_HOME/.bashrc"
        fi
        
        chown -R $ACTUAL_USER:$ACTUAL_USER "$USER_HOME/.config"
        log_success "Starship configured with DevOps context"
    fi
}

# Source aliases
setup_aliases() {
    log_info "Setting up aliases..."
    
    # Copy aliases file
    cp "$(dirname "$0")/aliases.sh" "$USER_HOME/.bash_aliases"
    chown $ACTUAL_USER:$ACTUAL_USER "$USER_HOME/.bash_aliases"
    
    # Source aliases in bashrc
    if ! grep -q ".bash_aliases" "$USER_HOME/.bashrc"; then
        cat >> "$USER_HOME/.bashrc" << 'ALIAS_EOF'

# Load DevOps aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

ALIAS_EOF
    fi
    
    log_success "Aliases configured"
}

# Setup fzf
setup_fzf() {
    if [ -d "$USER_HOME/.fzf" ]; then
        log_info "Configuring fzf..."
        
        cat >> "$USER_HOME/.bashrc" << 'FZF_EOF'

# FZF configuration
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Use bat for preview if available
if command -v bat &> /dev/null; then
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

FZF_EOF
        log_success "fzf configured"
    fi
}

# Setup zoxide
setup_zoxide() {
    if command -v zoxide &> /dev/null; then
        log_info "Configuring zoxide..."
        
        if ! grep -q "zoxide init" "$USER_HOME/.bashrc"; then
            cat >> "$USER_HOME/.bashrc" << 'ZOXIDE_EOF'

# Zoxide initialization
eval "$(zoxide init bash)"

ZOXIDE_EOF
        fi
        
        log_success "zoxide configured"
    fi
}

# Setup completions
setup_completions() {
    log_info "Setting up command completions..."
    
    cat >> "$USER_HOME/.bashrc" << 'COMPLETION_EOF'

# ============================================
# COMMAND COMPLETIONS
# ============================================

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# helm completion
if command -v helm &> /dev/null; then
    source <(helm completion bash)
fi

# terraform completion
if command -v terraform &> /dev/null; then
    complete -C $(which terraform) terraform
    complete -C $(which terraform) tf
fi

# docker completion
if [ -f /usr/share/bash-completion/completions/docker ]; then
    source /usr/share/bash-completion/completions/docker
fi

# AWS CLI completion
if command -v aws_completer &> /dev/null; then
    complete -C aws_completer aws
fi

# gh completion
if command -v gh &> /dev/null; then
    eval "$(gh completion -s bash)"
fi

COMPLETION_EOF
    
    log_success "Completions configured"
}

# Setup environment variables
setup_environment() {
    log_info "Setting up environment variables..."
    
    cat >> "$USER_HOME/.bashrc" << 'ENV_EOF'

# ============================================
# DEVOPS ENVIRONMENT VARIABLES
# ============================================

# Editor
export EDITOR=vim
export VISUAL=vim

# History
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%F %T "

# Better directory navigation
shopt -s autocd        # Auto cd when entering just a directory name
shopt -s cdspell       # Autocorrect typos in path names
shopt -s dirspell
shopt -s cmdhist       # Save multi-line commands in one history entry
shopt -s histappend    # Append to history, don't overwrite

# Colors for ls
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;46:cd=1;33;43'

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Go path (if Go is installed)
if command -v go &> /dev/null; then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
fi

# Krew path (kubectl plugin manager)
if [ -d "$HOME/.krew" ]; then
    export PATH="$PATH:$HOME/.krew/bin"
fi

# Local bin path
export PATH="$HOME/.local/bin:$PATH"

ENV_EOF
    
    log_success "Environment variables configured"
}

# Create helper scripts
create_helper_scripts() {
    log_info "Creating helper scripts..."
    
    # installed-tools script
    cat > /usr/local/bin/installed-tools << 'TOOLS_EOF'
#!/bin/bash

echo "📦 Installed DevOps Tools"
echo "=========================="
echo ""

check_tool() {
    if command -v "$1" &> /dev/null; then
        local version=$($1 $2 2>&1 | head -1)
        echo "✅ $1: $version"
    fi
}

echo "Container & Orchestration:"
check_tool docker "--version"
check_tool docker-compose "--version"
check_tool kubectl "version --client --short"
check_tool helm "version --short"
check_tool k9s "version --short"
check_tool minikube "version --short"

echo ""
echo "Cloud Providers:"
check_tool aws "--version"
check_tool az "version"
check_tool gcloud "version"

echo ""
echo "Infrastructure as Code:"
check_tool terraform "version"
check_tool ansible "--version"

echo ""
echo "Modern CLI Tools:"
check_tool fzf "--version"
check_tool bat "--version"
check_tool eza "--version"
check_tool rg "--version"
check_tool fd "--version"
check_tool zoxide "--version"

echo ""
echo "Security Tools:"
check_tool trivy "version"
check_tool hadolint "--version"
check_tool tfsec "version"

TOOLS_EOF
    
    chmod +x /usr/local/bin/installed-tools
    log_success "Helper scripts created"
}

# Main setup
main() {
    backup_bashrc
    setup_prompt
    setup_starship
    setup_aliases
    setup_fzf
    setup_zoxide
    setup_completions
    setup_environment
    create_helper_scripts
    
    # Set proper ownership
    chown -R $ACTUAL_USER:$ACTUAL_USER "$USER_HOME/.bashrc" "$USER_HOME/.bash_aliases" 2>/dev/null
    
    log_success "Shell configuration complete!"
    echo ""
    echo -e "${YELLOW}${BOLD}To apply changes, run:${NC}"
    echo -e "${CYAN}source ~/.bashrc${NC}"
    echo ""
    echo -e "${GREEN}${BOLD}New features:${NC}"
    echo "• Enhanced prompt with Git and K8s context"
    echo "• Comprehensive DevOps aliases"
    echo "• Auto-completion for kubectl, helm, terraform, docker"
    echo "• fzf fuzzy finder integration"
    echo "• Starship prompt (if installed)"
    echo ""
}

main
