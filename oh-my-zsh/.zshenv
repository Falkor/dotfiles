# -*- mode: sh; -*-
###############################################################################
# .zshenv -- My ZSH configuration (feat. Oh-my-zsh)
# .          see https://github.com/Falkor/dotfiles
#                                  _
#                          _______| |__   ___ _ ____   __
#                         |_  / __| '_ \ / _ \ '_ \ \ / /
#                        _ / /\__ \ | | |  __/ | | \ V /
#                       (_)___|___/_| |_|\___|_| |_|\_/
#
###############################################################################
# Resources:
# - https://github.com/smaximov/zsh-config
#
# The proposed ZSH startup files are read the the below order:
# (see http://zsh.sourceforge.net/Guide/zshguide02.html)
#
# 1. `~/.zshenv` :         Usually run for every zsh
# 2. `$ZDOTDIR/.zprofile`: Run for login shells
# 3. `$ZDOTDIR/.zshrc`:    Run for interactive shells.`
# 4. `$ZDOTDIR/.zlogin`:   Run for login shells (**after** .zshrc)
#
# In particular, assuming Falkor's dotfiles zsh repository are available under
# ~/.config/zsh/, it should be sufficient to ake `~/.zshenv` a symbolic link
# pointing to `$ZDOTDIR/.zshenv` (as this file sets $ZDOTDIR)
#
#      ln -s .config/zsh/.zshenv ~/.zshenv
#
# === OVERVIEW ===
# This configuration enforces:
# - `XDG_*` variables are set according to XDG Base Directory Specification
#  (see https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):
#     * `XDG_CONFIG_HOME`: `~/.config`
#     * `XDG_DATA_HOME`:   `~/.local/share`
#     * `XDG_CACHE_HOME`:  `~/.cache`
# - Some additional variables are set:
#     * `ZDOTDIR`:       `$XDG_CONFIG_HOME/zsh`
#     * `ZSH`:           `$XDG_DATA_HOME/oh-my-zsh`
#     * `ZSH_CACHE_DIR`: `$XDG_CACHE_HOME/zsh`
# - ZSH config files located under `$ZDOTDIR`.
# - Oh My Zsh files located under `$ZSH`.
###############################################################################

# XDG  Base Directory Specification
# See https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# enable en_US locale w/ UTF-8 encodings if not already configured
export LANG=en_US.UTF-8
export LANGUAGE=en
export LC_ALL="${LANG}"

# Editor / pager
unset ALTERNATE_EDITOR
# Preferred editor for local and remote sessions
test -n "$(command -v vim)" && EDITOR=vim || EDITOR=nano
# Uncomment if you prefer macvim
# [[ -n $SSH_CONNECTION ]] && EDITOR='mvim'
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

# ====== ZSH Specific variables =========
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
# Store ZSH files under XDG_CONFIG_HOME base directory.
# This works by symlinking ~/.zshenv to ~/.config/zsh/.zshenv (this file).
export HISTFILE=$ZSH_CACHE_DIR/zhistory

#================================================================
# [Final] Custom ZSH enviroment variables
[[ -f $ZDOTDIR/custom.zshenv ]] && source $ZDOTDIR/custom.zshenv
#================================================================

# $HOME, sweet $HOME
export PATH

# === Now ${ZDOTDIR}/.zshrc will be loaded.... ===
