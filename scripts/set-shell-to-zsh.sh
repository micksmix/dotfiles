#!/bin/sh
source ./functions/common

# Ask for the administrator password upfront
sudo -v

BREW_PREFIX=$(brew --prefix)
print_line "Setting shell to zsh."

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

# install oh-my-zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh

# plugins and theme
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions

# link zshrc file
\cp "$CURDIR/dots/.bash_profile" "$HOME/.profile"
\cp "$CURDIR/zsh/zshrc" "$HOME/.zshrc"
rm -rf "$HOME/.oh-my-zsh/themes/honukai.zsh-theme"
rm -rf "$HOME/.oh-my-zsh/themes/powerlevel9k.zsh-theme"
\cp "$CURDIR/init/honukai.zsh-theme" "$HOME/.oh-my-zsh/themes/honukai.zsh-theme"
\cp "$CURDIR/init/powerlevel9k.zsh-theme" "$HOME/.oh-my-zsh/themes/powerlevel9k.zsh-theme"
