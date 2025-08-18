# Customization for curl, assuming XDG Base Directory setup
# See https://specifications.freedesktop.org/basedir-spec/latest/
# Place this file in the custom directory settings for your favorite shell

if [ -x "$(command -v curl 2>/dev/null)" ]; then
	export CURL_HOME="$XDG_CONFIG_HOME/curl"
fi
