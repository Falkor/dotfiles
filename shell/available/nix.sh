# Nix installer
#

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer

if [ -x "$(command -v nix 2>/dev/null)" ]; then
  # Bugfix locales - see https://nixos.wiki/wiki/Locales
  # Assumes you have run:
  #    nix-env -iA nixpkgs.glibcLocales
  export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
fi


