# Falkor's Dotfiles -- vim configuration

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_vim.png)

## Installation

You can use the `install.sh` script featured with the [Falkor's dotfile](https://github.com/Falkor/dotfile) repository.

``` bash
$> cd ~/.dotfiles.falkor.d
$> ./install.sh --vim      # OR ./install.sh --with-vim
```
This will setup the following files:

* `~/.vimrc`

Upon the first launch, vim will also setup the directory `~/.vim/` to host in particular the packages installed automatically with [NeoBundle](https://github.com/Shougo/neobundle.vim/blob/master/doc/neobundle.txt).

## Uninstall

``` bash
$> cd ~/.dotfiles.falkor.d
$> ./install.sh --delete --vim
```

## Customizations

* define your own custom bundle in `~/.vimrc.local.bundles`
* use `.vimrc.local` to place your local custom vim code.
