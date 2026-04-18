# gitlab CLI 
# see https://docs.gitlab.com/cli/

if [ -x "$(command -v glab 2>/dev/null)" ]; then
  if [[ -n ${ZSH_VERSION-} ]]; then
    # zsh completion
    source <(glab completion -s zsh); compdef _glab glab
  else
    # bash completion
    source <(glab completion -s bash)
  fi
fi
