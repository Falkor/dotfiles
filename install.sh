#!/usr/bin/env bash
# Time-stamp: <Wed 2016-03-02 01:12 svarrette>
################################################################################
#      _____     _ _              _           _       _    __ _ _
#     |  ___|_ _| | | _____  _ __( )___    __| | ___ | |_ / _(_) | ___  ___
#     | |_ / _` | | |/ / _ \| '__|// __|  / _` |/ _ \| __| |_| | |/ _ \/ __|
#     |  _| (_| | |   < (_) | |    \__ \ | (_| | (_) | |_|  _| | |  __/\__ \
#     |_|  \__,_|_|_|\_\___/|_|    |___/  \__,_|\___/ \__|_| |_|_|\___||___/
#
################################################################################
# Installation script for Falkor aka S.Varrette's dotfiles within the homedir of the
# user running this script.
# Adapted from the install script set for [ULHPC/dotfiles](https://github.com/ULHPC/dotfiles)

#set -x # Debug

### Global variables
VERSION=0.1
COMMAND=`basename $0`
VERBOSE=""
DEBUG=""
SIMULATION=""
OFFLINE=""
MODE=""
FORCE=""

### displayed colors
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_VIOLET="\033[0;35m"
COLOR_CYAN="\033[0;36m"
COLOR_BOLD="\033[1m"
COLOR_BACK="\033[0m"

### Local variables
STARTDIR="$(pwd)"
SCRIPTFILENAME=$(basename $0)
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=~/.dotfiles.falkor.d

# What to take care of (default is empty)
WITH_BASH=""
WITH_ZSH=""
WITH_EMACS=""
WITH_VIM=""
WITH_GIT=""
WITH_SCREEN=""

#######################
### print functions ###
#######################

######
# Print information in the following form: '[$2] $1' ($2=INFO if not submitted)
# usage: info text [title]
##
info() {
    [ -z "$1" ] && print_error_and_exit "[$FUNCNAME] missing text argument"
    local text=$1
    local title=$2
    # add default title if not submitted but don't print anything
    [ -n "$text" ] && text="${title:==>} $text"
    echo -e "${COLOR_GREEN}$text${COLOR_BACK}"
}
debug()   { [ -n "$DEBUG"   ] && info "$1" "[${COLOR_YELLOW}DEBUG${COLOR_BACK}]"; }
verbose() { [ -n "$VERBOSE" ] && info "$1"; }
error()   { info "$1" "[${COLOR_RED}ERROR${COLOR_BACK}]"; }
warning() { info "$1" "[${COLOR_VIOLET}WARNING${COLOR_BACK}]"; }
print_error_and_exit() {
    local text=$1
    [ -z "$1" ] && text=" Bad format"
    error  "$text. '$COMMAND -h' for help."
    exit 1
}
print_version() {
    cat <<EOF
This is Falkor/dotfiles/$COMMAND version "$VERSION".
Copyright (c) 2011-2016 Sebastien Varrette  (sebastien.varrette@uni.lu)
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
}
print_help() {
    less <<EOF
NAME
    $COMMAND -- install (or remove) Falkor's dotfiles in the current user's homedir

SYNOPSIS
    $COMMAND [-V | -h]
    $COMMAND [--debug] [-v] [-n] [-d DIR] [--offline] [options]
    $COMMAND --delete [-d DIR] [options]

OPTIONS
    --debug
        Debug mode. Causes $COMMAND to print debugging messages.
    -h --help
        Display a help screen and quit.
    -n --dry-run
        Simulation mode.
    -v --verbose
        Verbose mode.
    -f --force
        Force mode -- do not raise questions ;)
    -V --version
        Display the version number then quit.
    -d --dir DIR
        Set the dotfiles directory (Default: ~/.dotfiles.falkor.d)
    --delete --remove --uninstall
        Remove / Restore the installed components
    --offline
        Proceed in offline mode (assuming you have already cloned the repository)
    --all -a
        Install / delete ALL Falkor's dotfiles
    --bash --with-bash
        Falkor's Bourne-Again shell (Bash) configuration ~/.bashrc
    --zsh --with-zsh
        Falkor's ZSH / Oh-My-ZSH configuration ~/.oh-my-zsh/ ~/.zshrc
    --emacs --with-emacs
        Falkor's Emacs configuration ~/.emacs ~/.emacs.d/
    --vim --with-vim
        Falkor's VIM configuration ~/.vimrc
    --git --with-git
        Falkor's Git configuration ~/.gitconfig[.local]
    --screen --with-screen
        Falkor's GNU Screen configuration ~/.screenrc

