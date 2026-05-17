# Packer aliases
# See also https://developer.hashicorp.com/packer/docs/commands#autocompletion

if [ -x "$(command -v packer 2>/dev/null)" ]; then
	# Autocompletion 
	if [[ -n ${ZSH_VERSION-} ]]; then
		# zsh 
		autoload -U +X bashcompinit && bashcompinit
		complete -o nospace -C /usr/bin/packer packer
	else 
		# assumes bash 
		complete -C /usr/bin/packer packer
	fi 
fi 
