#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# Print functions
print_status() { printf "${BLUE}[${BOLD}●${NC}${BLUE}]${NC} %b\n" "$1"; }
print_success() { printf "${GREEN}[${BOLD}✓${NC}${GREEN}]${NC} %b\n" "$1"; }
print_error() { printf "${RED}[${BOLD}✗${NC}${RED}]${NC} %b\n" "$1" >&2; }

# Installation directories
INSTALL_DIR="${HOME}/.local/bin"
LIB_DIR="${HOME}/.local/lib/appimage-integrator"
COMPLETION_DIR="${HOME}/.local/share/bash-completion/completions"

# Create directories
print_status "Creating installation directories..."
mkdir -p "$INSTALL_DIR" "$LIB_DIR" "$COMPLETION_DIR"

# Copy files
print_status "Installing AppImage Integrator..."
cp -r lib/* "$LIB_DIR/"
cp bin/appimage-integrator "$INSTALL_DIR/"

# Make executable
chmod +x "$INSTALL_DIR/appimage-integrator"

# Add to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    print_status "Added ~/.local/bin to PATH"
fi

print_success "Installation complete!"
echo
echo -e "${BOLD}To start using AppImage Integrator:${NC}"
echo "1. Close and reopen your terminal, or run:"
echo "   source ~/.bashrc"
echo "2. Run the tool with:"
echo "   appimage-integrator --help" 