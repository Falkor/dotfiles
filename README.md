-*- mode: markdown; mode: auto-fill; fill-column: 80 -*-

`README.md`

      Time-stamp: <Tue 2011-01-25 17:35 svarrette>

Copyright (c) 2011 [Sebastien Varrette](http://varrette.gforge.uni.lu)
 
---------
# Sebastien Varrette Dot Files

These are my configuration files for `bash`, `git`, `vim` etc. so as to set up a
system the way I like it. 

In the sequel, when providing a command, `$>` denotes a prompt and is not part of the commands. 

## Pre-requisites

You should install the following elements to use the full functionality of these config files. 

### Mac OS X 

There exists several package manager under Mac to install open-source software. 
I recommend [Macports](http://www.macports.org/) or [Homebrew](http://mxcl.github.com/homebrew/)
The Macports packages you should install (I'm sure you'll find alone the Homebrew equivalents) are the following ones: 

      	bash-completion
		git-core +bash_completion +svn +doc +gitweb

Note that `vim` should be installed by default.  

### Linux Debian 

Under Lenny, configure the [backports](http://backports.debian.org/) to get the version 1.7 of git (which include the bash function `__git_ps1`). In this purpose, follow [these instructions](http://backports.debian.org/Instructions/) and run the following commands: 

		$> apt-get -t lenny-backports install git
		$> apt-get install bash-completion vim

	
## Installation

Run the following commands: 
	
		$> git clone git://github.com/Falkor/dotfiles ~/.dotfiles.github.d
		$> cd 
		$> mv .bashrc .bashrc.old
		$> ln -s .dotfiles.github.d/bash/.bashrc    .
		$> ln -s .dotfiles.github.d/bash/.inputrc   .
		$> ln -s .dotfiles.github.d/vim/.vimrc      .
		$> ln -s .dotfiles.github.d/git/.gitconfig  .
		$> mkdir bin 
		$> cd bin
		$> ln -s ../.dotfiles.github.d/bin/git-changelog .

One day I will take some time to do an installation script ;)

In all cases, the next step if to ensure that your `~/.bashrc` is really invoked when bash is run. 
For this, ensure you have the following lines in your file `~/.profile` (create it if necessary):

	if [ -f ~/.bashrc ]; then 
		. ~/.bashrc
	fi


## Environment

I am running primarily on Mac OS X, otherwise on Debian so these config files
will likely work on your system, eventually with a little tweaking. 

## BUGS

Find a bug? Just post a new issue on [Github](https://github.com/Falkor/dotfiles/issues)!

## DISCLAIMER

My `dotfiles` are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

## AUTHOR
 
[Sebastien Varrette](http://varrette.gforge.uni.lu), using various contributions on the Internet, in particular: 

*  [Derek Payton dotfiles](http://bitbucket.org/dmpayton/dotfiles/src/tip/.bashrc)
*  [Ryan Tomayko dotfiles](http://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc)

As often, I release these files under GNU GPL Licence v3. You may use, modify, and/or redistribute them under the terms of the GPL Licence v3.

-------
