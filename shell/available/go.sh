
if [ -x "$(command -v go 2>/dev/null)" ]; then
	export GOPATH=${XDG_CACHE_HOME}/go
	export PATH=${GOPATH}/bin:$PATH
fi
