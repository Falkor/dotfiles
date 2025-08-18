# Wrapper for pipx
# See https://github.com/pypa/pipx
#

if [ -x "$(command -v pipx 2>/dev/null)" ]; then
  # Add ~/.local/bin
  if [ -n "${XDG_CACHE_HOME}" ]; then
    export PATH="${XDG_CACHE_HOME}/bin:$PATH"
  fi
  # pipx completions
  # eval "$(register-python-argcomplete pipx)"
fi
