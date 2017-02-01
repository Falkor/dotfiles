# RVM specific (see http://beginrescueend.com/)

RVM_HOME=$HOME/.rvm

if [ -d "${RVM_HOME}" ]; then
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"
  [[ -s "${RVM_HOME}/scripts/rvm" ]]        && . "${RVM_HOME}/scripts/rvm" # Load RVM function
  [[ -r "${RVM_HOME}/scripts/completion" ]] && . ${RVM_HOME}/scripts/completion
fi
