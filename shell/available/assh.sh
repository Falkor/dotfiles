# Wrapper for Advanced-SSH
# See https://github.com/moul/assh
#
if [ -x "$(command -v assh 2>/dev/null)" ]; then
  alias ssh="assh wrapper ssh --"
fi