EXAMPLES

    To install/remove all available dotfiles:
        $COMMAND [--delete] --all

    To install ONLY the zsh/vim/git and screen dotfiles:
        $COMMAND [--delete] --zsh --vim --git --screen

AUTHOR
    Falkor aka Sebastien Varrette (sebastien.varrette@uni.lu)

REPORTING BUGS
    Please report bugs using the Issue Tracker of the project:
       <https://github.com/Falkor/dotfiles/issues>

COPYRIGHT
    This is free software; see the source for copying conditions.  There is
    NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
    PURPOSE.
EOF
}
#########################
### toolbox functions ###
#########################

#####
# execute a local command
# usage: execute command
###
execute() {
    [ $# -eq 0 ] && print_error_and_exit "[$FUNCNAME] missing command argument"
    debug "[$FUNCNAME] $*"
    [ -n "${SIMULATION}" ] && echo "(simulation) $*" || eval $*
    local exit_status=$?
    debug "[$FUNCNAME] exit status: $exit_status"
    return $exit_status
}

####
# ask to continue. exit 1 if the answer is no
# usage: really_continue text
##
really_continue() {
    echo -e -n "[${COLOR_VIOLET}WARNING${COLOR_BACK}] $1 Are you sure you want to continue? [Y|n] "
    read ans
    case $ans in
        n*|N*) exit 1;;
    esac
}

