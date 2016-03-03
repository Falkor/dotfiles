-*- mode: markdown; mode: visual-line; fill-column: 80 -*-

-------------------------------------
# Automatic Tests of Falkor/dotfiles

These tests are based on [Bats](https://github.com/sstephenson/bats): Bash Automated Testing System.
Coupled with [Travis-CI](https://docs.travis-ci.com/), it offers a nice continuous integration framework -- see [Travis CI for Complete Beginners](https://docs.travis-ci.com/user/for-beginners)


## Pre-requisites

### Bats installation

I made a `setup_bats.sh` script for that (also for easier integration with travis) which roughly performs the following actions:

* On Mac OS: use [Homebrew](http://brew.sh/) to install the `bats` package
* On Linux system, a manual installation is performed under `/tmp/local/bin` (to ensure a full compliance with Travis virtualized boxes), which consists in:

   ```bash
   $> git clone https://github.com/sstephenson/bats.git /tmp/bats
   $> mkdir -p /tmp/local
   $> bash /tmp/bats/install.sh /tmp/local
   $> export PATH=$PATH:/tmp/local/bin
   ```

Note that their is normally a way to rely on Debian packages yet I never managed to make it work.
For the records, the procedure would have been:

```bash
$> apt-get install software-properties-common python-software-properties  # to get 'add-apt-repository'
$> add-apt-repository ppa:duggan/bats --yes
$> apt-get update -qq
$> apt-get install -qq bats
```

However the package repository does not work any more

    W: Failed to fetch http://ppa.launchpad.net/duggan/bats/ubuntu/dists/wheezy/main/binary-amd64/Packages  404  Not Found

### Travis integration

Take a look at the repository [.travis.yml](../.travis.yml)

## Directory Layout

```bash
tests/
├── *.bats            # The bats files, each defining a set of unit tests
├── README.md         # This file
└── setup_bats.sh     # run/source this file to install Bats on your system
```

## Run the tests

Simply run

     $> bats .       # from the tests directory

OR, from the root repository

     $> make tests   # from the root directory of the dotfiles repository

## Resources

You might find the below links interestings:

* [Bats Wiki](https://github.com/sstephenson/bats/wiki) and [Homepage](https://github.com/sstephenson/bats)
* [How to use Bats to test your command line tools](https://blog.engineyard.com/2014/bats-test-command-line-tools)
