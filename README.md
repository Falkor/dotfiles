-*- mode: markdown; mode: visual-line; fill-column: 80 -*-

[![Licence](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html) ![By Falkor](https://img.shields.io/badge/by-Falkor-blue.svg) [![github](https://img.shields.io/badge/git-github-lightgray.svg)](https://github.com/Falkor/dotfiles) [![Issues](https://img.shields.io/badge/issues-github-green.svg)](https://github.com/Falkor/dotfiles/issues)
[![Documentation Status](https://readthedocs.org/projects/falkor-dotfiles/badge/?version=latest)](https://readthedocs.org/projects/falkor-dotfiles/?badge=latest)

        Time-stamp: <Mon 2016-02-29 14:21 svarrette>

         ______    _ _             _       _____        _    __ _ _
        |  ____|  | | |           ( )     |  __ \      | |  / _(_) |
        | |__ __ _| | | _____  _ __/ ___  | |  | | ___ | |_| |_ _| | ___ ___
        |  __/ _` | | |/ / _ \| '__|/ __| | |  | |/ _ \| __|  _| | |/ _ \ __|
        | | | (_| | |   < (_) | |   \__ \ | |__| | (_) | |_| | | | |  __\__ \
        |_|  \__,_|_|_|\_\___/|_|   |___/ |_____/ \___/ \__|_| |_|_|\___|___/


       Copyright (c) 2011-2016 Sebastien Varrette aka Falkor <Sebastien.Varrette@uni.lu>

# Sebastien Varrette aka Falkor's dotfiles

These are my configuration files for `bash`, `zsh`, `git`, `vim` etc. so as to set up a system the way I like it.
For instance, here is a screenshot of my terminal illustrating its behaviour on classical contexts commonly met on a daily usage of interactions with git repositories etc.

![](screenshots/screenshot_falkor_iterm.png)

__Warning:__ Use these dotfiles at your own risk!

In the sequel, when providing a command, `$>` denotes a prompt and is not part of the commands.

## Pre-requisites

You should install the following elements to use the full functionality of
these config files:

* bash
* bash-completions
* zsh
* zsh-completions
* screen
* git
* subversion
* vim
* ssh

## Installation

### Using Git and the embedded Makefile

This repository is hosted on [Github](https://github.com/Falkor/dotfiles). You can clone the repository wherever you want.
Personally, I like to keep it in `~/git/github.com/Falkor/dotfiles`, with `~/.dotfiles.falkor.d` as a symlink.
Othoerwise, to clone this repository directly into `~/.dotfiles.falkor.d/`, proceed as follows

        $> git clone https://github.com/Falkor/dotfiles.git ~/.dotfiles.falkor.d

**`/!\ IMPORTANT`**: Once cloned, initiate your local copy of the repository by running:

	    $> cd ~/.dotfiles.falkor.d
	    $> make setup

This will initiate the [Git submodules of this repository](.gitmodules) and setup the [git flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) layout for this repository.

Now to install all my dotfiles, run:

        $> make install

### Git-free install

TODO (with curl over `install.sh`)

## Updating / Upgrading

Upgrading is normally as simple as:

     $> make -C ~/.dotfiles.falkor.d update

OR, if you prefer a more atomic approach:

     $> cd ~/.dotfiles.falkor.d
     $> git pull
     $> make update

Note that if you wish to upgrade the [Git submodules](.gitmodules) to the latest version, you should run:

     $> make update

## What's included and how to customize?

| Tools                                                      | Description                  | Type                  | Documentation                                |
|------------------------------------------------------------|------------------------------|-----------------------|----------------------------------------------|
| [bash](http://tiswww.case.edu/php/chet/bash/bashtop.html)  | Bourne-Again shell           | shell                 | [`bash/README.md`](bash/README.md)           |
| [zsh](http://www.zsh.org/) / [Oh-my-zsh](http://ohmyz.sh/) | Z shell                      | shell                 | [`oh-my-zsh/README.md`](oh-my-zsh/README.md) |
| [vim](http://www.vim.org/)                                 | VI iMproved                  | editor                | [`vim/README.md`](vim/README.md)             |
| [emacs](https://www.gnu.org/software/emacs/)               | GNU Emacs                    | editor                | `emacs/README.md`                            |
| [git](https://git-scm.com/)                                | `git --fast-version-control` | VCS                   | [`git/README.md`](git/README.md)             |
| [screen](https://www.gnu.org/software/screen/)             | GNU screen                   | terminal multiplexers | [`screen/README.md`](screen/README.md)       |
|                                                            |                              |                       |                                              |

## Issues / Feature request

You can submit bug / issues / feature request using the [`Falkor/dotfiles` Project Tracker](https://github.com/Falkor/dotfiles/issues)

## Developments / Contributing to the code

If you want to contribute to the code, you shall be aware of the way this repository is organized and developed.
These elements are detailed on `docs/contributing/`

## Licence

This project is released under the terms of the [GPL-3.0](LICENCE) licence.

[![Licence](https://www.gnu.org/graphics/gplv3-88x31.png)](http://www.gnu.org/licenses/gpl-3.0.html)

## Resources

You can find of course many other resources in terms dotfiles repositories.
I suggest you to take a look at the following places I inspired:

* [Your unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/)
* My friend [H.Cartiaux's dotfiles](https://github.com/hcartiaux/dotfiles)
* [Holman's does dotfiles](https://github.com/holman/dotfiles), for his idea of bundling the [homebrew](http://brew.sh) configuration
* [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles),  for featuring `~/.osx` _i.e._ sensible hacker defaults for OS X;
* [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles), a curated list of dotfiles resources. Inspired by the [awesome](https://github.com/sindresorhus/awesome) list thing.
