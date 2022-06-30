# https://puppet.com/docs/pdk/1.x/pdk_install.html

# Add /opt/puppetlabs/bin to the path for sh compatible users
if ! echo "$PATH" | grep -q /opt/puppetlabs/pdk/bin ; then
  export PATH=$PATH:/opt/puppetlabs/pdk/bin
fi
