#!/bin/bash
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/functions/common"

print_line "Setting up the environment."

SUDO_KEEP_ALIVE_PID=""
if command -v sudo >/dev/null 2>&1; then
    # Ask for the administrator password upfront
    sudo -v

    # Keep sudo alive until the script is done
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    SUDO_KEEP_ALIVE_PID=$!
    trap 'if [ -n "${SUDO_KEEP_ALIVE_PID}" ]; then kill "${SUDO_KEEP_ALIVE_PID}" 2>/dev/null; fi' EXIT
fi

# Copy dotfiles to home
"${ROOT_DIR}/scripts/install-dotfiles.sh"

if is_macos; then
    # Install Homebrew
    "${ROOT_DIR}/scripts/install-homebrew.sh"

    # Install Homebrew packages
    "${ROOT_DIR}/scripts/install-homebrew-packages.sh"

    # Set the default shell to zsh
    "${ROOT_DIR}/scripts/set-shell-to-zsh.sh"

    # Set macOS defaults
    "${ROOT_DIR}/scripts/defaults-write.sh"

elif is_debian_like; then
    print_line "Detected Debian-based Linux distribution."

    # Install packages via apt
    "${ROOT_DIR}/scripts/install-apt-packages.sh"

    # Set the default shell to zsh
    "${ROOT_DIR}/scripts/set-shell-to-zsh.sh"

    print_line "Skipping macOS-specific configuration steps on Linux."
else
    print_line "Unsupported platform: $(uname -s)."
    exit 1
fi

print_line "Done. Please restart or logout for all changes to take effect."
