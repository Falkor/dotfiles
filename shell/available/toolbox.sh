# Wrapper for toolbx
# See https://containertoolbx.org/

if [ -x "$(command -v toolbox 2>/dev/null)" ]; then
  if [[ -n ${ZSH_VERSION-} ]]; then
    # zsh completion
    # /usr/share/zsh/site-functions/_toolbox
  else
    # bash completion
    # /usr/share/bash-completion/completions/toolbox.bash
  fi
fi
