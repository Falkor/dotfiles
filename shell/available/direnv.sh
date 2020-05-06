# Custom load for direnv
# See https://direnv.net/

if [ -n "$(which direnv 2>/dev/null)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
  # export DIRENV_WARN_TIMEOUT=100s

  # See https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1
  show_virtual_env() {
    if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
        echo "($(basename $VIRTUAL_ENV))"
    fi
    }
    export -f show_virtual_env
    PS1='$(show_virtual_env) '$PS1
fi
