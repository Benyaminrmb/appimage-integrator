#!/usr/bin/env bash
#
# Utility functions for AppImage Integrator
#

# Default directories with XDG support
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Default paths
DEFAULT_APPDIR="$XDG_DATA_HOME/appimages"
DEFAULT_ICONDIR="$XDG_DATA_HOME/icons/appimages"
DEFAULT_DESKTOPDIR="$XDG_DATA_HOME/applications"
DEFAULT_CACHEDIR="$XDG_CACHE_HOME/appimage-integrator"

# Global variables
VERBOSE=false
FORCE_OVERWRITE=false
DEBUG_MODE=false
TEMP_DIR=""

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Execute a command with debug output
execute_command() {
    if [ "$DEBUG_MODE" = true ]; then
        print_debug "Executing: $*"
        "$@"
    else
        "$@" >/dev/null 2>&1
    fi
}

# Confirm an action
confirm_action() {
    local message="$1"
    local default="${2:-n}"
    
    [ "$FORCE_OVERWRITE" = true ] && return 0
    
    local prompt
    local default_upper
    
    if [ "$default" = "y" ]; then
        prompt="[Y/n]"
        default_upper="Y"
    else
        prompt="[y/N]"
        default_upper="N"
    fi
    
    printf "${YELLOW}${BOLD}%s %s ${NC}" "$message" "$prompt"
    read -r response
    
    [ -z "$response" ] && response="$default_upper"
    
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Create required directories
create_directories() {
    local dirs=(
        "$DEFAULT_APPDIR"
        "$DEFAULT_ICONDIR"
        "$DEFAULT_DESKTOPDIR"
        "$DEFAULT_CACHEDIR"
    )
    
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            print_debug "Creating directory: $dir"
            mkdir -p "$dir" || {
                print_error "Failed to create directory: $dir"
                return 1
            }
        fi
    done
}

# Create temporary directory
create_temp_dir() {
    TEMP_DIR=$(mktemp -d)
    print_debug "Created temporary directory: $TEMP_DIR"
    
    # Set up cleanup trap
    trap cleanup EXIT
}

# Cleanup function
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        print_debug "Cleaning up temporary directory: $TEMP_DIR"
        rm -rf "$TEMP_DIR"
    fi
}

# Get file size in human readable format
get_human_size() {
    local size=$1
    local units=('B' 'KB' 'MB' 'GB' 'TB')
    local unit=0
    
    while ((size > 1024 && unit < ${#units[@]}-1)); do
        size=$(echo "scale=2; $size/1024" | bc)
        ((unit++))
    done
    
    printf "%.2f %s" "$size" "${units[$unit]}"
}

# Check for root privileges
check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Check system requirements
check_system() {
    local missing_deps=()
    local deps=(
        "desktop-file-validate"
        "update-desktop-database"
        "gio"
        "zenity"
    )
    
    for dep in "${deps[@]}"; do
        if ! command_exists "$dep"; then
            case "$dep" in
                "desktop-file-validate"|"update-desktop-database")
                    missing_deps+=("desktop-file-utils")
                    ;;
                "gio")
                    missing_deps+=("glib2")
                    ;;
                "zenity")
                    missing_deps+=("zenity")
                    ;;
                *)
                    missing_deps+=("$dep")
                    ;;
            esac
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_warning "Missing recommended dependencies:"
        printf "  %s\n" "${missing_deps[@]}"
        
        # Detect package manager and suggest installation command
        if command_exists "apt"; then
            suggest_install "apt" "sudo apt install" "${missing_deps[@]}"
        elif command_exists "dnf"; then
            suggest_install "dnf" "sudo dnf install" "${missing_deps[@]}"
        elif command_exists "pacman"; then
            suggest_install "pacman" "sudo pacman -S" "${missing_deps[@]}"
        elif command_exists "zypper"; then
            suggest_install "zypper" "sudo zypper install" "${missing_deps[@]}"
        fi
    fi
}

# Suggest package installation
suggest_install() {
    local pkg_manager="$1"
    local install_cmd="$2"
    shift 2
    local packages=("$@")
    
    print_info "You can install them with: $install_cmd ${packages[*]}"
    if confirm_action "Install missing dependencies now?" "y"; then
        print_status "Installing dependencies..."
        if execute_command $install_cmd "${packages[@]}"; then
            print_success "Dependencies installed successfully"
        else
            print_error "Failed to install dependencies"
            print_info "Continuing without recommended dependencies..."
        fi
    fi
} 