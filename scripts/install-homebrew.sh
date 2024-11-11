#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Check if we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_line "This script is only for macOS"
    exit 1
fi

print_line "Installing Homebrew..."

# Determine Mac architecture and set Homebrew paths accordingly
if [[ "$(uname -m)" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi

# Install homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
    print_line "Installing Command Line Tools and accepting user license..."
    
    # Try to install xcode command line tools
    if ! xcode-select -p >/dev/null 2>&1; then
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        softwareupdate -i "$PROD" --verbose
        rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    fi
    
    # Accept xcode license
    sudo xcodebuild -license accept
    
    # Install Homebrew
    print_line "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        print_line "Failed to install Homebrew"
        exit 1
    }
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ "$(uname -m)" == "arm64" ]]; then
        print_line "Adding Homebrew to PATH..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    print_line "Homebrew is already installed"
fi

print_line "Updating Homebrew..."
brew update || {
    print_line "Failed to update Homebrew"
    exit 1
}

print_line "Upgrading existing formulae..."
brew upgrade || {
    print_line "Failed to upgrade Homebrew packages"
    exit 1
}

print_line "Homebrew installation and setup complete!"

# Final check
if command -v brew >/dev/null 2>&1; then
    print_line "Homebrew version: $(brew --version)"
    print_line "Homebrew prefix: $(brew --prefix)"
else
    print_line "Error: Homebrew installation appears to have failed"
    exit 1
fi
