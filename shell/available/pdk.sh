# https://puppet.com/docs/pdk/1.x/pdk_install.html

# Add /opt/puppetlabs/pdk/bin to the path for sh compatible users
PDKDIR=/opt/puppetlabs/pdk
if [ -d "${PDKDIR}" ]; then
  if ! echo "$PATH" | grep -q "${PDKDIR}/bin" ; then
    export PATH=$PATH:${PDKDIR}/bin
  fi
fi
