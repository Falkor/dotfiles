#! /bin/bash
################################################################################
#  .bashrc -- my personal Bourne-Again shell (aka bash) configuration  
#             see http://github.com/Falkor/dotfiles
#
#  Copyright (c) 2010 Sebastien Varrette <Sebastien.Varrette@uni.lu>
#                http://varrette.gforge.uni.lu
#                   _               _              
#                  | |__   __ _ ___| |__  _ __ ___ 
#                  | '_ \ / _` / __| '_ \| '__/ __|
#               _  | |_) | (_| \__ \ | | | | | (__ 
#              (_) |_.__/ \__,_|___/_| |_|_|  \___|
#
################################################################################
# This file is NOT part of GNU bash
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################
# Resources: 
#  - http://bitbucket.org/dmpayton/dotfiles/src/tip/.bashrc
#  - http://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc

# Basic variables
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Colored output from ls is nice
export CLICOLOR=1

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# bring in system bashrc
test -r /etc/bashrc &&
      . /etc/bashrc

# shell opts. see bash(1) for details
shopt -s cdspell                 >/dev/null 2>&1
shopt -s extglob                 >/dev/null 2>&1
shopt -s hostcomplete            >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -u mailwarn                >/dev/null 2>&1

# default umask
umask 0022

# ----------------------------------------------------------------------
# LS AND DIRCOLORS
# ----------------------------------------------------------------------

# we always pass these to ls(1)
LS_COMMON="-hBG"

# if the dircolors utility is available, set that up to
dircolors="$(type -P gdircolors dircolors | head -1)"
test -n "$dircolors" && {
    COLORS=/etc/DIR_COLORS
    test -e "/etc/DIR_COLORS.$TERM"   && COLORS="/etc/DIR_COLORS.$TERM"
    test -e "$HOME/.dircolors"        && COLORS="$HOME/.dircolors"
    test ! -e "$COLORS"               && COLORS=
    eval `$dircolors --sh $COLORS`
}
unset dircolors

if [ "$UNAME" = Darwin ]; then   
    # check if you're using gnu core-utils then use --color
    test "`which ls`" = "/opt/local/bin/ls" && {
        LS_COMMON="$LS_COMMON --color"
    }
fi

# setup the main ls alias if we've established common args
test -n "$LS_COMMON" &&
alias ls="command ls $LS_COMMON"

# these use the ls aliases above
alias ll="ls -l"
alias la="ll -a"
alias l.="ls -d .*"

# ----------------------------------------------------------------------
#  ALIASES
# ----------------------------------------------------------------------
# Mandatory aliases to confirm destructive operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'

alias ..='cd ..'
# Color aliases
alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

alias p='pushd'
alias pingg='ping www.google.fr'

# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------
# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# enable en_US locale w/ ISO-8859-15 encodings if not already configured
# : ${LANG:="en_US.ISO-8859-15"}
# : ${LANGUAGE:="en"}
# : ${LC_CTYPE:="en_US.ISO-8859-15"}
# : ${LC_ALL:="en_US.ISO-8859-15"}
# export LANG LANGUAGE LC_CTYPE LC_ALL

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------
# we want the various sbins on the path along with /usr/local/bin
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

# put ~/bin on PATH if you have it
if [ -d "$HOME/bin" ]; then 
    PATH="$PATH:$HOME/bin:."
fi
MANPATH="/usr/share/man:/usr/local/share/man:$MANPATH"

# Old version of PATH: 
#PATH=/sw/bin:/sw/sbin:/Applications/Tools/Emacs.app/Contents/MacOS:/bin:/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/teTeX/bin/powerpc-apple-darwin-current:/usr/X11R6/bin:/usr/local/mysql/bin:$HOME/bin:/opt/local/bin:.

# Avispa settings
export AVISPA_PACKAGE="/usr/local/stow/avispa-1.1"

# === Programming stuff ===
# pkg-config settings
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# C/C++ include
C_INCLUDE_PATH=/usr/local/include
CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}
LIBRARY_PATH=/usr/lib:/usr/local/lib
DYLD_FALLBACK_LIBRARY_PATH=${LIBRARY_PATH}

