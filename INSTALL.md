# 📦 Installation Guide

Complete step-by-step instructions to install the DevOps Workspace on your Linux system.

## 📋 Prerequisites

- **Operating System**: Ubuntu, Debian, RHEL, CentOS, Fedora, or Amazon Linux
- **User Privileges**: Root or sudo access
- **Internet Connection**: Required for downloading tools
- **Git**: For cloning the repository

## 🚀 Quick Install (One-Command)

```bash
curl -fsSL https://raw.githubusercontent.com/uthrapathy-m/omakub-devops/main/install.sh | sudo bash
```

## 📖 Manual Installation (Recommended)

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/uthrapathy-m/omakub-devops.git

# Navigate to the directory
cd omakub-devops
```

### Step 2: Make Scripts Executable

```bash
# Make all scripts executable
chmod +x install.sh
chmod +x lib/*.sh
chmod +x installers/*.sh
chmod +x config/*.sh
chmod +x generators/*
```

### Step 3: Verify Installation Files (Optional)

```bash
# Run the test script to verify structure
bash test-install.sh
```

Expected output:
```
Testing DevOps Workspace Installer...

1. Testing lib/common.sh...
✓ common.sh loaded successfully

2. Checking installer scripts...
  ✓ Found: containers.sh
  ✓ Found: productivity.sh

3. Checking generator scripts...
  ✓ Found: cluster-health
  ✓ Found: dockerfile-gen
  ✓ Found: sec-scan

4. Checking config scripts...
  ✓ Found: aliases.sh
  ✓ Found: install-generators.sh
  ✓ Found: setup-shell.sh

✓ All checks passed! Structure looks good.
```

### Step 4: Run the Installer

```bash
# Run the main installer with sudo
sudo ./install.sh
```

### Step 5: Choose Installation Option

You'll see this menu:

```
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

Select Installation Type:

1)  🚀 Complete DevOps Workspace (Everything)
2)  📦 Container & Orchestration Tools
3)  ☁️  Cloud Provider CLIs
4)  🏗️  Infrastructure as Code Tools
5)  🔒 Security & Compliance Tools
6)  📊 Monitoring & Observability
7)  🚀 CI/CD & GitOps Tools
8)  💻 Modern CLI Productivity Tools
9)  🎨 Shell Enhancement & Beautification
10) 🛠️  Custom Installation (Choose specific tools)
11) 📚 Install Custom Generators Only
12) ⚙️  Configure Shell & Aliases Only
13) ❌ Exit

Enter your choice [1-13]:
```

**Choose an option:**
- Type `1` and press Enter for complete installation
- Type `2-9` for specific categories
- Type `10` for custom selection
- Type `12` for shell configuration only

### Step 6: Wait for Installation

The installer will:
- ✅ Detect your OS and package manager
- ✅ Update system packages
- ✅ Download and install selected tools
- ✅ Configure shell with aliases and prompt
- ✅ Show progress with colored output

### Step 7: Reload Your Shell

After installation completes:

```bash
# Reload your shell to apply changes
source ~/.bashrc

# Or just open a new terminal
```

### Step 8: Verify Installation

```bash
# Check installed tools
installed-tools

# View all aliases
devops-alias

# Test generators
dockerfile-gen --help
sec-scan --help
cluster-health --help
```

## 🎯 Installation Options Explained

### Option 1: Complete Workspace
Installs **everything** - all tools, aliases, generators, and configurations.
- **Recommended for**: New DevOps setups, full workstations
- **Time**: 20-30 minutes
- **Disk Space**: ~2-3 GB

### Option 2: Container & Orchestration
Docker, kubectl, Helm, k9s, minikube, kubectx, krew, stern, kustomize, kubeval, popeye, lazydocker
- **Recommended for**: Kubernetes/Docker engineers
- **Time**: 10-15 minutes

### Option 3: Cloud Provider CLIs
AWS CLI, Azure CLI, Google Cloud SDK, eksctl
- **Recommended for**: Cloud architects, platform engineers
- **Time**: 5-10 minutes

### Option 4: Infrastructure as Code
Terraform, Terragrunt, Ansible, Packer, tfsec, checkov, infracost
- **Recommended for**: Infrastructure engineers, SREs
- **Time**: 8-12 minutes

### Option 5: Security & Compliance
Trivy, hadolint, kube-bench, kubesec, git-secrets, age, SOPS, Vault, cosign
- **Recommended for**: Security engineers, compliance teams
- **Time**: 5-8 minutes

### Option 6: Monitoring & Observability
Prometheus, Grafana, btop, htop, glances
- **Recommended for**: SREs, monitoring teams
- **Time**: 10-15 minutes

### Option 7: CI/CD & GitOps
GitHub CLI, GitLab CLI, act, ArgoCD, Flux
- **Recommended for**: CI/CD engineers, DevOps teams
- **Time**: 5-8 minutes

### Option 8: Modern CLI Productivity
starship, fzf, bat, eza, zoxide, ripgrep, fd, jq, yq, tldr, delta, lazygit, glow
- **Recommended for**: Everyone! Massive productivity boost
- **Time**: 8-12 minutes

### Option 9: Shell Enhancement
Beautiful prompt, aliases, auto-completion, colorized output
- **Recommended for**: Everyone! Makes terminal beautiful
- **Time**: 2-3 minutes

### Option 10: Custom Installation
Pick and choose exactly what you want
- **Recommended for**: Advanced users, specific needs
- **Time**: Varies

### Option 11: Generators Only
Installs: dockerfile-gen, k8s-manifest-gen, compose-gen, helm-scaffold, sec-scan, cluster-health
- **Recommended for**: Quick utility installation
- **Time**: 1-2 minutes

### Option 12: Shell Config Only
Just aliases and prompt - no tool installation
- **Recommended for**: Systems with tools already installed
- **Time**: 1 minute

## 🔧 Post-Installation Setup

### Configure Cloud Providers

```bash
# AWS
aws configure
# Enter: Access Key ID, Secret Access Key, Region, Output format

# Azure
az login
# Follow browser authentication

# Google Cloud
gcloud init
# Follow interactive setup
```

### Configure Git (if not already)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Docker Post-Setup

```bash
# Add your user to docker group (already done by installer)
# Log out and back in for it to take effect

# Test Docker
docker run hello-world

# If permission issues persist:
sudo usermod -aG docker $USER
newgrp docker
```

### Kubernetes Setup

```bash
# For minikube
minikube start

# Or connect to existing cluster
export KUBECONFIG=/path/to/your/kubeconfig

# Test kubectl
kubectl version --client
kubectl get nodes
```

## 🎓 First Steps After Installation

### 1. Test the New Aliases

```bash
# Kubernetes
k get pods          # instead of kubectl get pods
kgp                 # even shorter!

# Docker
d ps                # instead of docker ps
dps                 # formatted output

# Git
gs                  # git status
gl                  # git log (pretty)
```

### 2. Try the Fuzzy Finder

```bash
# Press Ctrl+R - fuzzy search command history
# Press Ctrl+T - fuzzy find files
# Press Alt+C  - fuzzy change directory
```

### 3. Use Smart Navigation

```bash
# Jump to directories with zoxide
z projects          # jumps to ~/dev/projects
z docs              # jumps to ~/documents

# Quick navigation
..                  # cd ..
...                 # cd ../..
```

### 4. Generate a Dockerfile

```bash
# Interactive Dockerfile generator
dockerfile-gen

# Follow prompts to create optimized Dockerfiles
```

### 5. Scan for Security Issues

```bash
# Scan current directory
sec-scan .

# Scan Docker image
sec-scan -i myimage:latest
```

### 6. Check Cluster Health

```bash
# Comprehensive K8s diagnostics
cluster-health
```

## 🐛 Troubleshooting

### Issue: "Permission denied" when running install.sh

**Solution:**
```bash
chmod +x install.sh
sudo ./install.sh
```

### Issue: Docker permission denied

**Solution:**
```bash
sudo usermod -aG docker $USER
# Log out and back in
```

### Issue: kubectl not working

**Solution:**
```bash
# Check if kubectl is installed
which kubectl

# Set KUBECONFIG
export KUBECONFIG=~/.kube/config
```

### Issue: Aliases not loading

**Solution:**
```bash
# Reload shell
source ~/.bashrc

# Or check if file exists
cat ~/.bash_aliases
```

### Issue: Starship prompt not showing

**Solution:**
```bash
# Add to ~/.bashrc if missing
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Command not found after installation

**Solution:**
```bash
# Reload PATH
source ~/.bashrc

# Or check if it's in PATH
echo $PATH

# Find the binary
which <command-name>
```

## 🔄 Updating the Workspace

To update to the latest version:

```bash
cd omakub-devops
git pull
sudo ./install.sh
# Select the same options you chose before
```

## 🗑️ Uninstalling

Currently, there's no automated uninstall. To remove manually:

```bash
# Remove installed binaries
sudo rm /usr/local/bin/dockerfile-gen
sudo rm /usr/local/bin/sec-scan
sudo rm /usr/local/bin/cluster-health
sudo rm /usr/local/bin/installed-tools

# Remove aliases (backup first!)
cp ~/.bash_aliases ~/.bash_aliases.backup
rm ~/.bash_aliases

# Remove prompt customizations
# Edit ~/.bashrc and remove the "DEVOPS WORKSPACE" sections

# Reload shell
source ~/.bashrc
```

## 📞 Getting Help

- **Documentation**: See [README.md](README.md) and [QUICKSTART.md](QUICKSTART.md)
- **Issues**: https://github.com/uthrapathy-m/omakub-devops/issues
- **Bug Reports**: Use the GitHub issues with the bug label

## 🎯 Recommendations

### For Beginners
Start with:
1. Option 8 (Productivity Tools) - Makes terminal amazing
2. Option 9 (Shell Enhancement) - Beautiful prompt and aliases
3. Option 2 (Containers) - If working with Docker/K8s

### For Experienced DevOps
Go with:
- Option 1 (Complete Workspace) - Get everything at once

### For Specific Roles

**Container/Kubernetes Engineer:**
- Option 2 (Containers)
- Option 5 (Security)
- Option 8 (Productivity)

**Cloud Architect:**
- Option 3 (Cloud CLIs)
- Option 4 (IaC)
- Option 8 (Productivity)

**Security Engineer:**
- Option 5 (Security)
- Option 4 (IaC - for scanning)
- Option 11 (Generators - for sec-scan)

**SRE/Platform Engineer:**
- Option 1 (Everything)

## ✅ Verification Checklist

After installation, verify:

- [ ] Shell prompt shows colors and git status
- [ ] `k` command works (kubectl alias)
- [ ] `d` command works (docker alias)
- [ ] Ctrl+R shows fuzzy history search
- [ ] `dockerfile-gen` command works
- [ ] `sec-scan` command works
- [ ] `installed-tools` shows list of tools
- [ ] `ll` shows colored file listing

## 🚀 You're All Set!

Your DevOps workspace is ready! Start with:
```bash
# Check what's installed
installed-tools

# See all aliases
devops-alias

# Start using shortcuts!
k get pods
d ps
gs
```

**Happy DevOps! 🎉**

---

*For more information, see [README.md](README.md) and [QUICKSTART.md](QUICKSTART.md)*
