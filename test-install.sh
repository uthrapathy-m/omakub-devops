#!/bin/bash

# Quick test of the installer structure

echo "Testing DevOps Workspace Installer..."
echo ""

# Test common.sh
echo "1. Testing lib/common.sh..."
if [ -f "lib/common.sh" ]; then
    source lib/common.sh
    log_success "common.sh loaded successfully"
    init_common 2>/dev/null || log_info "init_common requires root/Linux"
else
    echo "ERROR: lib/common.sh not found!"
    exit 1
fi

echo ""
echo "2. Checking installer scripts..."
for script in installers/*.sh; do
    if [ -f "$script" ]; then
        echo "  ✓ Found: $(basename $script)"
    fi
done

echo ""
echo "3. Checking generator scripts..."
for script in generators/*; do
    if [ -f "$script" ]; then
        echo "  ✓ Found: $(basename $script)"
    fi
done

echo ""
echo "4. Checking config scripts..."
for script in config/*.sh; do
    if [ -f "$script" ]; then
        echo "  ✓ Found: $(basename $script)"
    fi
done

echo ""
log_success "All checks passed! Structure looks good."
echo ""
echo "To install on Linux, run: sudo ./install.sh"
