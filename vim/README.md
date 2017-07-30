# Falkor's Dotfiles -- vim configuration

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_vim.png)

## Installation

You can use the `install.sh` script featured with the [Falkor's dotfile](https://github.com/Falkor/dotfile) repository.

``` bash
$> cd ~/.config/dotfiles.falkor.d
$> ./install.sh --vim      # OR ./install.sh --with-vim
```
This will setup the configuration files in `~/.config/vim`, following the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/)
To be able to inform vim about this 'exotic' location (ssuming the `$XDG_*` variables are configured in your shell), you need to setup the environment variable `$VIMINIT` as follows (see `shell/available/vim.sh`):

~~~bash
# XDG compliant setup for vim
# Assuming you install your vim configuration under ~/.config/vim/vimrc as done
# by default by Falkor's dotfiles -- see https://github.com/Falkor/dotfiles
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
~~~

Upon the first launch, vim will also setup the directory `~/.cache/vim/` to host in particular the packages installed automatically with [NeoBundle](https://github.com/Shougo/neobundle.vim/blob/master/doc/neobundle.txt).

## Uninstall

``` bash
$> cd ~/.config/dotfiles.falkor.d
$> ./install.sh --delete --vim
```

## Customizations

* define your own custom bundle in `~/.vimrc.local.bundles`
* use `.vimrc.local` to place your local custom vim code.
