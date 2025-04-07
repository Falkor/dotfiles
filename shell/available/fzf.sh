# Wrapper for fzf (Command-line fuzzy finder)
# See https://github.com/junegunn/fzf
#
if [ -n "$(which fzf)" ]; then
  source <(fzf --zsh)
fi
