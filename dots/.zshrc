#!/bin/zsh

# Path to your dotfiles
export DOTFILES=~/dotfiles

# Path to your oh-my-zsh installation
export ZSH="${HOME}/.oh-my-zsh"

# Environment settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nano"
export VISUAL="nano"

# ZSH Theme
if [ -f "${ZSH}/themes/honukai.zsh-theme" ]; then
    ZSH_THEME="honukai"
else
    echo "Warning: honukai theme not found, using default theme"
    ZSH_THEME="robbyrussell"
fi

# ZSH Settings
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
# Uncomment the following line if you want to disable marking untracked files under VCS as dirty
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# History settings
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY            # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS        # Do not record an event that was just recorded again.
setopt HIST_FIND_NO_DUPS       # Do not display a previously found event.
setopt HIST_IGNORE_SPACE       # Do not record an event starting with a space.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.

# Plugins
# Check if plugins exist before adding them
declare -A plugins_to_check=(
    ["zsh-autosuggestions"]="${ZSH_CUSTOM:-${ZSH}/custom}/plugins/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="${ZSH_CUSTOM:-${ZSH}/custom}/plugins/zsh-syntax-highlighting"
    ["zsh-completions"]="${ZSH_CUSTOM:-${ZSH}/custom}/plugins/zsh-completions"
)

plugins=()
for plugin name in ${(kv)plugins_to_check}; do
    if [ -d "$name" ]; then
        plugins+=("$plugin")
    else
        echo "Warning: Plugin directory not found: $name"
    fi
done

# Load Oh My Zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "Error: Oh My Zsh not found at $ZSH"
fi

# Load additional configuration files
for config_file in ~/.{path,exports,aliases,functions,extra}; do
    if [ -r "$config_file" ] && [ -f "$config_file" ]; then
        source "$config_file"
    fi
done
unset config_file

# Completion settings
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null) ]; then
    compinit
else
    compinit -C
fi

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Optional: Uncomment to enable tmux auto-start
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux_sessions=$(tmux ls 2>/dev/null)
#     if [ $? -eq 0 ]; then
#         detached_sessions=$(echo "$tmux_sessions" | grep -v attached)
#         if [ -n "$detached_sessions" ]; then
#             exec tmux attach
#         else
#             exec tmux new-session
#         fi
#     else
#         exec tmux new-session
#     fi
# fi

# Optional: Add custom aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Optional: Add custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Load local customizations if they exist
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi