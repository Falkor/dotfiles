# -*- mode: sh; -*-
#####################################################################################
# Time-stamp: <Sat 2025-10-18 09:52 svarrette>
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
# .       Copyright (c) 2016-2025 Sebastien Varrette <Sebastien.Varrette@gmail.com>
#
# Personal Custom plugin for Oh My Zsh, mainly designed to host my favorite
# aliases and my theme specialization
# Install nerd-font (see https://github.com/ryanoasis/nerd-fonts#font-installation)
# On Mac OS X:
#     brew tap caskroom/fonts
#     brew cask install font-hack-nerd-font
# Then in iTerm2, change the font for non-ASCII Font to 14pt Hack Regular Nerd Font Complete
#
### Organization
#
# ~/.config/zsh/custom
#   ├── plugins
#       └── falkor
#           └── falkor.plugin.zsh
#
### Usage:
#
# In your .zshrc,  add the following
#
#    [...]
#    plugins=(...) # Whatever default plugins you wish to use
#    # Custom plugins
#    plugins+=(falkor)

#####################################################################################

export DEFAULT_USER="$USER"

# ===================================================================
# ================== Falkor's Command Aliases =======================
# ===================================================================

# -------------------------------------------------------------------
# make some commands (potentially) less destructive
# -------------------------------------------------------------------
alias rm='rm -i'

# ls, the common ones I use a lot shortened for rapid fire usage
#alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# fuzzy typing
alias car='cat'

