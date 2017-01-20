#! /bin/bash
################################################################################
#  .bashrc -- my personal Bourne-Again shell (aka bash) configuration
#             see https://github.com/Falkor/dotfiles
#
#  Copyright (c) 2010 Sebastien Varrette <Sebastien.Varrette@uni.lu>
#                https://varrette.gforge.uni.lu
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
#  - https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Basic variables
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}
: ${BASH_CONFIG_DIR=$HOME/.bash.d}
# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# readline config
: ${INPUTRC=~/.inputrc}

# Get rid of mail notification
unset MAILCHECK

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------
# bring in system bashrc
test -r /etc/bashrc &&
    . /etc/bashrc

# shell opts. see bash(1) for details
shopt -s cdspell                 >/dev/null 2>&1  # correct minor errors in the spelling
# of a directory in a cd command
shopt -s extglob                 >/dev/null 2>&1  # extended pattern matching
shopt -s hostcomplete            >/dev/null 2>&1  # perform hostname completion
# on '@'
#shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -u mailwarn                >/dev/null 2>&1

# default umask
umask 0022

# ----------------------------------------------------------------------
# LS WITH COLORS
# ----------------------------------------------------------------------
#for *BSD/darwin
export CLICOLOR=1

# we always pass these to ls(1)
LS_COMMON="-hB"

ls --color=auto &> /dev/null && LS_COMMON="${LS_COMMON} --color=auto" || true

alias ls="command ls ${LS_COMMON}"

# ----------------------------------------------------------------------
#  ALIASES
# ----------------------------------------------------------------------
# these use the ls aliases above
alias ll="ls -l"
alias la="ll -a"
alias l.="ls -d .*"
# Mandatory aliases to confirm destructive operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'

alias ..='cd ..'

# Color aliases
alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

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

# enable en_US locale w/ UTF-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_ALL:="C"}
export LANG LANGUAGE LC_ALL

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------
pathadd() {
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$1($|:)" ; then
        [ "$2" = "after" ] && PATH="$PATH:${1%/}" || PATH="${1%/}:$PATH"
    fi
}
pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}
# Complete default PATH eventually
for bindir in /usr/local/bin $HOME/bin; do
    pathadd ${bindir}
done
pathadd $HOME/.rvm/bin after

manpathadd() {
    if [ -d "$1" ] && ! echo $MANPATH | grep -E -q "(^|:)$1($|:)" ; then
        [ "$2" = "after" ] && MANPATH="$MANPATH:${1%/}" || MANPATH="${1%/}:$PATH"
    fi
}
# Complete default MANPATH eventually
for mandir in /usr/local/share/man $HOME/share/man; do
    manpathadd ${mandir}
done

# ----------------------------------------------------------------------
# MACOS X / DARWIN SPECIFIC
# ----------------------------------------------------------------------
if [ "${UNAME}" = "Darwin" ]; then
    test -x "/usr/libexec/java_home" &&
        export JAVE_HOME=$(/usr/libexec/java_home)
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
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    test -n "$(command -v brew)" && BREW_BASH_COMPLETION="$(brew --prefix)/etc/bash_completion" ||  BREW_BASH_COMPLETION=""
    for f in /usr/share/bash-completion/bash_completion \
                 /etc/bash_completion ${BREW_BASH_COMPLETION} \
                 /opt/local/etc/bash_completion
    do
        if [ -r "$f" ]; then
            . $f
            break
        fi
    done
fi

# ----------------------------------------------------------------------
# OAR Batch scheduler
# ----------------------------------------------------------------------
# Resources:
# - http://wiki-oar.imag.fr/index.php/Customization_tips
# - http://wiki-oar.imag.fr/index.php/Oarsh_and_bash_completion

