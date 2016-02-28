-*- mode: markdown; mode: visual-line; -*-

# Falkor's dotfiles Tests with Vagrant

The best way to test these dotfiles in a non-intrusive way is to rely on [Vagrant](http://www.vagrantup.com/).
[Vagrant](http://vagrantup.com/) uses [Oracle's VirtualBox](http://www.virtualbox.org/) to build configurable, lightweight, and portable virtual machines dynamically.

* [Reference installation notes](http://docs.vagrantup.com/v2/installation/) -- assuming you have installed [Oracle's VirtualBox](http://www.virtualbox.org/)
* [installation notes on Mac OS](http://sourabhbajaj.com/mac-setup/Vagrant/README.html) using [Homebrew](http://brew.sh/) and [Cask](http://sourabhbajaj.com/mac-setup/Homebrew/Cask.html)

The `Vagrantfile` at the root of the repository pilot the provisioning of many vagrant boxes generated through the [vagrant-vms](https://github.com/falkor/vagrant-vms) repository and available on [Vagrant cloud](https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=virtualbox&q=svarrette).

You can list the available vagrant box as follows:

       $> vagrant status
	   Current machine states:

       centos-7                  not created (virtualbox)
	   debian-7                  not created (virtualbox)

       This environment represents multiple VMs. The VMs are all listed
	   above with their current state. For more information about a specific
	   VM, run `vagrant status NAME`.

As suggested, you can run a debian 7 machine for instance by issuing:

      $> vagrant up debian-7

Then you can ssh into the machine afterwards:

      $> vagrant ssh debian-7

Once within the box, feel free to try my dotfiles. You can install them by running:

      $> /vagrant/install.sh      # /vagrant mounts the root of the Falkor's dotfile repository
      $> chsh -s $(which zsh)     # Set zsh as the login shell
