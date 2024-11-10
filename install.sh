#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/functions/common"

print_line "Setting up the environment."

# Ask for the administrator password upfront
sudo -v

# Keep sudo alive until the script is done
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Copy dotfiles to home
"${ROOT_DIR}/scripts/install-dotfiles.sh"

# Install homebrew
"${ROOT_DIR}/scripts/install-homebrew.sh"

# Install homebrew packages
"${ROOT_DIR}/scripts/install-homebrew-packages.sh"

# Set the default shell to zsh
"${ROOT_DIR}/scripts/set-shell-to-zsh.sh"

# Set sane defaults
"${ROOT_DIR}/scripts/defaults-write.sh"

# Remap keyboard settings
#"${ROOT_DIR}/scripts/remap-keyboard.sh"

# Set up applications
#"${ROOT_DIR}/scripts/defaults-app-write.sh"

# Create and install the Root FS overlay root
#"${ROOT_DIR}/scripts/install-rootfs-overlay.sh"

# Start services
#"${ROOT_DIR}/scripts/start-services.sh"

# Install Xcode dependencies.
#"${ROOT_DIR}/scripts/install-xcode-dependencies.sh"

# Restart userspace
#"${ROOT_DIR}/scripts/restart-userspace.sh"

print_line "Done. Please restart or logout for all changes to take effect."



# #!/bin/bash
# source functions/common

# print_line "Setting up the environment."

# # Ask for the administrator password upfront
# sudo -v

# # Copy dotfiles to home
# ./scripts/install-dotfiles.sh

# # Install homebrew
# ./scripts/install-homebrew.sh

# # Install homebrew packages
# ./scripts/install-homebrew-packages.sh

# # Set the default shell to zsh
# ./scripts/set-shell-to-zsh.sh

# # Set sane defaults
# ./scripts/defaults-write.sh

# # Remap keyboard settings
# #./scripts/remap-keyboard.sh

# # Set up applications
# #./scripts/defaults-app-write.sh

# # Create and install the Root FS overlay root
# #./scripts/install-rootfs-overlay.sh

# # Start services
# #./scripts/start-services.sh

# # Install Xcode dependencies.
# #./scripts/install-xcode-dependencies.sh

# # Restart userspace
# #./scripts/restart-userspace.sh

# print_line "Done. Please restart or logout for all changes to take effect."