# ----------------------------------------------------------------------
# MACOS X / DARWIN SPECIFIC
# ----------------------------------------------------------------------
if [ "$UNAME" = Darwin ]; then   
    # Fink paths (see http://www.finkproject.org/), may be set via /sw/bin/pathsetup.sh
    # after install 
    test -x /sw -a ! -L /sw && {
        FINK=/sw

        # adapt the various PATHs
        PATH="$FINK/bin:$FINK/sbin:$PATH"
        MANPATH="$FINK/share/man:$MANPATH"
        PKG_CONFIG_PATH="${FINK}/lib/pkgconfig:$PKG_CONFIG_PATH"
        C_INCLUDE_PATH=${FINK}/include:${C_INCLUDE_PATH}
        LIBRARY_PATH=${FINK}/lib:${LIBRARY_PATH}
    }

    # MacPorts paths
    test -x /opt/local -a ! -L /opt/local && {
        PORTS=/opt/local

        # adapt the various PATHs
        PATH="${PORTS}/bin:${PORTS}/sbin:$PATH"
        MANPATH="${PORTS}/share/man:$MANPATH"
        PKG_CONFIG_PATH="${PORTS}/lib/pkgconfig:$PKG_CONFIG_PATH"
        C_INCLUDE_PATH=${PORTS}/include:${C_INCLUDE_PATH}
        LIBRARY_PATH=:${PORTS}/lib:${LIBRARY_PATH}

        # nice little port alias
        alias port="sudo nice -n +18 ${PORTS}/bin/port"
    }

    # You probably want to install OpenTerminal (see
    # http://homepage.mac.com/thomasw/OpenTerminal/) 
    # Just adapt the path to the OpenTerminal.app here
    OPENTERMINAL="/Applications/Utilities/OpenTerminal.app"
    if [ -d "$OPENTERMINAL" ]; then
        # Nice alias to go to the current folder browsed in Finder
        alias cdf='eval `osascript ${OPENTERMINAL}/Contents/Resources/Scripts/OpenTerminal.scpt `'
    fi

    # setup java environment. puke.
    JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
    ANT_HOME="/Developer/Java/Ant"
    export ANT_HOME JAVA_HOME

    # Alias so as to be able to call easily emacs etc. from terminal
    alias emacs='open -a Emacs.app'
    alias skim='open -a Skim.app'

    # Finalize the Paths
    CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}
    DYLD_FALLBACK_LIBRARY_PATH=${LIBRARY_PATH}
fi

# ----------------------------------------------------------------------
# PAGER / EDITOR
# ----------------------------------------------------------------------

# Default editor
test -n "$(command -v vim)" && EDITOR=vim || EDITOR=nano
export EDITOR

# Default pager ('less' is so much better than 'more'...)
if test -n "$(command -v less)" ; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

# ----------------------------------------------------------------------
# BASH COMPLETION
# ----------------------------------------------------------------------

test -z "$BASH_COMPLETION" && {
    bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
    test -n "$PS1" && test $bmajor -gt 1 && {
        # search for a bash_completion file to source
        for f in /usr/local/etc/bash_completion \
                 /opt/local/etc/bash_completion \
                 /etc/bash_completion
        do
            test -f $f && {
                . $f
                break
            }
        done
    }
    unset bash bmajor bminor
}

# override and disable tilde expansion
_expand() {
    return 0
}

# ----------------------------------------------------------------------
# VERSION CONTROL SYSTEM - CVS, SVN and GIT 
# ----------------------------------------------------------------------
# === CVS ===
export CVS_RSH='ssh'
export CVSROOT=':ext:varrette@achab.imag.fr:/var/lib/cvs'

# === SVN ===
export SVN_EDITOR=$EDITOR

## display the current subversion revision (to be used later in the prompt)
__svn_ps1() {
    if [[ -d ".svn" ]]; then
        printf " (svn:%s)" `svnversion`
    fi
}

# === GIT ===
export GIT_AUTHOR='Sebastien Varrette'
export GIT_AUTHOR_EMAIL='Sebastien.Varrette@uni.lu'
export GIT_COMMITER=$GIT_AUTHOR
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

# render __git_ps1 even better so as to show activity in a git repository
export GIT_PS1_SHOWDIRTYSTATE=1

# GIT bash completion and access to __git_ps1 is set in
# /opt/local/etc/bash_completion: see the BASH COMPLETION section of this file. 
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------
# Previous version:
#PS1='\[\e[36;1m\][\t]\[\e[0m\]:$?: \u@\[\e[4;36m\]\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]\[\e[0;32m\]$(__git_ps1 "(%s)")$(__svn_ps1)\[\e[0m\]> '

