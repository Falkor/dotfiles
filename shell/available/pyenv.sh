# Initialization of the pyenv and pyenv-virtualenv
# - pyenv: https://github.com/pyenv/pyenv
# - pyenv-virtualenv: https://github.com/pyenv/pyenv-virtualenv

if [ -n "$(which pyenv 2>/dev/null)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
