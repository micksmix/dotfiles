#!/bin/sh
source ./functions/common

# Ask for the administrator password upfront
sudo -v

brew tap homebrew/cask-fonts

# Install long list of packages.
IFS=$'\n'

# Make sure we’re using the latest Homebrew.
brew update

print_line "Installing Homebrew packages."

for i in $(cat ./lists/brew-packages)
do
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$i"
done

print_line "Installing Homebrew cask packages."
for i in $(cat ./lists/brew-cask-packages)
do
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "$i"
done

#print_line "Installing App Store applications."
#cat ../lists/mas-app-ids | xargs mas install
