#!/bin/sh
source ./functions/common

print_line "Copying default settings files..."

# add aliases for dotfiles
for file in $(find ./dots/ -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".github" -not -name ".*.swp" -not -name ".gnupg"); do
    f=$(basename $file)
    #ln -sfn $file $HOME/$f
    \cp "$file" "$HOME/$f"
done

mkdir -p "$HOME/.iterm2"
\cp "$CURDIR/scripts/com.googlecode.iterm2.plist" "$HOME/.iterm2"

#ln -snf $CURDIR/.bash_profile $HOME/.profile; \
#ln -snf $CURDIR/zsh/zshrc $HOME/.zshrc;
