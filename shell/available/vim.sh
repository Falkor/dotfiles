# XDG compliant setup for vim
# Assuming you install your vim configuration under ~/.config/vim/vimrc as done
# by default by Falkor's dotfiles -- see https://github.com/Falkor/dotfiles
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
