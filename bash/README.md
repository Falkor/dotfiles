# Falkor's Dotfiles -- Bourne-Again Shell (bash) configuration

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_bash.png)

## Installation

You can use the `install.sh` script featured with the [Falkor's dotfile](https://github.com/Falkor/dotfile) repository.

``` bash
$> cd ~/.dotfiles.falkor.d
$> ./install.sh --bash     # OR ./install.sh --with-bash
```
This will setup the following files:

* `~/.bashrc`
* `~/.inputrc`
* `~/.bash_profile`
* `~/.bash_aliases`

## Uninstall

``` bash
$> cd ~/.dotfiles.falkor.d
$> ./install.sh --delete --bash
```

## Customizations

Use the `~/.bash_private` as a place holder for your own customization. This file is loaded by the `.bashrc` file.
