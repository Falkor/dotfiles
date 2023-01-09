# Wrapper for Advanced-SSH
# See https://github.com/moul/assh
#
if [ -n "$(which assh)" ]; then
  alias ssh="assh wrapper ssh --"
fi
