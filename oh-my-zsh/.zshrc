# -*- mode:sh; -*-
###############################################################################
#              __ ___  _           __  __      __ _________  _   _
#             | _/ _ \| |__       |  \/  |_   |_ |__  / ___|| | | |
#             | | | | | '_ \ _____| |\/| | | | | | / /\___ \| |_| |
#             | | |_| | | | |_____| |  | | |_| | |/ /_ ___) |  _  |
#             | |\___/|_| |_|     |_|  |_|\__, | /____|____/|_| |_|
#             |__|                        |___/__|
#
###############################################################################
# Resources:
# - https://github.com/smaximov/zsh-config
#
# You SHOULD have made `~/.zshenv` a symbolic link pointing to
# `$ZDOTDIR/.zshenv` as follow:
#
#           ln -s .config/zsh/.zshenv ~/.zshenv
#
# This ensure all expected environment variable (in particular the ones of
# XDG Base Directory Specification (see https://specifications.freedesktop.org/basedir-spec/latest/)
# are set
###############################################################################

# Path to your oh-my-zsh installation.
export ZSH=$XDG_DATA_HOME/oh-my-zsh

# Custom directory location
ZSH_CUSTOM=$ZDOTDIR/custom

## Update / check ZSH config
# Courtesy https://github.com/smaximov/zsh-config/blob/master/lib/functions.zsh
update-zsh-config() {
	upgrade_oh_my_zsh
}

################## Oh-My-ZSH (optional) customizations ########################
#
# === Oh-My-ZSH Prompt Theme ===
# - Default themes:'$ZSH/themes/*' i.e. ~/.local/share/oh-my-zsh/themes/*
# - Custom themes: '$ZSH_CUSTOM/themes/*' i.e. ~/config/zsh/custom/themes/*

# Specific to powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"
# Customization of powerlevel9k: see custom falkor plugin below
# OR overwrite these settings in $ZDOTDIR/custom.zshrc i.e. ~/config/zsh/custom.zshrc

# update every 7 days by default
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
##############################################################################
#
# === Oh-My-ZSH Plugins ===
plugins=()
# Add them wisely, as too many plugins slow down shell startup.
#___________________
# - Default plugins: '$ZSH/plugins/*' i.e. ~/.local/share/oh-my-zsh/plugins/*
#   See https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
plugins+=(git-flow git-extras git-remote-branch hub)  # Git
plugins+=(rvm rake gem)                  # Ruby stuff
[[ "$(uname)" == "Darwin" ]] && plugins+=(osx)        # Mac OS
# Misc
plugins+=(colored-man-page cp marked2 taskwarrior)
#__________________
# - Custom plugins: '$ZSH_CUSTOM/plugins/*' i.e. ~/config./zsh/custom/plugins/
#
plugins+=(falkor zsh-completions)

#_______________________________________
# [Final] Custom Oh-my-ZSH configuration
# (for instance to change the plugins/themes set by Falkor's dotfiles)
[[ -f $ZDOTDIR/custom.zshrc ]] && source $ZDOTDIR/custom.zshrc
##############################################################################

# Create ZSH cache directory unless it already exists
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

# Disable fancy colored shell prompts and auto-update on dumb terminals
# if [ $TERM = "dumb" ]; then
#    unsetopt zle
#    PS1="$ "
#    DISABLE_AUTO_UPDATE=true
# fi

typeset -U fpath
# Force re-completion
autoload -U compinit && compinit

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load eventually common [custom] configuration, either:
# - generic ZSH functions defined in $ZDOTDIR/lib
# - common to all shells (from ~/.config/shell/[custom/]*.sh typically)
# - specific custom to zsh (from ~/.config/zsh/custom/*.zsh
for d in \
${ZDOTDIR}/lib \
${XDG_CONFIG_HOME}/shell \
${XDG_CONFIG_HOME}/shell/custom \
${ZDOTDIR}/custom
do
  if [ -d "${d}" ]; then
    for f in ${d}/*.(sh|zsh)(N); do
			[[ -r "$f" ]] && source $f
    done
  fi
done

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

typeset -U PATH path
