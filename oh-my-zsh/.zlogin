# -*- mode:sh; -*-
###############################################################################
# This file is load **after** .zshrc
#
# Reminder:
# 1. `~/.zshenv` :         Usually run for every zsh
# 2. `$ZDOTDIR/.zprofile`: Run for login shells
# 3. `$ZDOTDIR/.zshrc`:    Run for interactive shells.`
# 4. `$ZDOTDIR/.zlogin`:   Run for login shells (**after** .zshrc)

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
