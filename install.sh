#!/usr/bin/env bash
# Time-stamp: <Mon 2017-01-23 01:55 svarrette>
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
COMMAND=$(basename "$0")
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
COLOR_BACK="\033[0m"

### Local variables
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES_DIR=dotfiles.falkor.d
[ -n "${XDG_CONFIG_HOME}" ] && PREFIX="${XDG_CONFIG_HOME}" || PREFIX="$HOME/.config"
[ -n "${XDG_DATA_HOME}" ]   && DATADIR="${XDG_DATA_HOME}"  || DATADIR="$HOME/.local/share"

# What to take care of (default is empty)
WITH_SHELL=""     # Common shell stuff
WITH_BASH=""
WITH_ZSH=""
WITH_EMACS=""
WITH_VIM=""
WITH_GIT=""
WITH_SCREEN=""
WITH_BREW=""

# Default action
ACTION="install"

#######################
### print functions ###
#######################

######
# Print information in the following form: '[$2] $1' ($2=INFO if not submitted)
# usage: info text [title]
##
info() {
    [ -z "$1" ] && print_error_and_exit "[${FUNCNAME[0]}] missing text argument"
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
Copyright (c) 2011-2017 Sebastien Varrette  (sebastien.varrette@uni.lu)
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
    $COMMAND [--debug] [-v] [-n] [--offline] [options]
    $COMMAND --delete [options]

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
        Set the dotfiles directory (Default: .dotfiles.falkor.d)
    --prefix DIR
        Set the prefix directory for the dotfiles (Default: ~/.config)
    --delete --remove --uninstall
        Remove / Restore the installed components
    --offline
        Proceed in offline mode (assuming you have already cloned the repository)
    --all -a
        Install / delete ALL Falkor's dotfiles
    --bash --with-bash
        Falkor's Bourne-Again shell (Bash) configuration ~/.bashrc
    --brew --with-brew
        Install with brew bundle
    --zsh --with-zsh
        Falkor's ZSH / Oh-My-ZSH configuration
    --emacs --with-emacs
        Falkor's Emacs configuration
    --vim --with-vim
        Falkor's VIM configuration
    --git --with-git
        Falkor's Git configuration gitconfig[.local]
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
    [ $# -eq 0 ] && print_error_and_exit "[${FUNCNAME[0]}] missing command argument"
    debug "[${FUNCNAME[0]}] $*"
    [ -n "${SIMULATION}" ] && echo "(simulation) $*" || eval "$*"
    local exit_status=$?
    debug "[${FUNCNAME[0]}] exit status: $exit_status"
    return $exit_status
}

####
# ask to continue. exit 1 if the answer is no
# usage: really_continue text
##
really_continue() {
    [ -n "${FORCE}" ] && return || true
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
    [ $# -eq 0 ] && print_error_and_exit "[${FUNCNAME[0]}] missing argument"
    for appl in "$@"; do
        echo -n -e "=> checking availability of the command '$appl' on your system \t"
        local tmp=$(which $appl)
        [ -z "$tmp" ] && print_error_and_exit "Please install $appl or check \$PATH." || echo -e "[${COLOR_GREEN} OK ${COLOR_BACK}]"
    done
}

####
# Add (or remove) a given link pointing to the corresponding dotfile.
# A backup of the file is performed if it previoiusly existed.
# Upon removal, the link is deleted only if it targets the expected dotfile
##
add_or_remove_link() {
    [ $# -lt 2 ] && print_error_and_exit "[${FUNCNAME[0]}] missing argument(s). Format: ${FUNCNAME[0]} <src> <dst> [<prefix>]"
    local source=$1
    local dst=$2
    # prefix for the source
    local prefix=$3
    [ -n "${prefix}" ] && src="${prefix}/${source}" || src="${source}"
    if [ "${MODE}" == "--delete" ]; then
        debug "removing dst='$dst' (if symlink pointing to src='$source' =? $(readlink "$dst"))"
        if [[ -h "${dst}" && "$(readlink "${dst}")" == "${source}" ]]; then
            warning "removing the symlink '$dst'"
            [ -n "${VERBOSE}" ] && really_continue
            execute "rm $dst"
            if [ -f "${dst}.bak" ]; then
                warning "restoring ${dst} from ${dst}.bak"
                execute "mv ${dst}.bak ${dst}"
            fi
        fi
    else
        # get rid of ../ in the path upon checking
        real_srcpath=$(python -c "import os,sys; print os.path.abspath(sys.argv[1])" "${src}")
        [ ! -e "${real_srcpath}" ] && print_error_and_exit "Unable to find the dotfile '${src}'\n(interpreted path: '${real_srcpath}')"
        debug "attempt to add '$dst' symlink (pointing to '$source') if needed"
        # return if the symlink already exists
        [[ -h "${dst}" && "$(readlink "${dst}")" == "${source}" ]] && return
        if [ -e "${dst}" ]; then
            warning "The file '${dst}' already exists and will be backuped (as ${dst}.bak)"
            execute "mv ${dst}{,.bak}"
        fi
        execute "ln -sf ${source} ${dst}"
    fi
}

###
# Enable a specific dotfile customization to the shells (bash, zsh...)
##
shell_custom_enable() {
  local name=$1
  local configdir="${PREFIX_HOME}/${PREFIX}/shell/"
  if [ ! -d "${configdir}" ]; then
    WITH_SHELL="--shell"
    __shell
  fi
  local src="${configdir}/available/${name}.sh"
  local dst="${configdir}/${name}.sh"
  if [[ -d "${configdir}" && -f "${src}" ]]; then
    add_or_remove_link "available/${name}.sh" "${configdir}/${name}.sh" "${configdir}"
  fi
}

add_or_remove_copy() {
    [ $# -ne 2 ] && print_error_and_exit "[${FUNCNAME[0]}] missing argument(s). Format: ${FUNCNAME[0]} <src> <dst>"
    local src=$1
    local dst=$2
    [ ! -f "${src}" ] && print_error_and_exit "Unable to find the dotfile '${src}'"
    if [ "${MODE}" == "--delete" ]; then
        debug "removing dst='${dst}'"
        if [[ -f $dst ]]; then
            warning "removing the file '$dst'"
            [ -n "${VERBOSE}" ] && really_continue "$@"
            execute "rm ${dst}"
            if [ -f "${dst}.bak" ]; then
                warning "restoring ${dst} from ${dst}.bak"
                execute "mv ${dst}.bak ${dst}"
            fi
        fi
    else
        debug "copying '$dst' from '$src'"
        check_bin shasum
        # return if the symlink already exists
        local checksum_src=$(shasum "${src}" | cut -d ' ' -f 1)
        local checksum_dst=$(shasum "${dst}" | cut -d ' ' -f 1)
        if [ "${checksum_src}" == "${checksum_dst}" ]; then
            echo "   - NOT copying '$dst' from '$src' since they are the same files"
            return
        fi
        if [ -f "${dst}" ]; then
            warning "The file '$dst' already exists and will be backuped (as ${dst}.bak)"
            execute "cp ${dst}{,.bak}"
        fi
        execute "cp ${src} ${dst}"
    fi
}

install_ohmyzsh() {
    check_bin zsh
    local omzsh_dir="${DATADIR}/oh-my-zsh"
    if [ ! -d "${omzsh_dir}" ]; then
        info "installing Oh-My-ZSH in ${DATADIR} -- see http://ohmyz.sh/"
        # installation by curl if available
        if   [ -n "$(which curl)" ]; then
            echo "   - installation using curl"
            warning " "
            warning "Remember to Exit the zsh shell to continue the installation!!!"
            warning " "
            [ -z "${SIMULATION}" ] && sh -c "$(ZSH=${omzsh_dir} curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        elif [ -n "$(which wget)" ]; then
            echo "   - installation using wget"
            [ -z "${SIMULATION}" ] && sh -c "$(ZSH=${omzsh_dir} wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        else
            print_error_and_exit "Unable to install oh-my-zsh/. You shall install 'curl' or 'wget' on your system"
        fi
    fi
}

install_custom_ohmyzsh() {
    info "installing Falkor custom plugins for oh-my-zsh/"
    local customdir="$HOME/.oh-my-zsh/custom/"
    #local falkor_customdir="${INSTALL_DIR}/oh-my-zsh/custom"
    local falkor_customdir="${PREFIX_HOME}${PREFIX}/zsh/custom"
    [ ! -h "${customdir}/.ref" ] && execute "ln -s ${falkor_customdir} ${customdir}/.ref"
    for f in `ls ${falkor_customdir}/*.zsh`; do
        ff="$(basename $f)"
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
    local gitconfig_local=${1:-"${PREFIXHOME}${PREFIX}/git/config.local"}
    local dotfile_gitconfig_local="${INSTALL_DIR}/git/$(basename ${gitconfig_local})"
    if [ -f "${dotfile_gitconfig_local}" ]; then
        #add_or_remove_link "${dotfile_gitconfig_local}" "${gitconfig_local}"
        return
    fi
    if [ ! -f "${gitconfig_local}" ]; then
        info "setup Local / private gitconfig '${gitconfig_local}'"
        [ -n "${SIMULATION}" ] && return
        cat > $gitconfig_local <<'EOF'
# -*- mode: gitconfig; -*-
################################################################################
#  [.git]config.local -- Private part of the GIT configuration
#  .                   to hold username / credentials etc .
#  NOT meant to be staged for commit under github
#      __       _ _  __                  __ _         _                 _
#     | _| __ _(_) ||_ | ___ ___  _ __  / _(_) __ _  | | ___   ___ __ _| |
#     | | / _` | | __| |/ __/ _ \| '_ \| |_| |/ _` | | |/ _ \ / __/ _` | |
#     | || (_| | | |_| | (_| (_) | | | |  _| | (_| |_| | (_) | (_| (_| | |
#     | (_)__, |_|\__| |\___\___/|_| |_|_| |_|\__, (_)_|\___/ \___\__,_|_|
#     |__||___/     |__|                      |___/
#
# See also: http://github.com/Falkor/dotfiles
################################################################################
EOF
        local git_credential='cache'
        local git_authorname=
        local git_email=
        if [ "$(uname -s)" == "Darwin" ]; then
            git_authorname=$(dscl . -read /Users/$(whoami) RealName | tail -n1)
            git_credential='osxkeychain'
        elif [ "$(uname -s)" == "Linux" ]; then
            git_authorname=$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)
        fi
        [ -n "${GIT_AUTHOR_NAME}"  ] && git_authorname="${GIT_AUTHOR_NAME}"
        [ -n "${GIT_AUTHOR_EMAIL}" ] && git_email="${GIT_AUTHOR_EMAIL}"
        if [ -z "${git_authorname}" ]; then
            echo -e -n  "[${COLOR_VIOLET}WARNING${COLOR_BACK}] Enter you Git author name: "
            read -e git_authorname
        fi
        if [ -z "${git_email}" ]; then
            echo -e -n  "[${COLOR_VIOLET}WARNING${COLOR_BACK}] Enter you Git author (${git_authorname}) email: "
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

setup_installdir() {
    [ "${ACTION}" != 'install' ] && return
    check_bin 'git'
    if [ ! -d "${PREFIX_HOME}${PREFIX}" ]; then
        info "creating the prefix directory '${PREFIX_HOME}${PREFIX}'"
        really_continue
        execute "mkdir -p ${PREFIX_HOME}${PREFIX}"
    fi
    if [ -d "${SCRIPTDIR}/.git" -a ! -e "${PREFIX_HOME}${INSTALL_DIR}" ]; then
        # check that the install script really belongs to this git repository
        ok=$(git --git-dir=${SCRIPTDIR}/.git ls-files $COMMAND --error-unmatch 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo -e -n "[${COLOR_VIOLET}WARNING${COLOR_BACK}] Make '${PREFIX_HOME}${INSTALL_DIR}' a symlink to ${SCRIPTDIR} [Y|n]? "
            ans='Yes'
            [ -z "${FORCE}" ] && read ans || true
            case $ans in
                n*|N*)
                ;;
                *)  add_or_remove_link "${SCRIPTDIR}" "${PREFIX_HOME}${INSTALL_DIR}";
                    return
                    ;;
            esac
        fi
        info "Cloning Falkor dotfiles in '${PREFIX_HOME}${INSTALL_DIR}'";
        execute "git clone -q --recursive --depth 1 https://github.com/Falkor/dotfiles.git ${PREFIX_HOME}${INSTALL_DIR}";
    fi

}

## Install common shells
__shell(){
  [ -z "${WITH_SHELL}" ] && return
  info "${ACTION} Common Shell configuration ~/.config/shell/"
  add_or_remove_link "${DOTFILES_DIR}/shell"  "${PREFIX}/shell"  "${PREFIX_HOME}${PREFIX}"
  for n in ${SCRIPTDIR}/shell/available/*.sh; do
    shell_custom_enable $(basename ${n} .sh)
  done

}
## Install/remove specific dotfiles
__bash(){
  [ -z "${WITH_BASH}" ] && return
  info "${ACTION} Falkor's Bourne-Again shell (Bash) configuration ~/.bashrc ~/.inputrc ~/.bash_profile"
  add_or_remove_link "${DOTFILES_DIR}/bash"    "${PREFIX}/bash"     "${PREFIX_HOME}${PREFIX}"
  add_or_remove_link "${PREFIX}/bash/.bashrc"       ~/.bashrc       "${PREFIX_HOME}"
  add_or_remove_link "${PREFIX}/bash/.inputrc"      ~/.inputrc      "${PREFIX_HOME}"
  add_or_remove_link "${PREFIX}/bash/.bash_profile" ~/.bash_profile
  info "${ACTION} custom aliases from Falkor's Oh-My-ZSH plugin (made compatible with bash) ~/${PREFIX}/bash/custom/aliases.sh"
  add_or_remove_link "${PREFIX_HOME}${INSTALL_DIR}/oh-my-zsh/custom/plugins/falkor/falkor.plugin.zsh"  "${PREFIX_HOME}${PREFIX}/bash/custom/aliases.sh"
  if [ "${ACTION}" != "install" ]; then
    execute "rm ${PREFIX_HOME}${INSTALL_DIR}/bash/custom/aliases.sh"
  fi
  __shell
}
# Zsh
__zsh(){
  [ -z "${WITH_ZSH}" ] && return
  info "${ACTION} Falkor's ZSH / Oh-My-ZSH configuration"
  add_or_remove_link "${DOTFILES_DIR}/oh-my-zsh"    "${PREFIX}/zsh"     "${PREFIX_HOME}${PREFIX}"
  if [ "${MODE}" != "--delete" ]; then
    install_ohmyzsh
    install_custom_ohmyzsh
  else
    if [ -f ~/.oh-my-zsh/tools/uninstall.sh ]; then
      execute "bash ~/.oh-my-zsh/tools/uninstall.sh"
    fi
  fi
  add_or_remove_link "${PREFIX}/zsh/.zshrc"       ~/.zshrc       "${PREFIX_HOME}"
  __shell
}
# GNU Emacs
__emacs(){
  [ -z "${WITH_EMACS}" ] && return
  info "${ACTION} Falkor's Emacs configuration"
  warning "For performance reason, make this installation independently following instructions on"
  warning "    https://github.com/Falkor/emacs-config2 "
  # add_or_remove_link   $INSTALL_DIR/emacs     ~/.emacs.d
  # add_or_remove_link   ~/.emacs.d/.emacs   ~/.emacs
}
# VI iMproved ([m]Vim)
__vim(){
  [ -z "${WITH_VIM}" ] && return
  info "${ACTION} Falkor's VIM configuration"
  add_or_remove_link "${DOTFILES_DIR}/vim"    "${PREFIX}/vim"     "${PREFIX_HOME}${PREFIX}"
  shell_custom_enable 'vim'
    # if  [ "${MODE}" != "--delete" ]; then
    #     warning "Run vim afterwards to download the expected package (using NeoBundle)"
    #     if [ "$(uname -s)" == "Linux" ]; then
    #         warning "After Neobundle installation and vim relaunch, you might encounter the bug #156"
    #         warning "        https://github.com/avelino/vim-bootstrap/issues/156"
    #     fi
    # fi
}
# Git
__git(){
  [ -z "${WITH_GIT}" ] && return
  info "${ACTION} Falkor's Git configuration ~/.gitconfig[.local]"
  add_or_remove_link "${DOTFILES_DIR}/git"    "${PREFIX}/git"     "${PREFIX_HOME}${PREFIX}"
  #add_or_remove_link "${PREFIX}/git/.gitconfig"       ~/.gitconfig       "${PREFIX_HOME}"
  #add_or_remove_link "${INSTALL_DIR}/git/.gitconfig" ~/.gitconfig
  if [ "${MODE}" != "--delete" ]; then
    setup_gitconfig_local
    #~/.gitconfig.local
    # else
    #     add_or_remove_copy ' ' ${PREFIXHOME}${PREFIX}/git/config.local
    #     #~/.gitconfig.local
  fi
}
## GNU Screen
__screen(){
 [ -z "${WITH_SCREEN}" ] && return
    info "${ACTION} ULHPC GNU Screen configuration ~/.screenrc"
    add_or_remove_link "${DOTFILES_DIR}/screen"    "${PREFIX}/screen"     "${PREFIX_HOME}${PREFIX}"
    add_or_remove_link "${PREFIX}/screen/.screenrc"      ~/.screenrc       "${PREFIX_HOME}"
}
## HomeBrew -- http://brew.sh
__brew(){
  [ -z "${WITH_BREW}" -o "$(uname -s)" == "Darwin" -o "${ACTION}" != "install" ] && return
  [ -z "$(which brew)" ] && return
  brewfile="${INSTALL_DIR}/brew/Brewfile"
  [ ! -f "${brewfile}" ] && print_error_and_exit "Unable to find the Brew file '${brewfile}'"
  info "${ACTION} Brew Bundle configuration from '${brewfile}'"
  execute "brew tap Homebrew/bundle"    # Install brew bundle -- see https://github.com/Homebrew/homebrew-bundle
  execute "brew bundle --file=${brewfile} -v"
}


################################################################################
################################################################################
# Let's go

TARGETS=

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
        # -d | --dir | --installdir)
        #     shift;
        #     INSTALL_DIR=$1
        #     # DOTFILES_DIR=$(basename ${INSTALL_DIR})
        #     # PREFIX=$(dirname ${INSTALL_DIR})
        #     ;;
        # --dotfiledir) shift;     DOTFILES_DIR=$1;;
        --prefix)  shift;        PREFIX=$1;;
        --with-bash  | --bash)   TARGETS+='--bash';;
        --with-zsh   | --zsh)    TARGETS+='--zsh';;
        --with-emacs | --emacs)  TARGETS+='--emacs';;
        --with-vim   | --vim)    TARGETS+='--vim';;
        --with-git   | --git)    TARGETS+='--git';;
        --with-screen| --screen) TARGETS+='--screen';;
        --with-brew  | --brew)   TARGETS+='--brew';;
        --with-curl  | --curl)   TARGETS+='--curl';;
        -r | --recommended)
        TARGETS+='--bash --vim --git --screen --curl';;
        -a | --all)
        TARGETS+='--bash --zsh --emacs --vim --git --screen --brew --curl'
        ;;

    esac
    shift
done

PREFIX_HOME=''
if [[ $PREFIX == "${HOME}"* ]]; then
    PREFIX_HOME="$HOME/"
    PREFIX="${PREFIX/#$HOME\//}"
fi

INSTALL_DIR=${PREFIX}/${DOTFILES_DIR}
[ -z "${INSTALL_DIR}" ] && print_error_and_exit "Wrong installation directory"
setup_installdir

info "About to ${ACTION} Falkor's dotfiles from ${INSTALL_DIR}"
really_continue

# Update the repository if already present
[[ -z "${OFFLINE}" && -d "${INSTALL_DIR}" ]]   && execute "( cd ${INSTALL_DIR} ; git pull )"

cd ~

if [ -z "${TARGETS}" ]; then
    warning " "
    warning "By default, this installer does nothing except updating ${INSTALL_DIR}."
    warning "Use '$0 --all' to install all available configs. OR use a discrete set of options."
    warning "Ex: '$0 $MODE --zsh --vim'"
    warning " "
    exit 0
fi

for target in ${TARGETS}; do
    case $target in
      *bash*)  WITH_SHELL='--shell'; WITH_BASH="$target"; __bash;;
      *zsh*)   WITH_SHELL='--shell'; WITH_ZSH="$target";  __zsh;;
      *emacs*) WITH_EMACS="$target"; __emacs;;
      *vim*)   WITH_VIM="$target";   __vim;;
      *git*)   WITH_GIT="$target";   __git;;
      *brew*)  WITH_BREW="$target";  __brew;;
    esac
done
