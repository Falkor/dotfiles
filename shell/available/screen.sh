# Specific configuration for screen
# See https://github.com/Falkor/dotfiles/tree/master/screen

if [ -n "$(which screen 2>/dev/null)" ]; then
  export SCREENRC=~/.config/screen/screenrc
fi
