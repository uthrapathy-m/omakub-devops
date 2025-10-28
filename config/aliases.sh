#!/bin/bash

#############################################
# DevOps Workspace - Comprehensive Aliases
# Curated aliases for DevOps productivity
#############################################

# ============================================
# NAVIGATION SHORTCUTS
# ============================================
alias ..='cd ..'
alias ...='cd ../...'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# ============================================
# MODERN CLI REPLACEMENTS
# ============================================
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -l --icons --git'
    alias la='eza -la --icons --git'
    alias lt='eza --tree --icons --level=2'
    alias lta='eza --tree --icons --level=2 -a'
else
    alias ll='ls -alFh'
    alias la='ls -A'
    alias l='ls -CF'
fi

if command -v bat &> /dev/null || command -v batcat &> /dev/null; then
    alias cat='bat --paging=never'
    alias catp='bat'  # with paging
fi

if command -v btop &> /dev/null; then
    alias top='btop'
elif command -v htop &> /dev/null; then
    alias top='htop'
fi

# ============================================
# GIT SHORTCUTS (SUPER PRODUCTIVE!)
# ============================================
alias g='git'
alias gs='git status'
alias gss='git status -s'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias gc='git commit -m'
alias gca='git commit -am'
alias gcm='git commit --amend -m'
alias gp='git push'
alias gpo='git push origin'
alias gpl='git pull'
alias gplo='git pull origin'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gm='git merge'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate --all'
alias gls='git log --oneline --graph --decorate'
alias glo='git log --oneline -10'
alias glp='git log --pretty=format:"%h %s" --graph'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gcl='git clone'
alias gr='git remote -v'
alias grao='git remote add origin'
alias grso='git remote set-url origin'
alias gt='git tag'
alias gta='git tag -a'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gcp='git cherry-pick'

# Git commit with prefix
gcf() { git commit -m "feat: $*"; }
gcfix() { git commit -m "fix: $*"; }
gcdocs() { git commit -m "docs: $*"; }
gcstyle() { git commit -m "style: $*"; }
gcrefactor() { git commit -m "refactor: $*"; }
gctest() { git commit -m "test: $*"; }
gcchore() { git commit -m "chore: $*"; }

# Quick commit and push
gcp-all() {
    git add .
    git commit -m "$*"
    git push
}

# ============================================
# DOCKER SHORTCUTS
# ============================================
alias d='docker'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias di='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedSince}}"'
alias drm='docker rm'
alias drmi='docker rmi'
alias drma='docker rm $(docker ps -aq)'
alias drmia='docker rmi $(docker images -q)'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dlogs='docker logs'
alias dinspect='docker inspect'
alias dstop='docker stop'
alias dstopa='docker stop $(docker ps -q)'
alias dstart='docker start'
alias drestart='docker restart'
alias dkill='docker kill'
alias dclean='docker system prune -af'
alias dcleanv='docker system prune -af --volumes'
alias dstats='docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"'
alias dnet='docker network ls'
alias dvol='docker volume ls'

# Docker Compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f'
alias dcr='docker-compose restart'
alias dcps='docker-compose ps'
alias dcb='docker-compose build'
alias dcbn='docker-compose build --no-cache'
alias dce='docker-compose exec'

# Docker shortcuts
alias dsh='docker run -it --rm alpine sh'
alias dbash='docker run -it --rm ubuntu bash'

# ============================================
# KUBERNETES SHORTCUTS
# ============================================
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgpw='kubectl get pods -w'
alias kgs='kubectl get services'
alias kgsa='kubectl get services -A'
alias kgd='kubectl get deployments'
alias kgda='kubectl get deployments -A'
alias kgn='kubectl get nodes'
alias kgns='kubectl get namespaces'
alias kga='kubectl get all'
alias kgaa='kubectl get all -A'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias ke='kubectl edit'
alias kex='kubectl exec -it'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ka='kubectl apply -f'
alias kdel='kubectl delete -f'
alias kc='kubectl create'
alias kr='kubectl rollout'
alias krs='kubectl rollout status'
alias krr='kubectl rollout restart'
alias kru='kubectl rollout undo'
alias kpf='kubectl port-forward'
alias kctx='kubectx'
alias kns='kubens'

# Kubernetes shortcuts
alias k8s='kubectl'
alias kwatch='watch kubectl get pods'
alias ktail='stern'
alias klogs='stern'

# ============================================
# TERRAFORM SHORTCUTS
# ============================================
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tff='terraform fmt'
alias tfv='terraform validate'
alias tfs='terraform show'
alias tfo='terraform output'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tg='terragrunt'
alias tgp='terragrunt plan'
alias tga='terragrunt apply'
alias tgaa='terragrunt apply -auto-approve'
alias tgd='terragrunt destroy'

# ============================================
# HELM SHORTCUTS
# ============================================
alias h='helm'
alias hi='helm install'
alias hu='helm upgrade'
alias hd='helm delete'
alias hl='helm list'
alias hla='helm list -A'
alias hs='helm search'
alias hsr='helm search repo'
alias hsh='helm show'
alias hsc='helm show chart'
alias hsv='helm show values'
alias hr='helm repo'
alias hra='helm repo add'
alias hru='helm repo update'
alias hrl='helm repo list'
alias ht='helm template'
alias hg='helm get'
alias hgv='helm get values'
alias hh='helm history'

# ============================================
# AWS CLI SHORTCUTS
# ============================================
alias a='aws'
alias ec2='aws ec2'
alias s3='aws s3'
alias s3ls='aws s3 ls'
alias s3cp='aws s3 cp'
alias eks='aws eks'
alias ecr='aws ecr'
alias iam='aws iam'
alias cfn='aws cloudformation'
alias lambda='aws lambda'
alias logs='aws logs'
alias rds='aws rds'
alias route53='aws route53'