#####
# Check availability of binaries passed as arguments on the current system
# usage: check_bin prog1 prog2 ...
##
check_bin() {
    [ $# -eq 0 ] && print_error_and_exit "[$FUNCNAME] missing argument"
    for appl in $*; do
        echo -n -e "=> checking availability of the command '$appl' on your system \t"
        local tmp=`which $appl`
        [ -z "$tmp" ] && print_error_and_exit "Please install $appl or check \$PATH." || echo -e "[${COLOR_GREEN} OK ${COLOR_BACK}]"
    done
}

####
# Add (or remove) a given link pointing to the corresponding dotfile.
# A backup of the file is performed if it previoiusly existed.
# Upon removal, the link is deleted only if it targets the expected dotfile
##
add_or_remove_link() {
    [ $# -ne 2 ] && print_error_and_exit "[$FUNCNAME] missing argument(s). Format: $FUNCNAME <src> <dst>"
    local src=$1
    local dst=$2
    if [ "${MODE}" == "--delete" ]; then
        debug "removing dst='$dst' (if symlink pointing to src='$src' =? $(readlink $dst))"
        if [[ -h $dst && "$(readlink $dst)" == "${src}" ]]; then
            warning "removing the symlink '$dst'"
            [ -n "${VERBOSE}" ] && really_continue
            execute "rm $dst"
            if [ -f "${dst}.bak" ]; then
                warning "restoring ${dst} from ${dst}.bak"
                execute "mv ${dst}.bak ${dst}"
            fi
        fi
    else
        [ ! -e $src ] && print_error_and_exit "Unable to find the dotfile '${src}'"
        debug "attempt to add '$dst' symlink (pointing to '$src')"
        # return if the symlink already exists
        [[ -h $dst && "$(readlink $dst)" == "${src}" ]] && return
        if [ -e $dst ]; then
            warning "The file '$dst' already exists and will be backuped (as ${dst}.bak)"
            execute "mv $dst{,.bak}"
        fi
        execute "ln -sf $src $dst"
    fi
}

add_or_remove_copy() {
    [ $# -ne 2 ] && print_error_and_exit "[$FUNCNAME] missing argument(s). Format: $FUNCNAME <src> <dst>"
    local src=$1
    local dst=$2
    [ ! -f $src ] && print_error_and_exit "Unable to find the dotfile '${src}'"
    if [ "${MODE}" == "--delete" ]; then
        debug "removing dst='$dst'"
        if [[ -f $dst ]]; then
            warning "removing the file '$dst'"
            [ -n "${VERBOSE}" ] && really_continue
            execute "rm $dst"
            if [ -f "${dst}.bak" ]; then
                warning "restoring ${dst} from ${dst}.bak"
                execute "mv ${dst}.bak ${dst}"
            fi
        fi
    else
        debug "copying '$dst' from '$src'"
        check_bin shasum
        # return if the symlink already exists
        local checksum_src=`shasum $src | cut -d ' ' -f 1`
        local checksum_dst=`shasum $dst | cut -d ' ' -f 1`
        if [ "${checksum_src}" == "${checksum_dst}" ]; then
            debug "NOT copying '$dst' from '$src' since they are the same files"
            return
        fi
        if [ -f $dst ]; then
            warning "The file '$dst' already exists and will be backuped (as ${dst}.bak)"
            execute "cp $dst{,.bak}"
        fi
        execute "cp $src $dst"
    fi
}

install_ohmyzsh() {
    check_bin zsh
    if [ ! -d "$HOME/.oh-my-zsh/" ]; then
        info "installing Oh-My-ZSH -- see http://ohmyz.sh/"
        # installation by curl if available
        if   [ -n "`which curl`" ]; then
            echo "   - installation using curl"
            warning " "
            warning "Remember to Exit the zsh shell to continue the installation!!!"
            warning " "
            [ -z "${SIMULATION}" ] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        elif [ -n "`which wget`" ]; then
            echo "   - installation using wget"
            [ -z "${SIMULATION}" ] && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        else
            print_error_and_exit "Unable to install oh-my-zsh/. You shall install 'curl' or 'wget' on your system"
        fi
    fi
    add_or_remove_copy  $DOTFILES/oh-my-zsh/zshrc       ~/.zshrc
}

install_custom_ohmyzsh() {
    info "installing Falkor custom plugins for oh-my-zsh/"
    local customdir="$HOME/.oh-my-zsh/custom/"
    local falkor_customdir="${DOTFILES}/oh-my-zsh/custom"
    [ ! -h "${customdir}/.ref" ] && execute "ln -s ${falkor_customdir} ${customdir}/.ref"
    for f in `ls ${falkor_customdir}/*.zsh`; do
        ff=`basename $f`
        if [ ! -h "${customdir}/$ff" ]; then
            echo "     - add custom '$ff'"
            execute "ln -s .ref/$ff ${customdir}/$ff"
        fi
    done
    local private_aliases="${customdir}/private_aliases.zsh"
    if [ ! -f "${private_aliases}" ]; then
        cat  << 'EOF' > ${private_aliases}
#
# private_aliases.zsh
#
# Add your local (private) aliases for zsh here.
EOF
    fi
    local plugindir="${customdir}/plugins"
    local falkor_plugindir="${falkor_customdir}/plugins"
    [ ! -h "${plugindir}/.ref" ] && execute "ln -s ../.ref/plugins ${plugindir}/.ref"
    for d in `ls -d ${falkor_plugindir}/*`; do
        dd=`basename $d`
        if [ ! -h "${plugindir}/$dd" ]; then
            echo "     - installing custom oh-my-zsh plugin '$dd'"
            execute "ln -s .ref/$dd ${plugindir}/$dd"
        fi
    done
    local themedir="${customdir}/themes"
    [ ! -d "${themedir}" ] && execute "mkdir -p ${customdir}/themes"
    local falkor_themedir="${falkor_customdir}/themes"
    [ ! -h "${themedir}/.ref" ] && execute "ln -s ../.ref/themes ${themedir}/.ref"
    for d in `ls -d ${falkor_themedir}/*`; do
        dd=`basename $d`
        if [ ! -h "${themedir}/$dd" ]; then
            echo "     - installing custom oh-my-zsh theme '$dd'"
            execute "ln -s .ref/$dd ${themedir}/$dd"
        fi
    done

}

# courtesy of https://github.com/holman/dotfiles/blob/master/script/bootstrap
setup_gitconfig_local () {
    local gitconfig_local=${1:-"$HOME/.gitconfig.local"}
    if [ ! -f "${gitconfig_local}" ]; then
        info "setup Local / private gitconfig '${gitconfig_local}'"
        cat > $gitconfig_local <<'EOF'
# -*- mode: gitconfig; -*-
################################################################################
#  .gitconfig.local -- Private part of the GIT configuration
#  .                   to hold username / credentials etc .
#  NOT meant to be staged for commit under github
#                _ _                   __ _         _                 _
#           __ _(_) |_ ___ ___  _ __  / _(_) __ _  | | ___   ___ __ _| |
#          / _` | | __/ __/ _ \| '_ \| |_| |/ _` | | |/ _ \ / __/ _` | |
#         | (_| | | || (_| (_) | | | |  _| | (_| |_| | (_) | (_| (_| | |
#        (_)__, |_|\__\___\___/|_| |_|_| |_|\__, (_)_|\___/ \___\__,_|_|
#          |___/                            |___/
#
# See also: http://github.com/Falkor/dotfiles
################################################################################
EOF

        local git_credential='cache'
        local git_authorname=
        local git_email=
        if [ "$(uname -s)" == "Darwin" ]; then
            git_authorname=`dscl . -read /Users/$(whoami) RealName | tail -n1`
            git_credential='osxkeychain'
        elif [ "$(uname -s)" == "Linux" ]; then
            git_authorname=`getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1`
        fi
        if [ -z "${git_authorname}" ]; then
            echo -e -n  "[${COLOR_VIOLET}WARNING${COLOR_BACK}] Enter you Git author name:"
            read -e git_authorname
        fi
        if [ -z "${git_email}" ]; then
            echo -e -n  "[${COLOR_VIOLET}WARNING${COLOR_BACK}] Enter you Git author email:"
            read -e git_email
        fi
        cat >> $gitconfig_local <<EOF
[user]
    name   = $git_authorname
    email  = $git_email
    helper = $git_credential
EOF

    fi
}


################################################################################
################################################################################
# Let's go

ACTION="install"
# Check for options
while [ $# -ge 1 ]; do
    case $1 in
        -h | --help)    print_help;        exit 0;;
        -V | --version) print_version;     exit 0;;
        --debug)        DEBUG="--debug";
                        VERBOSE="--verbose";;
        -v | --verbose) VERBOSE="--verbose";;
        -f | --force)   FORCE="--force";;
        -n | --dry-run) SIMULATION="--dry-run";;
        --offline)      OFFLINE="--offline";;
        --delete | --remove | --uninstall)
            ACTION="uninstall"; OFFLINE="--offline"; MODE="--delete";;
        -d | --dir | --dotfiles)
            shift;       DOTFILES=$1;;
        --with-bash  | --bash)   WITH_BASH='--with-bash';;
        --with-zsh   | --zsh)    WITH_ZSH='--with-zsh';;
        --with-emacs | --emacs)  WITH_EMACS='--with-emacs';;
        --with-vim   | --vim)    WITH_VIM='--with-emacs';;
        --with-git   | --git)    WITH_GIT='--with-git';;
        --with-screen| --screen) WITH_SCREEN='--with-screen';;
        -a | --all)
            WITH_BASH='--with-bash';
            WITH_ZSH='--with-zsh';
            WITH_EMACS='--with-emacs';
            WITH_VIM='--with-emacs';
            WITH_GIT='--with-git';
            WITH_SCREEN='--with-screen';;
    esac
    shift
