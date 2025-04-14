#!/usr/bin/env bash
#
# AppImage Desktop Integrator v2.1
# A modern, user-friendly tool to integrate AppImage applications into your Linux desktop
#

# Source all required modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/lib/appimage.sh"
source "$SCRIPT_DIR/lib/desktop.sh"

# Show the welcome banner
show_welcome_banner

# Parse command line arguments and run main function
parse_args "$@"
main "$@" 