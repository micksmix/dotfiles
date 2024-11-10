#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Check if we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_line "This script is only for macOS"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

print_line "Warning: This will restart the userspace, which will close all applications."
print_line "Please save any open work before continuing."
print_line "Starting countdown..."

# Countdown from 5
for i in {5..1}; do
    print_line "$i..."
    sleep 1
done

print_line "Restarting userspace now..."

# Restart userspace
sudo launchctl reboot userspace || {
    print_line "Error: Failed to restart userspace"
    exit 1
}