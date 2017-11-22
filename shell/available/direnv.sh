# Custom load for direnv
# See https://direnv.net/

if [ -n "$(which direnv)" ]; then
  shell=$(echo $(basename $SHELL))
  eval "$(direnv hook $shell)"
fi
