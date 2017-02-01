# Bash completion for Beets
# See http://beets.readthedocs.io/en/latest/reference/cli.html#completion
#
if [[ -n "$(which beet)" ]]; then
  eval "$(beet completion)"
fi
