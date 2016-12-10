# -*- mode:sh; -*-
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

if [ -n "$(which brew 2>/dev/null)" ]; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        . "$(brew --prefix)/etc/bash_completion"
    fi
fi