# ============================================
# SYSTEM SHORTCUTS
# ============================================
alias h='history'
alias c='clear'
alias q='exit'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %T"'
alias myip='curl -s ifconfig.me'
alias localip='hostname -I | awk "{print \$1}"'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias disk='df -h'
alias usage='du -h --max-depth=1 | sort -hr'

# Reload shell
alias reload='source ~/.bashrc'
alias rebash='source ~/.bashrc'

# Update system
if command -v apt &> /dev/null; then
    alias update='sudo apt update && sudo apt upgrade -y'
    alias install='sudo apt install'
elif command -v yum &> /dev/null; then
    alias update='sudo yum update -y'
    alias install='sudo yum install'
fi

# ============================================
# PRODUCTIVITY SHORTCUTS
# ============================================
alias weather='curl wttr.in'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias cheat='curl cht.sh'
alias myip='curl ifconfig.me'
alias publicip='curl ifconfig.me'

# Quick edit
alias bashrc='${EDITOR:-vim} ~/.bashrc'
alias vimrc='${EDITOR:-vim} ~/.vimrc'
alias zshrc='${EDITOR:-vim} ~/.zshrc'

# ============================================
# MODERN TOOL SHORTCUTS
# ============================================
# fzf shortcuts
alias preview='fzf --preview "bat --color=always {}"'

# ripgrep shortcuts
alias rgi='rg -i'  # case insensitive
alias rgl='rg --files-with-matches'  # files with matches

# fd shortcuts
alias fdi='fd -i'  # case insensitive
alias fdt='fd --type f'  # files only
alias fdd='fd --type d'  # directories only

# zoxide shortcut (if installed)
if command -v zoxide &> /dev/null; then
    alias cd='z'
fi

# ============================================
# SECURITY SCANNING SHORTCUTS
# ============================================
alias trivy-scan='trivy image'
alias trivy-fs='trivy fs'
alias hadolint-scan='hadolint Dockerfile'
alias tfsec-scan='tfsec .'
alias checkov-scan='checkov -d .'

# ============================================
# CI/CD SHORTCUTS
# ============================================
alias gh='gh'
alias ghr='gh repo'
alias ghp='gh pr'
alias ghi='gh issue'
alias gha='gh actions'

# ============================================
# MONITORING SHORTCUTS
# ============================================
if command -v glances &> /dev/null; then
    alias monitor='glances'
fi

if command -v ncdu &> /dev/null; then
    alias diskusage='ncdu'
fi

# ============================================
# CUSTOM WORKSPACE SHORTCUTS
# ============================================
alias devops-tools='installed-tools'
alias devops-alias='cat ~/.bash_aliases'
alias devops-help='glow ~/devops-workspace/README.md 2>/dev/null || cat ~/devops-workspace/README.md'

# Generator shortcuts
alias gen-dockerfile='dockerfile-gen'
alias gen-k8s='k8s-manifest-gen'
alias gen-compose='compose-gen'
alias gen-helm='helm-scaffold'

# Quick scan
alias scan='sec-scan .'
alias check-cluster='cluster-health'

# ============================================
# USEFUL FUNCTIONS (More complex than aliases)
# ============================================

# Quick find and edit
qedit() {
    local file
    file=$(fzf) && ${EDITOR:-vim} "$file"
}

# Quick cd with fzf
qcd() {
    local dir
    dir=$(fd --type d | fzf) && cd "$dir"
}

# Kill process by name
killp() {
    local pid
    pid=$(ps aux | fzf | awk '{print $2}')
    if [ -n "$pid" ]; then
        kill -9 "$pid"
        echo "Killed process $pid"
    fi
}

# Docker exec with shell auto-detect
dshell() {
    if [ -z "$1" ]; then
        echo "Usage: dshell <container>"
        return 1
    fi
    
    if docker exec -it "$1" bash &>/dev/null; then
        docker exec -it "$1" bash
    elif docker exec -it "$1" sh &>/dev/null; then
        docker exec -it "$1" sh
    else
        echo "No shell found in container"
    fi
}

# Docker build with tag
dbuild() {
    if [ -z "$1" ]; then
        echo "Usage: dbuild <image-name> [tag]"
        return 1
    fi
    local tag="${2:-latest}"
    docker build -t "$1:$tag" .
}

# Docker run with common flags
drun() {
    if [ -z "$1" ]; then
        echo "Usage: drun <image> [command]"
        return 1
    fi
    docker run -it --rm "$@"
}

# Kubectl apply all yaml in directory
kaf() {
    local dir="${1:-.}"
    find "$dir" -name "*.yaml" -o -name "*.yml" | xargs kubectl apply -f
}

# Get pod by partial name
kpod() {
    kubectl get pods | grep "$1" | head -1 | awk '{print $1}'
}

# Quick kubectl logs
klog() {
    local pod
    pod=$(kpod "$1")
    if [ -n "$pod" ]; then
        kubectl logs -f "$pod"
    fi
}

# Quick kubectl exec
kexec() {
    local pod
    pod=$(kpod "$1")
    if [ -n "$pod" ]; then
        kubectl exec -it "$pod" -- ${2:-sh}
    fi
}

# Terraform quick plan and apply
tfpa() {
    terraform plan && read -p "Apply? (y/n): " -n 1 -r && echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        terraform apply
    fi
}

# Git clone and cd
gccd() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Create and cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

echo "✅ DevOps aliases loaded! Type 'devops-alias' to see all aliases"