# oarsh completion
function _oarsh_complete_()
{
    local word=${COMP_WORDS[COMP_CWORD]}
    local list
    list=$(uniq "$OAR_NODEFILE" | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$list" -- "${word}"))
}
complete -F _oarsh_complete_ oarsh

# Job + Remaining time
__oar_ps1_remaining_time(){
    if [ -n "$OAR_JOB_WALLTIME_SECONDS" -a -n "$OAR_NODE_FILE" -a -r "$OAR_NODE_FILE" ]; then
        DATE_NOW=$(date +%s)
        DATE_JOB_START=$(stat -c %Y "$OAR_NODE_FILE")
        DATE_TMP=$OAR_JOB_WALLTIME_SECONDS
        ((DATE_TMP = (DATE_TMP - DATE_NOW + DATE_JOB_START) / 60))
        echo -n "[OAR$OAR_JOB_ID->$DATE_TMP]"
    fi
}

# OAR motd
test -n "$INTERACTIVE" && test -n "$OAR_NODE_FILE" && (
        echo "[OAR] OAR_JOB_ID=$OAR_JOB_ID"
        echo "[OAR] Your nodes are:"
        sort "$OAR_NODE_FILE" | uniq -c | awk '{printf("      %s*%d\n",$2,$1)}END{printf("\n")}' | sed -e 's/,$//'
    )


# ----------------------------------------------------------------------
# BASH HISTORY
# ----------------------------------------------------------------------
# Increase the history size
HISTSIZE=10000
HISTFILESIZE=20000

# Add date and time to the history
HISTTIMEFORMAT="[%d/%m/%Y %H:%M:%S] "

# ----------------------------------------------------------------------
# VERSION CONTROL SYSTEM - CVS, SVN and GIT
# ----------------------------------------------------------------------
# === CVS ===
export CVS_RSH='ssh'

# === SVN ===
export SVN_EDITOR=$EDITOR

# Some code from https://github.com/nojhan/liquidprompt
_LP_OPEN_ESC="\["
_LP_CLOSE_ESC="\]"
ti_sgr0="$( { tput sgr0 || tput me ; } 2>/dev/null )"
LP_COLOR_UP=${LP_COLOR_UP:-$GREEN}
LP_COLOR_CHANGES=${LP_COLOR_CHANGES:-$RED}
LP_COLOR_DIFF=${LP_COLOR_DIFF:-$PURPLE}
NO_COL="${_LP_OPEN_ESC}${ti_sgr0}${_LP_CLOSE_ESC}"

# Escape the given strings
# Must be used for all strings injected in PS1 that may comes from remote sources,
# like $PWD, VCS branch names...
_lp_escape() {
    echo -nE "${1//\\/\\\\}"
}
# Get the branch name of the current directory
# For the first level of the repository, gives the repository name
_lp_svn_branch()
{
    local root=
    local url=
    eval "$(LANG=C LC_ALL=C svn info 2>/dev/null | sed -n 's/^URL: \(.*\)/url="\1"/p;s/^Repository Root: \(.*\)/root="\1"/p' )"
    [[ -z "${root-}" ]] && return

    # Make url relative to root
    url="${url:${#root}}"
    if [[ "$url" == */trunk* ]]; then
        echo -n trunk
    elif [[ "$url" == */branches/?* ]]; then
        url="${url##*/branches/}"
        _lp_escape "${url%/*}"
    elif [[ "$url" == */tags/?* ]]; then
        url="${url##*/tags/}"
        _lp_escape "${url%/*}"
    else
        _lp_escape "${root##*/}"
    fi
}
# Set a color depending on the branch state:
# - green if the repository is clean
#   (use $LP_SVN_STATUS_OPTIONS to define what that means with
#    the --depth option of 'svn status')
# - red if there is changes to commit
# Note that, due to subversion way of managing changes,
# informations are only displayed for the CURRENT directory.
_lp_svn_branch_color()
{
    (( LP_ENABLE_SVN )) || return

    local branch
    branch="$(_lp_svn_branch)"
    if [[ -n "$branch" ]]; then
        local changes
        changes=$(( $(svn status | \grep -c -v "?") ))
        if (( changes == 0 )); then
            echo -nE "${LP_COLOR_UP}${branch}${NO_COL}"
        else
            echo -nE "${LP_COLOR_CHANGES}${branch}${NO_COL}(${LP_COLOR_DIFF}$changes${NO_COL})" # changes to commit
        fi
    fi
}

## display the current subversion revision (to be used later in the prompt)
__svn_ps1() {
    (
        local svnversion
        svnversion=$(svnversion | sed -e "s/[:M]//g")
        # Continue if $svnversion is numerical
        let $svnversion
        if [[ "$?" -eq "0" ]]
        then
            printf " (%s:%s)" "$(_lp_svn_branch_color)" "$(svnversion)"
        fi
    ) 2>/dev/null
}

# === GIT ===
# render __git_ps1 even better so as to show activity in a git repository
#
# see https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh for
# configuration info of the GIT_PS1* variables
#
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto legacy"

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}
# GIT bash completion and access to __git_ps1 is set in
if ! type __git_ps1 &>/dev/null
then
    # Try to load separately the file git-prompt
    for f in \
        /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh \
            /etc/bash-completion.d/git-prompt \
            /usr/share/git/completion/git-prompt.sh \
            /usr/lib/git-core/git-sh-prompt
    do
        if [ -r "$f" ]; then
            . $f
            break
        fi
    done
