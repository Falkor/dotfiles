
This dotfile repository is organized as follows:

~~~bash
.
├── LICENSE         # GPL v3 Licence
├── Makefile        # GNU Make configuration
├── README.md       # This file
├── VERSION         # /!\ DO NOT EDIT. Current repository version
├── Vagrantfile     # Pilot Vagrant to test this repository
├── bash/
│   ├── .bashrc     # bash configuration
│   └── .inputrc    # readline configuration
├── bin/            # some bin scripts
├── docs/           # [Read the Docs](readthedocs.org) main directory
├── emacs           # [My emacs configuration](https://github.com/Falkor/emacs-config2/)
├── git/            # My git configuration
├── install.sh      # Installation script
├── mkdocs.yml      # [Read the Docs](readthedocs.org) configuration
├── oh-my-zsh/
│   └── custom
│       ├── *.zsh   # Some custom ZSH [completion] files
│       ├── plugins
│       │   ├── falkor
│       │   │   └── falkor.plugin.zsh   # personal ZSH aliases / functions
│       │   └── zsh-completions         # plugin to integrate zsh-completions to oh-my-zsh
│       └── private_aliases.zsh         # NOT MEANT TO BE TRACKED
├── screen/         # GNU screen configuration
├── screenshots/    # screenshots to illustrate my configs
└── vim/            # Vim configuration
~~~