done
[ -z "${DOTFILES}" ] && print_error_and_exit "Wrong dotfiles directory (empty)"
echo ${DOTFILES} | grep  '^\/' > /dev/null
greprc=$?
if [ $greprc -ne 0 ]; then
    warning "Assume dotfiles directory '${DOTFILES}' is relative to the home directory"
    DOTFILES="$HOME/${DOTFILES}"
fi
info "About to ${ACTION} Falkor's dotfiles from ${DOTFILES}"
[ -z "${FORCE}" ] && really_continue

if [ "${SCRIPTDIR}" != "${DOTFILES}" ]; then
    if [ -d "${SCRIPTDIR}/.git" ]; then
        # We are (hopefully) in a clone of the Falkor's dotfile repository.
        # Make $DOTFILES be a symlink to this clone.
        info "make '${DOTFILES}' a symlink to ${SCRIPTDIR}"
        execute "ln -s ${SCRIPTDIR} ${DOTFILES}"
    fi
fi

# Update the repository if already present
[[ -z "${OFFLINE}" && -d "${DOTFILES}" ]]   && execute "( cd $DOTFILES ; git pull )"
# OR clone it there
[[ ! -d "${DOTFILES}" ]] && execute "git clone --recursive --depth 1 https://github.com/Falkor/dotfiles.git ${DOTFILES}"

