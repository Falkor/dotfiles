# -*- mode:sh; -*-
###############################################################################
# Include the zsh-completions installed by Homebrew

_homebrew-installed() {
  type brew &> /dev/null
}
_zsh-completion-from-homebrew-installed() {
    brew --prefix zsh-completions &> /dev/null
}

completiondirs=("${XDG_CONFIG_HOME}/zsh/custom/completions")
if _homebrew-installed && _zsh-completion-from-homebrew-installed ; then
  completiondirs=('/usr/local/share/zsh-completions' $completiondirs)
fi

for completiondir ($completiondirs); do
  fpath=($completiondir $fpath)
done
