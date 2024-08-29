# -*- mode: sh -*-
###############################################################################
# This file is load **before** .zshrc
#
# Reminder:
# 1. `~/.zshenv` :         Usually run for every zsh
# 2. `$ZDOTDIR/.zprofile`: Run for login shells
# 3. `$ZDOTDIR/.zshrc`:    Run for interactive shells.`
# 4. `$ZDOTDIR/.zlogin`:   Run for login shells (**after** .zshrc)


# check_task=$( which task 2>/dev/null )
# if [ -n "${check_task}" ]; then
# 	task
# fi


# Created by `pipx` on 2024-06-13 15:40:32
export PATH="$PATH:/home/svarrette/.local/bin"