cd ~

if [ -z "${WITH_BASH}${WITH_ZSH}${WITH_EMACS}${WITH_VIM}${WITH_GIT}${WITH_SCREEN}" ]; then
    warning " "
    warning "By default, this installer does nothing except updating ${DOTFILES}."
    warning "Use '$0 --all' to install all available configs. OR use a discrete set of options."
    warning "Ex: '$0 $MODE --zsh --with'"
    warning " "
    exit 0
fi


## Bash
if [ -n "${WITH_BASH}" ]; then
    info "${ACTION} Falkor's Bourne-Again shell (Bash) configuration ~/.bashrc"
    add_or_remove_link $DOTFILES/bash/bashrc       ~/.bashrc
    add_or_remove_link $DOTFILES/bash/inputrc      ~/.inputrc
    add_or_remove_link $DOTFILES/bash/bash_profile ~/.bash_profile
    info "add custom aliases from Falkor's Oh-My-ZSH plugin (made compatible with bash)"
    add_or_remove_link $DOTFILES/oh-my-zsh/custom/plugins/falkor/falkor.plugin.zsh  ~/.bash_aliases
fi

## Zsh
if [ -n "${WITH_ZSH}" ]; then
    info "${ACTION} Falkor's ZSH / Oh-My-ZSH configuration ~/.oh-my-zsh/ ~/.zshrc"
    if [ "${MODE}" != "--delete" ]; then
        install_ohmyzsh
        install_custom_ohmyzsh
    else
        if [ -f ~/.oh-my-zsh/tools/uninstall.sh ]; then
            execute "bash ~/.oh-my-zsh/tools/uninstall.sh"
        fi
        add_or_remove_copy  $DOTFILES/oh-my-zsh/zshrc       ~/.zshrc
    fi
fi

## GNU Emacs
if [ -n "${WITH_EMACS}" ]; then
    info "${ACTION} Falkor's Emacs configuration ~/.emacs ~/.emacs.d"
    warning "For performance reason, make this installation independently following instructions on"
    warning "    https://github.com/Falkor/emacs-config2 "
    # add_or_remove_link   $DOTFILES/emacs     ~/.emacs.d
    # add_or_remove_link   ~/.emacs.d/.emacs   ~/.emacs
fi

## VI iMproved ([m]Vim)
if [ -n "${WITH_VIM}" ]; then
    info "${ACTION} Falkor's VIM configuration ~/.vimrc"
    add_or_remove_link $DOTFILES/vim/vimrc ~/.vimrc
    if  [ "${MODE}" != "--delete" ]; then
        warning "Run vim afterwards to download the expected package (using NeoBundle)"
        if [ "$(uname -s)" == "Linux" ]; then
            warning "After Neobundle installation and vim relaunch, you might encounter the bug #156"
            warning "        https://github.com/avelino/vim-bootstrap/issues/156"
        fi
    fi
fi

## Git
if [ -n "${WITH_GIT}" ]; then
    info "${ACTION} Falkor's Git configuration ~/.gitconfig[.local]"
    add_or_remove_link $DOTFILES/git/gitconfig  ~/.gitconfig
    if [ "${MODE}" != "--delete" ]; then
        setup_gitconfig_local  ~/.gitconfig.local
    else
        add_or_remove_copy ' '   ~/.gitconfig.local
    fi
fi

## GNU Screen
if [ -n "${WITH_SCREEN}" ]; then
    info "${ACTION} Falkor's GNU Screen configuration ~/.screenrc"
    add_or_remove_link $DOTFILES/screen/screenrc ~/.screenrc
fi
