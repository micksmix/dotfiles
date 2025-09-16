#!/bin/bash
set -euo pipefail

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

if ! is_debian_like; then
    print_line "This script is intended for Debian-based Linux distributions."
    exit 1
fi

trim_whitespace() {
    local trimmed="$1"
    # Trim leading whitespace
    trimmed="${trimmed#${trimmed%%[![:space:]]*}}"
    # Trim trailing whitespace
    trimmed="${trimmed%${trimmed##*[![:space:]]}}"
    printf '%s' "$trimmed"
}

PACKAGES_FILE="${ROOT_DIR}/lists/apt-packages"
if [ ! -f "$PACKAGES_FILE" ]; then
    print_line "Packages file not found: $PACKAGES_FILE"
    exit 1
fi

PACKAGES=()
while IFS= read -r line || [ -n "$line" ]; do
    # Remove comments
    line="${line%%#*}"
    line=$(trim_whitespace "$line")
    if [ -n "$line" ]; then
        PACKAGES+=("$line")
    fi
done < "$PACKAGES_FILE"

if [ ${#PACKAGES[@]} -eq 0 ]; then
    print_line "No packages listed in $PACKAGES_FILE"
    exit 0
fi

print_line "Updating apt package index..."
sudo apt-get update

print_line "Installing apt packages..."
for package in "${PACKAGES[@]}"; do
    print_line "Installing $package..."
    if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"; then
        continue
    else
        print_line "Failed to install $package"
    fi
done

LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    print_line "Creating fd compatibility symlink..."
    ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"
fi

if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    print_line "Creating bat compatibility symlink..."
    ln -sf "$(command -v batcat)" "$LOCAL_BIN/bat"
fi

print_line "APT package installation complete!"
