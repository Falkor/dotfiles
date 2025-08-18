# http://easybuild.readthedocs.io/en/latest/Installation.html

if [ -x "$(command -v eb 2>/dev/null)" ]; then
	export EASYBUILD_PREFIX=$HOME/.local/easybuild
	export EASYBUILD_MODULES_TOOL=Lmod
fi
