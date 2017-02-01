# Bash completion for Beets
# See http://beets.readthedocs.io/en/latest/reference/cli.html#completion
#
if [[ -n "$(which beet)" ]]; then
  case $shell in
    bash) eval "$(beet completion)";;
    zsh)  ;;
    *)
    ;;
  esac
fi
