# Wrapper for Advanced-SSH
# See
#
if [ -n "$(which assh)" ]; then
  alias ssh="assh wrapper ssh --"
fi
