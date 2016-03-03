#! /bin/bash
################################################################################
# setup_bats.sh - Setup Bats -- Bash Automated Testing System
# .               See https://github.com/sstephenson/bats
# Time-stamp: <Thu 2016-03-03 11:18 svarrette>
#
# Usage:
#       source setup_bats.sh
#
# You SHOULD source this file since it might alter the PATH variable
################################################################################

COLOR_RED="\033[0;31m"
COLOR_BACK="\033[0m"

print_error_and_exit() {
    echo -e  "${COLOR_RED}***ERROR***${COLOR_BACK} $*"
    exit 1
}
if [ "$(uname -s)" == "Darwin"  ]; then
    [ -z "`which brew`" ] && print_error_and_exit "Install Homebrew: see http://brew.sh/"
    if [ -z "`which bats`" ]; then
        echo "=> installing bats"
        brew install bats
    else
        echo "... bats seems to be already installed"
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if [ -z "`which bats`" ]; then
        echo "=> manual install of bats"
        if [ ! -d /tmp/bats ]; then
            git clone https://github.com/sstephenson/bats.git /tmp/bats
        else
            cd /tmp/bats; git pull; cd -
        fi
        mkdir -p /tmp/local
        bash /tmp/bats/install.sh /tmp/local
        export PATH=$PATH:/tmp/local/bin
    else
        echo "... bats seems to be already installed"
    fi
else
    print_error_and_exit "unsupported system"
fi
