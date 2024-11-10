#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Check if we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_line "This script is only for macOS"
    exit 1
fi

print_line "Setting up Xcode..."

# Check if Xcode is installed
if [ ! -d "/Applications/Xcode.app" ]; then
    print_line "Error: Xcode.app not found in /Applications"
    print_line "Please install Xcode from the App Store first"
    exit 1
fi

# Run first launch setup
print_line "Running first launch setup..."
sudo xcodebuild -runFirstLaunch || {
    print_line "Error: Failed to run first launch setup"
    exit 1
}

# Set Xcode path
print_line "Setting Xcode path..."
sudo xcode-select -switch /Applications/Xcode.app || {
    print_line "Error: Failed to set Xcode path"
    exit 1
}

# Clear Xcode cache
print_line "Clearing Xcode cache..."
sudo xcrun --kill-cache || {
    print_line "Error: Failed to clear Xcode cache"
    exit 1
}

print_line "Xcode setup complete!"

# Verify setup
xcrun --find clang > /dev/null 2>&1 && {
    print_line "Verification: Xcode command line tools are properly set up"
} || {
    print_line "Warning: Xcode command line tools may not be properly set up"
    print_line "Please run 'xcode-select --install' if you encounter issues"
}