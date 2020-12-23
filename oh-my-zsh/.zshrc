# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"
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
plugins+=(git-flow git-extras)  # Git
plugins+=(rake gem)                     # Ruby stuff
plugins+=(pyenv pip)                    # Python stuff
plugins+=(docker docker-compose)        # Docker stuff
plugins+=(kubectl minikube)             # Kubernetes stuff
[[ "$(uname)" == "Darwin" ]] && plugins+=(osx)        # Mac OS
# Misc
plugins+=(cp marked2 taskwarrior)
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

# Force re-completion
autoload -U compinit && compinit

if [ -d "$HOME/bin" ]; then
  export PATH="$PATH:$HOME/bin"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

typeset -U PATH path

# Bindkeys - use sudo showkey -a to get sequences 
# Shift-Left / Shift-Right
bindkey "^[[1;2D" backward-word
bindkey "^[[1;2C" forward-word
# Shift-Up / Shift-Down
bindkey "^[[1;2A" beginning-of-line
bindkey "^[[1;2B" end-of-line



# rm -rf ${XDG_CONFIG_HOME}/zsh/.zcompdump*

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/git/github/Falkor/dotfiles/oh-my-zsh/.p10k.zsh.
[[ ! -f ~/git/github/Falkor/dotfiles/oh-my-zsh/.p10k.zsh ]] || source ~/git/github/Falkor/dotfiles/oh-my-zsh/.p10k.zsh
