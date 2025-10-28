# 🚀 DevOps Workspace Installer

**Your Complete DevOps Toolkit in One Installation**

Inspired by [Omakub](https://omakub.org/), this installer provides a comprehensive, customizable DevOps workspace with all the tools you need for modern cloud-native development and operations.

## ✨ Features

- 📦 **Container & Orchestration**: Docker, Kubernetes, Helm, k9s, kubectl, and more
- ☁️ **Cloud Providers**: AWS CLI, Azure CLI, Google Cloud SDK, eksctl
- 🏗️ **Infrastructure as Code**: Terraform, Terragrunt, Ansible, Packer
- 🔒 **Security & Compliance**: Trivy, Hadolint, tfsec, checkov, SOPS, Vault
- 📊 **Monitoring & Observability**: Prometheus, Grafana, btop, htop, glances
- 🚀 **CI/CD & GitOps**: GitHub CLI, GitLab CLI, ArgoCD, Flux
- 💻 **Modern CLI Tools**: fzf, bat, eza, ripgrep, zoxide, delta, lazygit
- 🎨 **Custom Generators**: Interactive tools for Dockerfiles, K8s manifests, Helm charts
- ⚙️ **Shell Enhancement**: Beautiful prompts, aliases, auto-completion

## 🎯 Quick Start

### Installation

```bash
# Clone the repository
git clone <repository-url> devops-workspace
cd devops-workspace

# Make installer executable
chmod +x install.sh

# Run the installer
sudo ./install.sh
```

### Installation Options

When you run the installer, you'll see an interactive menu:

1. **Complete DevOps Workspace** - Install everything
2. **Container & Orchestration** - Docker, Kubernetes, Helm, k9s, kubectl
3. **Cloud Provider CLIs** - AWS, Azure, GCP tools
4. **Infrastructure as Code** - Terraform, Terragrunt, Ansible
5. **Security & Compliance** - Security scanners and tools
6. **Monitoring & Observability** - Monitoring tools and dashboards
7. **CI/CD & GitOps** - Continuous integration and deployment tools
8. **Modern CLI Productivity** - Enhanced terminal experience
9. **Shell Enhancement** - Prompts, aliases, and beautification
10. **Custom Installation** - Pick and choose specific categories
11. **Custom Generators Only** - Install helper scripts only
12. **Configure Shell & Aliases** - Setup shell configuration only

## 📦 Installed Tools

### Container & Orchestration
- **Docker** + **Docker Compose** - Container runtime
- **kubectl** - Kubernetes CLI
- **minikube** - Local Kubernetes cluster
- **helm** - Kubernetes package manager
- **k9s** - Kubernetes TUI (Terminal UI)
- **kubectx** + **kubens** - Context/namespace switching
- **krew** - kubectl plugin manager
- **stern** - Multi-pod log tailing
- **kustomize** - Kubernetes manifest customization
- **kubeval** - K8s YAML validation
- **popeye** - Kubernetes cluster sanitizer
- **lazydocker** - Docker TUI

### Cloud Providers
- **AWS CLI v2** - Amazon Web Services
- **Azure CLI** - Microsoft Azure
- **gcloud CLI** - Google Cloud Platform
- **eksctl** - AWS EKS management

### Infrastructure as Code
- **Terraform** - Infrastructure provisioning
- **Terragrunt** - Terraform wrapper
- **Ansible** - Configuration management
- **Packer** - Image building
- **tfsec** - Terraform security scanner
- **checkov** - IaC security scanning
- **infracost** - Cloud cost estimates

### Security & Compliance
- **trivy** - Vulnerability scanner
- **hadolint** - Dockerfile linter
- **kube-bench** - CIS Kubernetes benchmarks
- **kubesec** - K8s security risk analysis
- **git-secrets** - Prevent committing secrets
- **age** - File encryption
- **sops** - Secrets management
- **vault** - HashiCorp Vault CLI
- **cosign** - Container image signing

### Monitoring & Observability
- **prometheus** - Metrics collection
- **promtool** - Prometheus validation
- **grafana-cli** - Grafana management
- **btop** - Resource monitor
- **htop** - Interactive process viewer
- **glances** - System monitoring

### Modern CLI Productivity
- **starship** - Beautiful cross-shell prompt
- **fzf** - Fuzzy finder
- **bat** - Cat with syntax highlighting
- **eza** - Modern ls replacement
- **zoxide** - Smart cd command
- **ripgrep** - Faster grep
- **fd** - Faster find
- **jq** + **yq** - JSON/YAML processors
- **tldr** - Simplified man pages
- **ncdu** - Disk usage analyzer
- **duf** - Disk usage tool
- **delta** - Beautiful git diffs
- **lazygit** - Git TUI
- **glow** - Markdown renderer in terminal

## 🎨 Custom Generators

Interactive generators for common DevOps tasks:

### dockerfile-gen
Generate optimized Dockerfiles for various tech stacks:
```bash
dockerfile-gen
```
Supports: Node.js, Python, Go, Java, PHP, Rust, Ruby, .NET, Static sites

### k8s-manifest-gen
Create Kubernetes YAML manifests:
```bash
k8s-manifest-gen
```
Generates: Deployments, Services, ConfigMaps, Secrets, Ingress

### compose-gen
Generate Docker Compose files:
```bash
compose-gen
```

### helm-scaffold
Quick Helm chart creator:
```bash
helm-scaffold
```

### sec-scan
All-in-one security scanner wrapper:
```bash
sec-scan <directory>
```
Runs: trivy, hadolint, tfsec, checkov

### cluster-health
Quick Kubernetes cluster health check:
```bash
cluster-health
```

## ⚙️ Shell Configuration

After installation, your shell will be enhanced with:

### Aliases

**Container & Kubernetes**
```bash
k       # kubectl
kgp     # kubectl get pods
kgs     # kubectl get services
d       # docker
dps     # docker ps (formatted)
dc      # docker-compose
```

**Git Shortcuts**
```bash
gs      # git status
ga      # git add
gc      # git commit -m
gp      # git push
gl      # git log (formatted)
gd      # git diff
```

**Productivity**
```bash
ll      # eza -l (if installed, else ls -la)
bat     # cat with syntax highlighting
z       # zoxide (smart cd)
..      # cd ..
...     # cd ../..
```

### Custom Functions

**Docker Helpers**
```bash
dls         # List running containers (formatted)
dimages     # List Docker images (formatted)
dsys        # Docker system info
dnet        # Docker networks
dvol        # Docker volumes
```

**Kubernetes Helpers**
```bash
kctx        # Switch kubectl context
kns         # Switch kubectl namespace
kdebug      # Launch debug pod
klogs       # Tail logs from pods
```

**System Info**
```bash
sysinfo     # Quick system information
lports      # List listening ports
diskusage   # Disk usage table
memoryinfo  # Memory usage
pstable     # Top processes by CPU
```

### Prompt Enhancement

Your prompt will show:
- Current username and hostname
- Current directory
- Git branch and status (with colors)
- Kubernetes context (optional)
- Cloud provider info (optional)

Or use **starship** for an even more beautiful prompt!

## 🔧 Usage Examples

### Generate a Dockerfile
```bash
dockerfile-gen
# Follow interactive prompts to generate optimized Dockerfile
```

### Create Kubernetes Deployment
```bash
k8s-manifest-gen
# Select deployment type and answer questions
```

### Security Scan
```bash
sec-scan .
# Runs all security scanners on current directory
```

### Check Cluster Health
```bash
cluster-health
# Shows K8s cluster status, resource usage, and issues
```

### Quick Docker Build & Push
```bash
# Build image
docker build -t myapp:v1.0 .

# Or use helper
dimg-build myapp v1.0

# Push to registry
dimg-push myapp v1.0
```

## 📚 Directory Structure

```
devops-workspace/
├── install.sh              # Main installer script
├── installers/             # Category-specific installers
│   ├── containers.sh
│   ├── cloud.sh
│   ├── iac.sh
│   ├── security.sh
│   ├── monitoring.sh
│   ├── cicd.sh
│   ├── productivity.sh
│   ├── networking.sh
│   ├── databases.sh
│   ├── editors.sh
│   └── devtools.sh
├── generators/             # Custom generator scripts
│   ├── dockerfile-gen
│   ├── k8s-manifest-gen
│   ├── compose-gen
│   ├── helm-scaffold
│   ├── sec-scan
│   ├── cluster-health
│   └── log-tail
├── config/                 # Configuration files
│   ├── aliases.sh
│   ├── functions.sh
│   ├── prompt.sh
│   ├── completions.sh
│   ├── setup-shell.sh
│   └── install-generators.sh
└── README.md              # This file
```

## 🎓 Tips & Best Practices

### After Installation

1. **Reload your shell**: `source ~/.bashrc`
2. **Test installations**: Run `which docker kubectl terraform` etc.
3. **Configure cloud providers**: 
   - AWS: `aws configure`
   - Azure: `az login`
   - GCP: `gcloud init`

### Productivity Tips

1. **Use fzf**: Press `Ctrl+R` for fuzzy history search
2. **Use zoxide**: `z <partial-dir-name>` to jump to directories
3. **Use k9s**: Best way to manage Kubernetes clusters
4. **Use lazydocker**: Beautiful Docker management interface
5. **Use lazygit**: Interactive Git workflow

### Security Best Practices

1. Always scan images: `trivy image myimage:latest`
2. Lint Dockerfiles: `hadolint Dockerfile`
3. Scan IaC: `tfsec .` or `checkov -d .`
4. Use SOPS for secrets: `sops -e secrets.yaml`
5. Sign images: `cosign sign myimage:latest`

## 🔄 Updates

To update tools:

```bash
# Re-run specific category installer
sudo bash installers/containers.sh

# Or update all
sudo ./install.sh
# Select option 1 for complete installation
```

## 🐛 Troubleshooting

### Docker permission issues
```bash
sudo usermod -aG docker $USER
# Log out and back in
```

### kubectl not finding config
```bash
export KUBECONFIG=~/.kube/config
```

### Starship prompt not showing
```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Add new tool installers
- Create additional generators
- Improve existing scripts
- Report bugs
- Suggest features

## 📄 License

MIT License - Feel free to use and modify as needed.

## 🙏 Acknowledgments

- Inspired by [Omakub](https://omakub.org/)
- Built for the DevOps community
- Uses amazing open-source tools

## 📞 Support

For issues and questions:
- Check existing documentation
- Review tool-specific documentation
- Community forums
- GitHub issues

---

**Happy DevOps! 🚀**

*Built with ❤️ for the DevOps community*
