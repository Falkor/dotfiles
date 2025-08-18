# gpg-agent - Secret key management for GnuPG configuration
#
# Daemon to manage secret (private) keys independently from any protocol
# The agent is automatically started on demand by gpg, gpgconf, or gpg-connect-agent
# After changing the configuration, reload the agent with
#             gpg-connect-agent reloadagent /bye
#
if [ -x "$(command -v gpg-agent 2>/dev/null)" ]; then
    # check if ssh-support is enable in your gpg-agent config
    if [ -f $(gpgconf --list-dirs homedir)/gpg-agent.conf ] && [ -n "$(grep -ve '^#' $(gpgconf --list-dirs homedir)/gpg-agent.conf | grep enable-ssh-support)" ]; then
        export GPG_TTY=$(tty)
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        gpgconf --launch gpg-agent
    fi
fi
