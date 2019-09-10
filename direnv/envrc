# -*- mode: sh; -*-
# (rootdir)/.envrc : local direnv configuration file
# Assumes the presence of '~/.config/direnv/direnvrc' from  
#    https://github.com/Falkor/dotfiles/blob/master/direnv/direnvrc
#
# Grab the latest version of this file from
#      https://github.com/Falkor/dotfiles/blob/master/direnv/envrc
#  
# Quick installation of this file for your project:
#    cd /path/to/projectdir
#    curl -o .envrc https://raw.githubusercontent.com/Falkor/dotfiles/master/direnv/envrc

# Default python version and virtualenv (basename of the root project directory)
[ -f ".python-version" ]    && pyversion=$(head .python-version) || pyversion=3.7.4
[ -f ".python-virtualenv" ] && pvenv=$(head  .python-virtualenv) || pvenv=$(basename $PWD)

use python ${pyversion}
# Create the virtualenv if not yet done
layout virtualenv ${pyversion} ${pvenv}
# activate it
layout activate ${pvenv} 
