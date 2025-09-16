#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Ask for the administrator password upfront
sudo -v

# Check if we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_line "This script is only for macOS"
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    print_line "Homebrew is not installed. Please run install-homebrew.sh first"
    exit 1
fi

brew tap homebrew/cask-fonts

# Install long list of packages.
IFS=$'\n'

print_line "Updating Homebrew..."
brew update

print_line "Installing Homebrew packages..."
PACKAGES_FILE="${ROOT_DIR}/lists/brew-packages"
if [ -f "$PACKAGES_FILE" ]; then
    while IFS= read -r package || [ -n "$package" ]; do
        if [ -n "$package" ]; then  # Skip empty lines
            print_line "Installing $package..."
            HOMEBREW_NO_AUTO_UPDATE=1 brew install "$package" || print_line "Failed to install $package"
        fi
    done < "$PACKAGES_FILE"
else
    print_line "Packages file not found: $PACKAGES_FILE"
    exit 1
fi

print_line "Installing Homebrew cask packages..."
CASKS_FILE="${ROOT_DIR}/lists/brew-cask-packages"
if [ -f "$CASKS_FILE" ]; then
    while IFS= read -r cask || [ -n "$cask" ]; do
        if [ -n "$cask" ]; then  # Skip empty lines
            print_line "Installing $cask..."
            HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "$cask" || print_line "Failed to install $cask"
        fi
    done < "$CASKS_FILE"
else
    print_line "Casks file not found: $CASKS_FILE"
    exit 1
fi

#print_line "Installing App Store applications..."
#if [ -f "${ROOT_DIR}/lists/mas-app-ids" ]; then
#    cat "${ROOT_DIR}/lists/mas-app-ids" | xargs mas install
#fi

print_line "Homebrew package installation complete!"