fi

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------
# Previous version:
#PS1='\[\e[36;1m\][\t]\[\e[0m\]:$?: \u@\[\e[4;36m\]\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]\[\e[0;32m\]$(__git_ps1 "(%s)")$(__svn_ps1)\[\e[0m\]> '

# Define some colors to use in the prompt
RESET_COLOR="\[\e[0m\]"
BOLD_COLOR="\[\e[1m\]"
# B&W
WHITE="\[\e[0;37m\]"
GRAY="\[\e[1;30m\]"
BLACK="\[\e[0;30m\]"
# RGB
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
BLUE="\[\e[34;1m\]"
# other
YELLOW="\[\e[0;33m\]"
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

# Configure a set of useful variables for the prompt
if [[ "$(echo $UNAME | grep -c -i -e '^.*bsd$')" == "1" ]] ; then
    DOMAIN=$(hostname | cut -d '.' -f 2)
else
    DOMAIN=$(hostname -f | cut -d '.' -f 2)
fi

# get virtualization information
XENTYPE=""
if [ -f "/sys/hypervisor/uuid" ]; then
    if [ "$(</sys/hypervisor/uuid)" == "00000000-0000-0000-0000-000000000000" ]; then
        XENTYPE=",Dom0"
    else
        XENTYPE=",DomU"
    fi
fi
# Test the PS1_EXTRA variable
if [ -z "${PS1_EXTRA}" -a -f "/proc/cmdline" ]; then
    # Here PS1_EXTRA is not set and/or empty, check additionally if it has not
    # been set via kernel comment
    kernel_ps1_extra="$(grep PS1_EXTRA /proc/cmdline)"
    if [ -n "${kernel_ps1_extra}" ]; then
        PS1_EXTRA=$( sed -e "s/.*PS1_EXTRA=\"\?\([^ ^\t^\"]\+\)\"\?.*/\1/g" /proc/cmdline )
    fi
fi
PS1_EXTRAINFO="${BOLD_COLOR}${DOMAIN}${XENTYPE}${RESET_COLOR}"
if [ -n "${PS1_EXTRA}" ]; then
    PS1_EXTRAINFO="${PS1_EXTRAINFO},${YELLOW}${PS1_EXTRA}${RESET_COLOR}"
fi


# # Bash support for ZSH-like 'preexec' and 'precmd' functions.
# # See http://www.twistedmatrix.com/users/glyph/preexec.bash.txt
# test -r ~/.dotfiles.github.d/bash/preexec.bash &&
# . ~/.dotfiles.github.d/bash/preexec.bash

