# -*- mode: sh; -*-
#####################################################################################
# Time-stamp: <Mon 2016-02-29 21:42 svarrette>
#   _____     _ _              _        ___  _     __  __       _____    _
#  |  ___|_ _| | | _____  _ __( )___   / _ \| |__ |  \/  |_   _|__  /___| |__
#  | |_ / _` | | |/ / _ \| '__|// __| | | | | '_ \| |\/| | | | | / // __| '_ \
#  |  _| (_| | |   < (_) | |    \__ \ | |_| | | | | |  | | |_| |/ /_\__ \ | | |
#  |_|  \__,_|_|_|\_\___/|_|    |___/  \___/|_| |_|_|  |_|\__, /____|___/_| |_|
#                                                         |___/
#                          ____  _             _
#                         |  _ \| |_   _  __ _(_)_ __
#                         | |_) | | | | |/ _` | | '_ \
#                         |  __/| | |_| | (_| | | | | |
#                         |_|   |_|\__,_|\__, |_|_| |_|
#                                       |___/
#####################################################################################
# .       Copyright (c) 2016 Sebastien Varrette <Sebastien.Varrette@uni.lu>
#
# Personal Custom plugin for Oh My Zsh, mainly designed to host my favorite
# aliases and my theme specialization
#
### Organization
#
# ~/.oh-my-zsh/
#   ├── plugins
#       └── falkor
#           ├── falkor.aliases.local.zsh    # ignored in public release
#           └── Falkor.plugin.zsh
#
### Usage:
#
# In your ~/.zshrc,  add the following
#
#    [...]
#    plugins=(...) # Whatever default plugins you wish to use
#    # Custom plugins
#    plugins+=(falkor)

#####################################################################################

# =========================================
# ================ Color theme ============
# =========================================
#
# Customization of the https://github.com/bhilburn/powerlevel9k
#
# To use this theme, add 'ZSH_THEME="powerlevel9k/powerlevel9k"' in ~/.zshrc
# Font taken from https://github.com/stefano-meschiari/dotemacs/blob/master/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf
#
POWERLEVEL9K_MODE='awesome-patched'

# Disable dir/git icons
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

DISABLE_AUTO_TITLE="true"

POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
#POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs virtualenv rbenv rvm time)

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %d.%m.%y}"

#POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='orange'
POWERLEVEL9K_STATUS_VERBOSE=false
export DEFAULT_USER="$USER"


# ===================================================================
# ================== Falkor's Command Aliases =======================
# ===================================================================

# -------------------------------------------------------------------
# make some commands (potentially) less destructive
# -------------------------------------------------------------------
alias rm='rm -i'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias g='git'
alias ga='git add'
alias gb='git branch -a'
# stop bother me with merge messages
gbnoedit() {
    git config branch.$(git rev-parse --abbrev-ref HEAD).mergeoptions --no-edit
}
alias gc='git checkout'
alias gcount='git shortlog -sn'
if [[ -n ${ZSH_VERSION-} ]]; then
    compdef gcount=git
fi
alias gcl='git clone'
alias gd='git diff'
alias dg='git diff'
alias GD='git diff HEAD~1 HEAD'
alias gg="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --max-count=20"
alias ggl="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gl='git log --graph --oneline --decorate --max-count=20'
gm() {
    git commit -s -m "$*"
}
gma() {
    git commit -s -am "$*"
}
alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
[[ -n ${ZSH_VERSION-} ]] && compdef _git gpoat=git-push
alias gr='git remote -v'
alias gra='git remote add'
alias grr='git remote rm'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias s='git status'
alias gs='git status'
alias gss='git status --short'
function gsa() {
    local url=$1
    local dir=`basename $url .git`
    [ $# -eq 2 ] && dir=$2
    echo "=> adding git submodule from '$url' in '$dir'"
    git submodule add $url $dir
    git commit -s -m "Add '$dir' as git submodule from '$url'" .gitmodules $dir
}
#alias gsa='git submodule add'
alias gsi='git submodule init'
alias gsu='git submodule update'
gsupgrade() {
    git submodule foreach 'git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
}
alias up='git pull'
alias gu='git pull'
alias gta='git tag -a -m'

# ------------
# Utilities
# ------------
alias o='open'
alias mkdir='mkdir -p'
# Search for files and page it
search() {
    find . -iname "*$@*" | less;
}

alias sshx='ssh -C -X -c blowfish'
alias proxy='ssh -C -q -T -n -N -D 1080'

mkcd () {
    mkdir -p "$@" && cd "$@"
}
alias diff='git diff'  # for colors
alias draw='figlet -c -w 80'
# Which directory is hiding all the bytes?
alias dux='du -h -d 1 | sort -n'
# Ask more gently to run the last command ;)
alias pls='sudo `fc -n -l -1`'
alias ":q"="exit"

# ---------------------------------------------
# United Colors of Benetton: Colors everywhere
# ---------------------------------------------

# Less with syntax color -
alias lessh='LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s" less -M '
# man with colors -- thanks @hcartiaux for the tip
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

# TaskWarrior
alias t='task'

# ---------------
# Emacs business
# ---------------

alias emacs="$HOME/Applications/Emacs.app/Contents/MacOS/Emacs"
alias es="emacs --daemon"
alias em="emacsclient -nw --alternate-editor='vim'"

# ---------------
# ZSH management
# ---------------
alias zshrc="$EDITOR ~/.zshrc" # Quick access to the ~/.zshrc file
alias sourcezshrc="source ~/.zshrc"
alias zshfalkor="$EDITOR ~/.oh-my-zsh/custom/plugins/falkor/falkor.plugin.zsh" # Quick access to this file

#--------------
# Global alias
# -------------
if [[ -n ${ZSH_VERSION-} ]]; then
    alias -g L="| less" # Write L after a command to page through the output.
    alias -g H="| head -n 20" # Write L after a command to get the 20 first lines
    alias -g G='| grep --color -i' # Write G after the command to grep it
    alias -g TL='| tail -20'
    alias -g NUL="> /dev/null 2>&1" # You get the idea.
fi
