# -*- mode:sh; -*-
###############################################################################
# Include the zsh-completions installed by Homebrew

_homebrew-installed() {
  type brew &> /dev/null
}
_zsh-completion-from-homebrew-installed() {
    brew --prefix zsh-completions &> /dev/null
}

# RVM Completion
if [[ -d "$HOME/.rvm/scripts/zsh/Completion" ]]; then
    fpath=($HOME/.rvm/scripts/zsh/Completion $fpath)
fi
# General Homebrew ZSH completions
if _homebrew-installed && _zsh-completion-from-homebrew-installed ; then
  fpath=('/usr/local/share/zsh-completions' $fpath)
fi

# My custom completions
fpath=("${XDG_CONFIG_HOME}/zsh/custom/completions" $fpath)
