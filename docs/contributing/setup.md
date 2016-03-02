There is a number of pre-requisite programs / framework you shall install to be able to correctly contribute to this Puppet module.

### Git Branching Model

The Git branching model for this repository follows the guidelines of
[gitflow](http://nvie.com/posts/a-successful-git-branching-model/).
In particular, the central repository holds two main branches with an infinite lifetime:

* `production`: the *production-ready* branch
* `master`: the main branch where the latest developments interviene. This is the *default* branch you get when you clone the repository.

Thus you are more than encouraged to install the [git-flow](https://github.com/nvie/gitflow) extensions following the [installation procedures](https://github.com/nvie/gitflow/wiki/Installation) to take full advantage of the proposed operations. The associated [bash completion](https://github.com/bobthecow/git-flow-completion) might interest you also.

### Repository Setup

As mentioned in the [installation notes](/), to make your local copy of the repository ready to use the [git-flow](https://github.com/nvie/gitflow) workflow

	    $> make setup

This will also initiate the [Git submodules of this repository](.gitmodules).
