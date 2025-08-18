# NVM: Node Version Manager
# See https://github.com/nvm-sh/nvm


if [ -x "$(command -v nvm 2>/dev/null)" ]; then
	
	[[ -n ${ZSH_VERSION-} ]] && setopt no_aliases
	
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"  # This loads nvm
	[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
	
	[[ -n ${ZSH_VERSION-} ]] && setopt aliases
fi 