# -------------------------------------------------------------------
# Git -- most comes from the git plugin
# -------------------------------------------------------------------
alias g='git'
alias ga='git add'
alias gb='git branch -a'
# age of each branch
alias gbage='for k in `git branch -a | perl -pe '\''s/^..(.*?)( ->.*)?$/\1/'\''`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r'
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
alias clone='git clone'
alias gd='git diff'
alias dg='git diff'
alias GD='git diff HEAD~1 HEAD'
alias gf='git fetch -va'
alias gfp='git fetch -va --prune'
alias gg="git log  --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --max-count=20"
alias ggl="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gl='git log  --graph --oneline --decorate --max-count=20'
gm() {
    git commit -s -m "$*"
}
gma() {
    git commit -s -am "$*"
}
gms() {
    git commit -s -S -m "$*"
}
gmas() {
    git commit -s -S -am "$*"
}
# Conventional commit helpers -- see https://www.conventionalcommits.org/
__git-conventional-commit() {
  local type="$1"
  local scope="$2"
  shift 2
  if [ -z "$*" ]; then
    echo "${type}: ${scope}"
  else
    echo "${type}(${scope}): $*"
  fi
}
feat-gm()     { gm  "$(__git-conventional-commit 'feat'     $*)" }
feat-gma()		{ gma "$(__git-conventional-commit 'feat'		  $*)" }
fit-gm()			{ gm	"$(__git-conventional-commit 'fix'			$*)" }
fit-gma()			{ gma "$(__git-conventional-commit 'fix'			$*)" }
refactor-gm() { gm  "$(__git-conventional-commit 'refactor' $*)" }
refactor-gma(){ gma "$(__git-conventional-commit 'refactor' $*)" }
docs-gm()			{ gm  "$(__git-conventional-commit 'docs'		  $*)" }
docs-gma()		{ gma "$(__git-conventional-commit 'docs'		  $*)" }
# perf
# revert
# style
# test

alias p='git push'
alias gp='git push'
alias gpu='git push'
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
	[ -d ".submodules" ] && dir=".submodules/$dir"
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
alias u='git pull'
alias up='git pull'
alias gu='git pull'
alias gta='git tag -a -m'
alias cdroot='git rev-parse && cd ./$(git rev-parse --show-cdup)'

#-------
# Myrepo
#--------
alias mradd='mr register'
alias mrup='(cd ~; mr -j update)'

# ------------
# Utilities
# ------------
bup() {
  echo "Updating your [Homebrew] system"
  brew update
  brew upgrade
  brew cu
  brew cleanup
}
alias o='open'
alias of='lsof -nP +c 15 | grep LISTEN'
alias m='make -j8'
alias skim='open -a Skim'
nospace-in-filename(){
  local f="$*"
  echo "=> replacing ' ' (space) with '-' in '${f}'"
  mv $f $(echo $f| tr ' ' '-')
}
if [[ -n ${ZSH_VERSION-}  ]]; then
	zstyle ":completion:*:*:skim:*" file-patterns "*.pdf *(-/)"
  zcompclean() {
    rm -rf ${XDG_CONFIG_HOME}/zsh/.zcompdump*
    autoload -U compinit && compinit
  }
  # https://stackoverflow.com/questions/59940971/zsh-autocomplete-slow-for-ssh/64147638#64147638
  # FIX for slow SSH completion
  refresh_ssh_autocomplete () {
    host_list=($(cat ~/.ssh/config | grep 'Host '  | awk '{s = s $2 " "} END {print s}'))
    zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list
  }
fi
alias mkdir='mkdir -p'
# Search for files and page it
search() {
    find . -iname "*$@*" | less;
}

if [[ -n ${ZSH_VERSION-}  ]]; then
  alias refresh='sourcezshrc'
else
  alias refresh='source ~/.profile'
fi



alias sshx='ssh -C -X -c blowfish'
alias proxy='ssh -C -q -T -n -N -D 1080'
alias rsyncfalkor='rsync -P -avzu'

alias nothankyouadobe="sudo -H killall ACCFinderSync \"Core Sync\" AdobeCRDaemon \"Adobe Creative\" AdobeIPCBroker node \"Adobe Desktop Service\" \"Adobe Crash Reporter\";sudo -H rm -rf \"/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist\" \"/Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist\" \"/Library/LaunchDaemons/com.adobe.*.plist\""
topgrep() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: topgrep <expression>"
  else
    top -pid $(pgrep $1)
  fi
}

mkcd () {
    mkdir -p "$@" && cd "$@"
}
#alias diff='colordiff'  # for colors
alias draw='figlet -c -w 80'
# Which directory is hiding all the bytes?
alias dux='du -h -d 1 | sort -n'
# Ask more gently to run the last command ;)
alias pls='sudo `fc -n -l -1`'
alias ":q"="exit"

# Quick tarball backup
backup() {
  [[ -z "$1" ]] && return
  local dst=$(echo $1 | sed "s/^\./dot/" )
  local archive="backup_$(date +%F)_${dst}.tgz"
  echo "=> creating tarball archive '${archive}' to backup '$@'"
  tar cvzf ${archive} $@
}

# Optimize PDF/JPEG/PNG size
optipdf () {
	local pdf=$1
	local res=`basename $pdf .pdf`-optimized.pdf
	noglob gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -sOutputFile=$res $pdf
	local opti_size=`du -k $res | cut -f1`
	local size=`du -k $pdf | cut -f1`
	if [[ "$opti_size" -lt "$size"  ]]; then
		echo " => optimized PDF of smaller size ($opti_size vs. $size) thus overwrite $pdf"
		mv $res $pdf
		git commit -s -m "reduce size of PDF '$pdf'" $pdf
	else
		echo " => already optimized PDF thus discarded"
		rm -f $res
	fi
}
alias reducepdf='optipdf'
if [[ -n ${ZSH_VERSION-}   ]]; then
	compdef '_files -g "*.pdf"' optipdf
fi
alias optipng='optipng -o9 -zm1-9 -strip all'
alias optijpg='jpegoptim'

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
#alias es="emacs --daemon"
#alias em="emacsclient -nw --alternate-editor='vim'"

# ---------------
# iTerm2 business
# ---------------

# Setup tab and window title functions for iterm2
# iterm behaviour: until window name is explicitly set, it'll always track tab title.
# So, to have different window and tab titles, iterm_window() must be called
# first. iterm_both() resets this behaviour and has window track tab title again).
# Source: http://superuser.com/a/344397
set_iterm_name() {
  mode=$1; shift
  echo -ne "\033]$mode;$@\007"
}
iterm_both()   { set_iterm_name 0 $@; }
iterm_tab()    { set_iterm_name 1 $@; }
title()        { iterm_both $@;       }
iterm_window() { set_iterm_name 2 $@; }

# GPG management
gpg-update-tty() {
  export GPG_TTY=$(tty)
  gpg-connect-agent "updatestartuptty" /bye >/dev/null
}

# -------------------
# Yubikey management
# -------------------
# https://github.com/drduh/YubiKey-Guide#switching-between-two-or-more-yubikeys
yubi-switch() {
  echo '=> switch Yubikey'
  gpg-connect-agent "scd serialno" "learn --force" /bye
  echo '=> reset GPG_TTY'
  export GPG_TTY=$(tty)
  echo '=> force pinentry reset'
  gpg-connect-agent "updatestartuptty" /bye >/dev/null
}

# ---------------
# ZSH management
# ---------------
alias zshenv="$EDITOR ${HOME}/.zshenv" # Quick access to the .zshenv file
alias zshrc="$EDITOR ${XDG_CONFIG_HOME}/zsh/zshrc" # Quick access to the .zshrc file
alias sourcezshrc="source ${XDG_CONFIG_HOME}/zsh/zshrc"
alias zshfalkor="$EDITOR ${XDG_CONFIG_HOME}/zsh/custom/plugins/falkor/falkor.plugin.zsh" # Quick access to this file


#-----------------------
# Global alias (for ZSH)
# ----------------------
if [[ -n ${ZSH_VERSION-} ]]; then
    alias -g L="| less"             # Write L after a command to page through the output.
    alias -g H="| head -n 20"       # Write H after a command to get the 20 first lines
    alias -g G='| grep --color -i'  # Write G after the command to grep it
    alias -g TL='| tail -20'
    alias -g NUL="> /dev/null 2>&1" # You get the idea.
fi
