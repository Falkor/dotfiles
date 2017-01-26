# Autojump -- a faster way to navigate your filesystem
# Use
#      j  <pattern>
#
# To cd into the recent directory you visited those fullpath matches
# <pattern>
#
# For more info: https://github.com/wting/autojump

AUTOJUMP_CONFIG="/usr/local/etc/profile.d/autojump.sh"

[ -f "${AUTOJUMP_CONFIG}" ] && . ${AUTOJUMP_CONFIG} || true
