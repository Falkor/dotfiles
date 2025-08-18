# Vagrant aliases
# See also https://www.calebwoods.com/2015/05/05/vagrant-guest-commands/

if [ -x "$(command -v vagrant 2>/dev/null)" ]; then
	alias vup="vagrant up"
	alias vh="vagrant halt"
	alias vs="vagrant status"
	alias v="vagrant ssh"
	vc() {
	  vagrant ssh -c "$@"
	}
fi 