# Define some colors to use in the prompt
RESET_COLOR="\[\e[0m\]"
# B&W
WHITE="\[\e[0;37m\]"
GRAY="\[\e[1;30m\]"
BLACK="\[\e[0;30m\]"
# RGB
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
BLUE="\[\e[34;1m\]"
# other
LIGHT_CYAN="\[\e[36;1m\]"
CYAN_UNDERLINE="\[\e[4;36m\]"

# Configure user color and prompt type depending on whoami
if [ "$LOGNAME" = "root" ]; then
    COLOR_USER="${RED}"
    P="#"
else
    COLOR_USER="${WHITE}"
    P=""
fi

# Simple (basic) prompt
__set_simple_prompt() {
    unset PROMPT_COMMAND
    PS1="[\u@\h] \w ${P}> "
}

# most compact version
__set_compact_prompt() {
    unset PROMPT_COMMAND
    PS1="${COLOR_USER}${P}${RESET_COLOR}> "
}

###########
# my prompt; the format is as follows:
#
#    [hh:mm:ss]:$?: username@hostname workingdir(svn/git status)$> 
#    `--------'  ^  `------' `------' `--------'`--------------'
#       cyan     |  root:red   cyan      light     green 
#                |           underline   blue   (absent if not relevant)
#           exit code of 
#        the previous command 
#
# The git/svn status part is quite interesting: if you are in a directory under
# version control, you have the following information in the prompt: 
#   - under GIT: current branch name, followed by a '*' if the repository has
#                uncommitted changes, followed by a '+' if some elements were
#                'git add'ed but not commited. 
#   - under SVN: show (svn:XX[M]) where XX is the current revision number,
#                followed by 'M' if the repository has uncommitted changes
#
__set_my_prompt() {
    PS1="${LIGHT_CYAN}[\t]${RESET_COLOR}:$?: ${COLOR_USER}\u${RESET_COLOR}@${CYAN_UNDERLINE}\h${RESET_COLOR} ${BLUE}\W${RESET_COLOR}${GREEN}\$(__git_ps1 \" (%s)\")\$(__svn_ps1)${RESET_COLOR}${P}> "
}


# --------------------------------------------------------------------
# SSH/GPG AGENT
# --------------------------------------------------------------------
# # ssh-agent initialization - using keychain
# #if [ ! -e "$SSH_AUTH_SOCK" ]; then
# #	eval `ssh-agent` 1>/dev/null;   
# #keychain --clear --noask ~/.ssh/id_dsa
# #. ~/.keychain/${HOSTNAME}-sh

# # gpg-agent initialization
# #if [ ! -e "$GPG_AGENT_INFO" ]; then
# #        eval `gpg-agent --daemon > $HOME/.gpg-agent-info`;
# #	source $HOME/.gpg-agent-info;
# #fi


# --------------------------------------------------------------------
# PATH MANIPULATION FUNCTIONS
# --------------------------------------------------------------------
######
# Usage: pls [<var>]
# List path entries of PATH or environment variable <var>.
###
pls () { eval echo \$${1:-PATH} |tr : '\n'; }

######
# Usage: puniq [<path>] (thanks rtomayko ;) )
# Remove duplicate entries from a PATH style value while retaining
# the original order. Use PATH if no <path> is given.
#
# Example:
#   $ puniq /usr/bin:/usr/local/bin:/usr/bin
#   /usr/bin:/usr/local/bin
###
puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# -------------------------------------------------------------------
# USER SHELL ENVIRONMENT
# -------------------------------------------------------------------
# condense PATH entries
PATH=$(puniq $PATH)
MANPATH=$(puniq $MANPATH)

# CDPATH settings
#export CDPATH=.:~/svn/gforge.uni.lu

# Set the color prompt by default when interactive
if [ -n "$PS1" ]; then 
    __set_my_prompt
fi
export PS1

# MOTD
test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -npsr
    uptime
}

export PKG_CONFIG_PATH
export C_INCLUDE_PATH   CPLUS_INCLUDE_PATH   LIBRARY_PATH   DYLD_FALLBACK_LIBRARY_PATH

# Eventually load you private settings (not exposed here)
test -f ~/.bash_private && 
      . ~/.bash_private


# I hate this ring
#set bell-style visible

