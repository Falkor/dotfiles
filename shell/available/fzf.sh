# Wrapper for fzf (Command-line fuzzy finder)
# See https://github.com/junegunn/fzf
#
if [ -x "$(command -v fzf 2>/dev/null)" ]; then
  source <(fzf --zsh)
fi
