This project is released under the terms of the [GPL-3.0 Licence](LICENSE). So you are more than welcome to contribute to its development as follows:

1. [Fork](https://help.github.com/articles/fork-a-repo/) it.
2. Clone your _forked_ copy of this repository as follows (adapt accordingly):

        $> mkdir -p ~/git/github.com/<YOUR_LOGIN>
        $> cd ~/git/github.com/<YOUR_LOGIN>
        $> git clone https://github.com/<YOUR_LOGIN>/dotfiles.git

3. **`/!\ IMPORTANT`**: Once cloned, initiate your local copy of the repository ([Git-flow](https://github.com/nvie/gitflow), Git [submodules](.gitmodules) etc.) by running:

        $> cd dotfiles
		$> make setup

4. Create your own feature branch

          $> git checkout -b my-new-feature

5. Commit your changes (`git commit -am 'Added some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new [Pull Request](https://help.github.com/articles/using-pull-requests/) to submit your changes to me.

This assumes that you have understood the [directory tree structure](layout.md) of this repository.

Finally, you shall be aware of the way the [semantic versioning](versioning.md) procedure of this Puppet module are handled.
