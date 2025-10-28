# Windows/WSL Compatibility Guide

## Overview

The DevOps Workspace Installer is designed for **Linux systems** but can be fully utilized on Windows through **WSL (Windows Subsystem for Linux)**. This guide explains how to run the installer from Windows.

---

## Prerequisites

### 1. Install WSL 2

If you don't have WSL installed yet:

```powershell
# Run in PowerShell as Administrator
wsl --install
```

This installs WSL 2 with Ubuntu by default. Restart your computer after installation.

### 2. Verify WSL Installation

```powershell
wsl --version
wsl --list --verbose
```

You should see your Ubuntu distribution running on WSL 2.

---

## Installation Methods

### Method 1: Run Installer Directly in WSL

This is the **recommended** method for full functionality.

#### Step 1: Access WSL from Windows Terminal

```powershell
# Open WSL
wsl
```

#### Step 2: Navigate to Your Project

```bash
# From WSL, access Windows files via /mnt/
cd /mnt/c/Users/"HP PC"/Desktop/workspace-cli
```

#### Step 3: Run the Installer

```bash
# Make installer executable
chmod +x install.sh

# Run with sudo
sudo bash install.sh
```

### Method 2: Copy to WSL Filesystem (Faster)

For better performance, copy the workspace-cli to the native WSL filesystem:

```bash
# In WSL
cp -r /mnt/c/Users/"HP PC"/Desktop/workspace-cli ~/workspace-cli
cd ~/workspace-cli

# Run installer
chmod +x install.sh
sudo bash install.sh
```

### Method 3: Clone from GitHub (Recommended for Updates)

```bash
# In WSL
cd ~
git clone https://github.com/YOUR_USERNAME/workspace-cli.git
cd workspace-cli

# Run installer
chmod +x install.sh
sudo bash install.sh
```

---

## Important Notes

### File System Performance

- **Slow:** `/mnt/c/` (Windows filesystem accessed from WSL)
- **Fast:** `~` or `/home/` (Native WSL filesystem)

### Running Verification

After installation, run the verification script:

```bash
# In WSL
cd ~/workspace-cli  # or /mnt/c/Users/"HP PC"/Desktop/workspace-cli
bash verify-installation.sh
```

### Accessing Installed Tools

All tools installed in WSL are available within your WSL environment:

```bash
# Example: Use Docker in WSL
wsl
docker --version
kubectl version --client
```

### Docker Desktop Integration

If you're using Docker Desktop on Windows:

1. Enable **"Use the WSL 2 based engine"** in Docker Desktop settings
2. Enable **integration with your WSL distro** (Settings → Resources → WSL Integration)
3. Docker commands will work seamlessly in WSL

---

## WSL-Specific Tips

### 1. Accessing Windows Files from WSL

```bash
# Windows C:\ drive
cd /mnt/c/

# Windows Desktop
cd /mnt/c/Users/"HP PC"/Desktop/
```

### 2. Accessing WSL Files from Windows

Open File Explorer and type in the address bar:

```
\\wsl$\Ubuntu\home\YOUR_USERNAME\workspace-cli
```

Or directly from Windows Terminal:

```powershell
explorer.exe \\wsl$\Ubuntu\home\YOUR_USERNAME\workspace-cli
```

### 3. Running WSL Commands from PowerShell

```powershell
# Run single command in WSL
wsl bash verify-installation.sh

# Execute installer from PowerShell
wsl -d Ubuntu -e sudo bash /mnt/c/Users/"HP PC"/Desktop/workspace-cli/install.sh
```

### 4. Default WSL User

Ensure your WSL user has sudo privileges:

```bash
# Check current user
whoami

# Add user to sudo group (if needed)
sudo usermod -aG sudo $USER
```

---

## Common Issues & Solutions

### Issue 1: Permission Denied

**Problem:**
```
bash: ./install.sh: Permission denied
```

**Solution:**
```bash
chmod +x install.sh
sudo bash install.sh
```

### Issue 2: Slow Installation from Windows Path

**Problem:** Installation is very slow when running from `/mnt/c/`

**Solution:** Copy project to WSL filesystem (`~/`)

```bash
cp -r /mnt/c/Users/"HP PC"/Desktop/workspace-cli ~/workspace-cli
cd ~/workspace-cli
sudo bash install.sh
```

### Issue 3: Docker Not Available

**Problem:** Docker commands not working after installation

**Solution:**
1. Install Docker Desktop for Windows
2. Enable WSL 2 integration in Docker Desktop settings
3. Or install Docker directly in WSL using the installer's containers module

### Issue 4: Systemd Services Not Starting

**Problem:** Some services like Docker daemon won't start

**Solution:**
- WSL 2 supports systemd on Ubuntu 22.04+
- Enable systemd in `/etc/wsl.conf`:

```bash
sudo tee /etc/wsl.conf > /dev/null << EOF
[boot]
systemd=true
EOF
```

Then restart WSL:
```powershell
wsl --shutdown
wsl
```

### Issue 5: Out of Memory

**Problem:** Installation fails due to insufficient memory

**Solution:** Increase WSL memory limit in `.wslconfig`:

```powershell
# Create/edit %USERPROFILE%\.wslconfig
notepad $env:USERPROFILE\.wslconfig
```

Add:
```ini
[wsl2]
memory=8GB
processors=4
```

Restart WSL:
```powershell
wsl --shutdown
wsl
```

---

## Verification on Windows

After installation, verify from PowerShell:

```powershell
# Check if tools are available in WSL
wsl docker --version
wsl kubectl version --client
wsl terraform version

# Run full verification
wsl bash verify-installation.sh
```

---

## Updating the Installer

To get the latest updates:

```bash
# In WSL
cd ~/workspace-cli
git pull origin main

# Re-run installer to update tools
sudo bash install.sh
```

---

## Best Practices

1. **Use WSL 2** (not WSL 1) for better performance and Docker support
2. **Store projects in WSL filesystem** (`~/`) for faster access
3. **Use Windows Terminal** for better WSL experience
4. **Enable systemd** in WSL for service management
5. **Configure resource limits** in `.wslconfig` for optimal performance

---

## Additional Resources

- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Docker Desktop WSL 2 Backend](https://docs.docker.com/desktop/wsl/)
- [VSCode with WSL](https://code.visualstudio.com/docs/remote/wsl)

---

## Quick Reference

### Essential Commands

```bash
# Enter WSL
wsl

# Exit WSL
exit

# Shutdown WSL (from PowerShell)
wsl --shutdown

# Update WSL
wsl --update

# List distributions
wsl --list --verbose

# Set default distribution
wsl --set-default Ubuntu

# Unregister a distribution
wsl --unregister Ubuntu
```

---

## Support

If you encounter issues specific to WSL, please open an issue on GitHub with:
- Windows version
- WSL version (`wsl --version`)
- Distribution and version (`wsl lsb_release -a`)
- Error logs from `install.log` or verification output
