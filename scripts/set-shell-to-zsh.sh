#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Ask for the administrator password upfront
sudo -v

UNAME=$(uname)
print_line "Setting shell to zsh."

if [ "$UNAME" == "Darwin" ] ; then
    BREW_PREFIX=$(brew --prefix)

    # Set brew-installed zsh as default zsh
    if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
        echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells;
    fi;

    # Set brew-installed bash as default bash
    if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
        echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
    fi;

    # set ZSH as default shell
    chsh -s "${BREW_PREFIX}/bin/zsh";

    # Create iterm2 directory and copy plist
    mkdir -p "$HOME/.iterm2"
    \cp "${ROOT_DIR}/scripts/com.googlecode.iterm2.plist" "$HOME/.iterm2/"

elif [ "$UNAME" == "Linux" ] ; then
    ZSH_PATH=$(which zsh)

    # Set zsh as default shell
    if ! fgrep -q "${ZSH_PATH}" /etc/shells; then
        echo "${ZSH_PATH}" | sudo tee -a /etc/shells;
    fi;

    # set ZSH as default shell
    chsh -s "${ZSH_PATH}";
fi

# Remove existing oh-my-zsh if it exists
if [ -d "$HOME/.oh-my-zsh" ]; then
    rm -rf "$HOME/.oh-my-zsh"
fi

# install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

# Remove existing plugins if they exist
rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"

# plugins and theme
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"

# Copy config files
print_line "Copying configuration files..."
\cp "${ROOT_DIR}/dots/.bash_profile" "$HOME/.profile"
\cp "${ROOT_DIR}/zsh/zshrc" "$HOME/.zshrc"

# Remove existing themes if they exist
rm -f "$HOME/.oh-my-zsh/themes/honukai.zsh-theme"
rm -f "$HOME/.oh-my-zsh/themes/powerlevel9k.zsh-theme"

# Copy themes
\cp "${ROOT_DIR}/init/honukai.zsh-theme" "$HOME/.oh-my-zsh/themes/honukai.zsh-theme"
\cp "${ROOT_DIR}/init/powerlevel9k.zsh-theme" "$HOME/.oh-my-zsh/themes/powerlevel9k.zsh-theme"

