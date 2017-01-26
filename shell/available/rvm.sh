# RVM specific (see http://beginrescueend.com/)
if [ -d "$HOME/.rvm" ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]]        && . "$HOME/.rvm/scripts/rvm" # Load RVM function
  [[ -r "$HOME/.rvm/scripts/completion" ]] && . $HOME/.rvm/scripts/completion
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi
