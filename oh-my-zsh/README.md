# Falkor's Dotfiles -- OhMyZSH Customization

![](http://ohmyz.sh/img/OMZLogo_BnW.png)

> [Oh-My-Zsh](http://ohmyz.sh) is an open source, community-driven framework for managing your ZSH configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout...

So I use [Oh-My-Zsh](http://ohmyz.sh) using the excellent [powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt theme and the [Darkside iTerm Color scheme](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Darkside.itermcolors).

The font I use is [Meslo Nerd Font patched for Powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) at 15pt (for both Regular and Non-ASCII font).
You can find more information on  the way I configured iTerm2 on [my blog](https://varrette.gforge.uni.lu/blog/2017/01/17/configuring-mac-os-on-your-brand-new-laptop/#iterm2-configuration).

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_iterm.png)

## Pre-requisites

### Dependency packages

Install [fzf](https://github.com/junegunn/fzf)

### Meslo Nerd Font patched for Powerlevel10k

See [instructions from powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k): if you are using iTerm2 or Termux, `p10k configure` can install the recommended font for you. Simply answer Yes when asked whether to install Meslo Nerd Font.

### Alternative: [Source Code Pro Patched fonts](https://github.com/Falkor/dotfiles/blob/master/fonts/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf)

You should install the [Source Code Pro Patched fonts](https://github.com/Falkor/dotfiles/raw/master/fonts/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf) following [these instructions](https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#step-2-install-powerline-fonts) yet adapted to this font.

### [Darkside](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Darkside.itermcolors) Color Scheme

![](https://github.com/mbadolato/iTerm2-Color-Schemes/raw/master/screenshots/darkside.png)

You can find it (and many other color schemes) on <http://iterm2colorschemes.com/> and within [the associated  github repository](https://github.com/mbadolato/iTerm2-Color-Schemes) (under `scheme/`).

Install it within [iTerm2](https://www.iterm2.com/) by picking `Darkside[.itermcolors]` under `iTerm Preferences / Profiles / Colors / Load Presets`.
You'll have to repeat it for all your profiles.

## Falkor's Custom plugin for Oh-My-ZSH

Lots of things I do every day have been shortened within one, two or three character mnemonic aliases.
You can find these aliases (together with my prompt customization) under the form of a [custom plugin for oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization) named... [`Falkor`](custom/plugins/falkor/falkor.plugin.zsh)

See [`falkor.plugin.zsh`](custom/plugins/falkor/falkor.plugin.zsh) for more details.

## Installation, the lazy way

* [Install zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
* [Install Oh-My-ZSH](http://ohmyz.sh/)

        $> sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

* Clone [Falkor's dotfile](https://github.com/Falkor/dotfile) as suggested, _i.e._

        $> git clone https://github.com/Falkor/dotfiles.git ~/.config/dotfiles.falkor.d

Now run:

``` bash
$> cd ~/.config/dotfiles.falkor.d
$> ./install.sh -n --zsh     # DRY_RUN - OR ./install.sh -n --with-zsh
$> ./install.sh --zsh        # OR ./install.sh --with-zsh
```

This will configure the following components:

* `~/.zshenv`
* `~/.config/zsh`
* `~/.local/share/oh-my-zsh` (Oh-My-ZSH)
* `$ZSH_CUSTOM`, pointing to `~/.config/zsh/custom`


## Uninstall

``` bash
$> cd ~/.dotfiles.falkor.d
$> ./install.sh --delete --zsh
```


## Customizations

you can define your own aliases under `~/.oh-my-zsh/custom/private_aliases.zsh` (which is **not meant to be tracked** thus ignored within [Falkor's dotfiles `oh-my-zsh/custom/.gitignore`](.gitignore) for instance).

Follow also [this guide from Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization) for more details.

In particular, you can install the following completions:

```bash
git clone https://github.com/sunlei/zsh-ssh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-ssh
```


## Note on [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme configuration

You might wish to reproduce my configuration of [Powerlevel10k](https://github.com/romkatv/powerlevel10k) as depicted in the above screenshot yet without installing my dotfiles.

* Install the [recommended fonts](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
* Install [Powerlevel10k for your plugin manager](https://github.com/romkatv/powerlevel10k#get-started)
    - Set `ZSH_THEME="powerlevel10k/powerlevel10k`
* Copy [`p10k-falkor.zsh`](.p10k.zsh) into `$ZSH/.p10k.zsh`
* Restart zsh

See also [the official prompt customization guide](https://github.com/bhilburn/powerlevel9k#prompt-customization) for alternative segments you might wish to integrate.




