# Custom load for direnv
# See https://direnv.net/

if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
  # export DIRENV_WARN_TIMEOUT=100s
fi
