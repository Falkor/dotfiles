# asdf - Multiple Runtime Version Manager
# See https://asdf-vm.com/
#
# Installation in a (tentative) XDG compliant way
#   git clone https://github.com/asdf-vm/asdf.git ~/.local/share/asdf --branch v0.15.0
# See https://github.com/asdf-vm/asdf/issues/687
#
# Below are config to 'simulate' XDG behaviour through
# https://asdf-vm.com/manage/configuration.html

if [ -d "${XDG_DATA_HOME}/asdf" ]; then
  export ASDF_DIR="${XDG_DATA_HOME}/asdf" # location of asdf core scripts
  # location where asdf will install plugins, shims and tool versions.
  export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
  if [ -f "${ASDF_DIR}/asdf.sh" ]; then
    .  "${ASDF_DIR}/asdf.sh"
  fi

  # Setup completion
  if [[ -n ${ZSH_VERSION-}  ]]; then
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
  else
    if [ -f "${ASDF_DIR}/completions/asdf.$(basename $SHELL)" ]; then
      . "${ASDF_DIR}/completions/asdf.$(basename $SHELL)"
    fi
  fi

  # https://asdf-vm.com/manage/configuration.html#asdfrc
  export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"

  # https://github.com/asdf-community/asdf-python#default-python-packages
  export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/asdf/default-python-packages"

  # https://github.com/asdf-vm/asdf-nodejs#default-npm-packages
  export ASDF_NPM_DEFAULT_PACKAGES_FILE="$HOME/.config/asdf/default-npm-packages"

fi
