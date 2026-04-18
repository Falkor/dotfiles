# Wrapper for uv, an extremely fast Python package and project manager, written in Rust
# See https://docs.astral.sh/uv/

if [ -x "$(command -v uv 2>/dev/null)" ]; then
  if [[ -n ${ZSH_VERSION-} ]]; then
    # zsh completion
    eval "$(uv generate-shell-completion zsh)"
    # /usr/share/zsh/site-functions/_toolbox
  else
    # bash completion
    # /usr/share/bash-completion/completions/toolbox.bash
  fi
fi
