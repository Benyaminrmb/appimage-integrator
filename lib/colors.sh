#!/usr/bin/env bash
#
# Color definitions and helper functions for terminal output
#

# Basic Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'

# Bright Colors
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'

# Text Styles
BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
HIDDEN='\033[8m'
STRIKE='\033[9m'

# Reset
NC='\033[0m'

# Print functions with improved formatting
print_color() {
    printf "${1}%b${NC}\n" "$2"
}

print_status() {
    printf "${BLUE}[${BOLD}●${NC}${BLUE}]${NC} %b\n" "$1"
}

print_success() {
    printf "${GREEN}[${BOLD}✓${NC}${GREEN}]${NC} %b\n" "$1"
}

print_error() {
    printf "${RED}[${BOLD}✗${NC}${RED}]${NC} %b\n" "$1" >&2
}

print_warning() {
    printf "${YELLOW}[${BOLD}!${NC}${YELLOW}]${NC} %b\n" "$1"
}

print_info() {
    printf "${CYAN}[${BOLD}i${NC}${CYAN}]${NC} %b\n" "$1"
}

print_debug() {
    [ "$DEBUG_MODE" = true ] && printf "${MAGENTA}[${BOLD}DEBUG${NC}${MAGENTA}]${NC} %b\n" "$1"
}

print_section() {
    echo
    printf "${BOLD}${UNDERLINE}%s${NC}\n" "$1"
    echo
}

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    local empty=$((width - filled))
    
    printf "\r${BLUE}[${BOLD}"
    printf "%${filled}s" '' | tr ' ' '█'
    printf "%${empty}s" '' | tr ' ' '░'
    printf "${NC}${BLUE}]${NC} ${BOLD}%3d%%${NC}" "$percentage"
    
    [ "$current" -eq "$total" ] && echo
} 