# set_xterm_title () {
#     local title="$1"
#     echo -ne "\e]0;$title\007"
# }

# precmd () {
#     set_xterm_title "${TERM} - ${USER}@${HOSTNAME} `dirs -0` $PROMPTCHAR"
# }

# preexec () {
#     set_xterm_title "${TERM} - $1 {`dirs -0`} (${USER}@${HOSTNAME})"
# }

# This function is called from a subshell in $PS1, to provide the colorized
# exit status of the last run command.
# Exit status 130 is also considered as good as it corresponds to a CTRL-D
__colorized_exit_status() {
    printf -- "\$(status=\$? ; if [[ \$status = 0 || \$status = 130  ]]; then \
                                echo -e '\[\e[01;32m\]'\$status;              \
                              else                                            \
                                echo -e '\[\e[01;31m\]'\$status; fi)"
}

# Simple (basic) prompt
__set_simple_prompt() {
    unset PROMPT_COMMAND
    PS1="[\u@\h] \w(${DOMAIN}) ${P}> "
}

# most compact version
__set_compact_prompt() {
    unset PROMPT_COMMAND
    PS1="${COLOR_USER}${P}${RESET_COLOR}> "
}

###########
# my prompt; the format is as follows:
#
#    [hh:mm:ss]:$?: username@hostname(domain[,xentype][,extrainfo]) workingdir(svn/git status)$>
#    `--------'  ^  `------' `------'         `--------'`--------------'
#       cyan     |  root:red   cyan              light     green
#                |           underline            blue   (absent if not relevant)
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
# `domain` reflect the current domain of the machine that run the prompt
# (guessed from hostname -f)
# `xentype` is DOM0 or domU depending if the machine is a Xen dom0 or domU
# Finally, is the environment variable PS1_EXTRA is set (or passed to the
# kernel), then its content is displayed here.
#
# This prompt is perfect for terminal with black background, in my case the
# Vizor color set (see http://visor.binaryage.com/) or iTerm2
__set_my_prompt() {
    PS1="$(__colorized_exit_status) ${LIGHT_CYAN}[\t]${RESET_COLOR} ${COLOR_USER}\u${RESET_COLOR}@${CYAN_UNDERLINE}\h${RESET_COLOR}(${PS1_EXTRAINFO}) ${BLUE}\W${RESET_COLOR}${GREEN}\$(__git_ps1 \" (%s)\")\$(__svn_ps1)${RESET_COLOR}${P}> "
}
# TODO: define the same for white background.


# --------------------------------------------------------------------
# SSH/GPG AGENT
# --------------------------------------------------------------------
# # ssh-agent initialization - using keychain
# #if [ ! -e "$SSH_AUTH_SOCK" ]; then
# # eval `ssh-agent` 1>/dev/null;
# #keychain --clear --noask ~/.ssh/id_dsa
# #. ~/.keychain/${HOSTNAME}-sh

# # gpg-agent initialization
# #if [ ! -e "$GPG_AGENT_INFO" ]; then
# #        eval `gpg-agent --daemon > $HOME/.gpg-agent-info`;
# # source $HOME/.gpg-agent-info;
# #fi


######
# Remove duplicate entries from a PATH style value while retaining
# the original order. Use PATH if no <path> is given.
# Usage: puniq [<path>]
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


# Customizations
for f in \
    ~/.bash_aliases \
    ~/.bash_private
do
    if [ -r "$f" ]; then
        . $f
    fi
done

# Load Eventually custom local configs
if [ -d "${BASH_CONFIG_DIR}" ]; then
    for f in ${BASH_CONFIG_DIR}/*.sh
    do
        if [ -r "$f" ]; then
            . $f
        fi
    done
fi

# RVM specific (see http://beginrescueend.com/)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# condense PATH entries
PATH="$(puniq "$PATH")"
MANPATH="$(puniq "$MANPATH")"
export PATH MANPATH

# I hate this ring
#set bell-style visible
