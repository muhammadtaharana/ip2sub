#!/bin/bash

# Origin Mapper (ip2sub) Installation Script
# This script installs the ip2sub tool to /usr/local/bin for system-wide access

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_PATH="/usr/local/bin/ip2sub"
SOURCE_FILE="$SCRIPT_DIR/ip2sub.sh"

# Check if ip2sub.sh exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "❌ Error: ip2sub.sh not found in $SCRIPT_DIR"
    exit 1
fi

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "❌ Error: This script must be run with sudo privileges"
    echo "Usage: sudo ./install.sh"
    exit 1
fi

# Check dependencies
echo "🔍 Checking dependencies..."
MISSING_DEPS=()

for cmd in dig openssl wafw00f curl; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_DEPS+=("$cmd")
    fi
done

if [[ ${#MISSING_DEPS[@]} -gt 0 ]]; then
    echo "⚠️  Warning: The following dependencies are missing:"
    for dep in "${MISSING_DEPS[@]}"; do
        echo "   - $dep"
    done
    echo ""
    echo "Install them before running ip2sub:"
    echo "  Ubuntu/Debian: sudo apt-get install dnsutils openssl curl"
    echo "  macOS: brew install bind openssl curl"
    echo "  wafw00f: pip install wafw00f"
    echo ""
    read -p "Continue installation anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create a wrapper script with proper shebang
echo "📦 Installing ip2sub to $INSTALL_PATH..."
cp "$SOURCE_FILE" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

# Verify installation
if [[ -x "$INSTALL_PATH" ]]; then
    echo "✅ Installation successful!"
    echo ""
    echo "You can now run 'ip2sub' from anywhere:"
    echo "  ip2sub ips.txt"
    echo ""
    echo "To uninstall, run:"
    echo "  sudo rm $INSTALL_PATH"
else
    echo "❌ Installation failed"
    exit 1
fi
