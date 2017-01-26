# RVM specific (see http://beginrescueend.com/)

RVM_HOME=$HOME/.rvm

if [ -d "${RVM_HOME}" ]; then
  [[ -s "${RVM_HOME}/scripts/rvm" ]]        && . "${RVM_HOME}/scripts/rvm" # Load RVM function
  [[ -r "${RVM_HOME}/scripts/completion" ]] && . ${RVM_HOME}/scripts/completion
  export PATH="$PATH:${RVM_HOME}/bin" # Add RVM to PATH for scripting
fi
