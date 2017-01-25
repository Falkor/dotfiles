# -*- mode: sh; -*-

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

unset ALTERNATE_EDITOR
test -n "$(command -v vim)" && EDITOR=vim || EDITOR=nano
export EDITOR
#export EDITOR='emacsclient -t'
if test -n "$(command -v less)" ; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER
export VISUAL=$EDITOR

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib


# Node
# path+=($XDG_CACHE_HOME/npm/bin)

# Custom enviroment variables
[[ -f $ZDOTDIR/custom.zshenv ]] && source $ZDOTDIR/custom.zshenv

# $HOME, sweet $HOME
export PATH

# export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config

export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
export HISTFILE=$ZSH_CACHE_DIR/zhistory

# Store ZSH files under XDG_CONFIG_HOME base directory.
# This works by symlinking ~/.zshenv to ~/.config/zsh/.zshenv (this file).
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
