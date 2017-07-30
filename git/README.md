# Falkor's Dotfiles -- some git configuration

![](https://git-scm.com/images/logo@2x.png)

[Git](https://git-scm.com/) is probably one of the most awesome productivity tool I use so far.

> [Git](https://git-scm.com/) is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

If you want to know more bout git, you might wish to take a look at the slides I made as an [introduction to git](https://github.com/ULHPC/documents/blob/master/slides/ULHPC_School/2015/intro_git/intro_git.pdf) during the [UL HPC School](https://hpc.uni.lu/hpc-school/2015/06/index.html).
See also the [Git Cheat Sheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf) proposed on Github.

## Git installation

Installation of [Git](http://git-scm.com/) is relatively simple (actually it comes bundled with your system normally):

### Linux / Mac OS

~~~bash
$> apt-get install git-core git-flow # On Debian-like systems
$> yum install git gitflow           # On CentOS-like systems
$> brew install git git-flow         # On Mac OS, using [Homebrew](http://mxcl.github.com/homebrew/)
~~~

### Windows

Use [git-for-windows](https://git-for-windows.github.io/), which includes Git Bash/GUI and  Shell Integration

* use PLINk from Putty
* install Git bash + command prompt
* select checkout windows / commit unix

## Git configuration

The way I organize my git configurations is as follows:

| File                         | Alternative          | Visibility | Description                                    |
|------------------------------|----------------------|------------|------------------------------------------------|
| `~/.config/git/config`       | `~/.gitconfig`       | Public     | general aliases and core/colors configurations |
| `~/.config/git/config.local` | `~/.gitconfig.local` | Private    | username / credentials / private business etc. |
|                              |                      |            |                                                |

Note that this hierarchy assume the availability of the `include.path` directive within Git which was introduced in __Git >= 1.7.10__ (see <http://git-scm.com/docs/git-config#_includes>)

## Installation for Falkor's Git configuration

You can use the `install.sh` script featured with the [Falkor's dotfile](https://github.com/Falkor/dotfile) repository.

``` bash
$> cd ~/.config/dotfiles.falkor.d
$> ./install.sh --git     # OR ./install.sh --with-git
```

## Uninstall

``` bash
$> cd ~/.config/dotfiles.falkor.d
$> ./install.sh --delete --git
```

## Resources

Consider these resources to become more familiar (if not yet) with Git:

* [Simple Git Guide](http://rogerdudler.github.io/git-guide/)
* [Git book](http://book.git-scm.com/index.html)
* [Github:help](http://help.github.com/mac-set-up-git/)
* [Git reference](http://gitref.org/)
* [Git Cheat Sheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf) proposed on Github.
