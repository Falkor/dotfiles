# DEPRECATED!!! Falkor's Dotfiles -- Bourne-Again Shell (bash) configuration

**IMPORTANT**: consider these configurations as deprecated and obsolete. You should better switch to [oh-my-bash](https://github.com/ohmybash/oh-my-bash) as instructed [here](https://gitlab.com/svarrette-anssi/tutorial-git/-/blob/main/docs/TP/config.md?ref_type=heads#bash-oh-my-bash)

> [Oh-My-Bash](https://ohmybash.github.io/) is an open source, community-driven framework for managing your [BASH](https://www.gnu.org/software/bash/) configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout..."

See the available [themes](https://github.com/ohmybash/oh-my-bash/blob/master/themes/THEMES.md) to find your prefered one.
Below instuctions will setup the minimalist [`purity` theme](https://github.com/ohmybash/oh-my-bash/blob/master/themes/THEMES.md#purity)

```bash
# Preliminaries: install fonts and dependencies
sudo apt install curl fontconfig fonts-powerline fonts-font-awesome
# Install oh-my-bash: download installer, check it and run it
curl -fsSL --skip-existing -o /tmp/oh-my-bash-installer.sh \
   https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh 
less /tmp/oh-my-bash-installer.sh  # review installer
bash /tmp/oh-my-bash-installer.sh  # run it
# adapting theme
sed -i 's/OSH_THEME=\"font\"/OSH_THEME=\"purity\"/' ~/.bashrc
# Enjoy !
source ~/.bashrc
# cleanup
rm /tmp/oh-my-bash-installer.sh
```

## Old README content

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_bash.png)

## Installation

You can use the `install.sh` script featured with the [Falkor's dotfile](https://github.com/Falkor/dotfile) repository.

``` bash
cd ~/.dotfiles.falkor.d
./install.sh --bash   
```
This will setup the following files:

* `~/.bashrc`
* `~/.inputrc`
* `~/.bash_profile`
* `~/.bash_aliases`

## Uninstall

``` bash
cd ~/.dotfiles.falkor.d
./install.sh --delete --bash
```

## Customizations

Use the `~/.bash_private` as a place holder for your own customization. This file is loaded by the `.bashrc` file.
