#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

print_line "Copying default settings files..."

# Create a backup of existing dotfiles
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
print_line "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# add aliases for dotfiles
find "${ROOT_DIR}/dots" -name ".*" \
    -not -name ".gitignore" \
    -not -name ".travis.yml" \
    -not -name ".git" \
    -not -name ".github" \
    -not -name ".*.swp" \
    -not -name ".gnupg" | while read -r file; do
    f=$(basename "$file")
    
    # Backup existing file if it exists
    if [ -f "$HOME/$f" ]; then
        print_line "Backing up existing $f"
        cp "$HOME/$f" "$BACKUP_DIR/"
    fi
    
    print_line "Copying $f to home directory"
    \cp "$file" "$HOME/$f"
done

# Create .iterm2 directory if it doesn't exist
print_line "Setting up iTerm2 configuration..."
mkdir -p "$HOME/.iterm2"

# Copy iTerm2 preferences
ITERM2_PLIST="${ROOT_DIR}/scripts/com.googlecode.iterm2.plist"
if [ -f "$ITERM2_PLIST" ]; then
    print_line "Copying iTerm2 preferences"
    \cp "$ITERM2_PLIST" "$HOME/.iterm2/"
else
    print_line "Warning: iTerm2 preferences file not found at $ITERM2_PLIST"
fi

print_line "Dotfiles installation complete!"
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR")" ]; then
    print_line "Your original dotfiles were backed up to $BACKUP_DIR"
fi
# #!/bin/sh
# source ./functions/common

# print_line "Copying default settings files..."

# # add aliases for dotfiles
# for file in $(find ./dots/ -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".github" -not -name ".*.swp" -not -name ".gnupg"); do
#     f=$(basename $file)
#     #ln -sfn $file $HOME/$f
#     \cp "$file" "$HOME/$f"
# done

# mkdir -p "$HOME/.iterm2"
# \cp "$CURDIR/scripts/com.googlecode.iterm2.plist" "$HOME/.iterm2"

# #ln -snf $CURDIR/.bash_profile $HOME/.profile; \
# #ln -snf $CURDIR/zsh/zshrc $HOME/.zshrc;
