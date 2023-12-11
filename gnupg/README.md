# GPG:  Gnu Privacy Guard

* Old resources, still usefull: 
   * [Tutorial](https://futureboy.us/pgp.html) + [personnal Tutorial](https://varrette.gforge.uni.lu/blog/2017/03/14/tutorial-gpg-gnu-privacy-guard/)
   * [GPG Keypairs](https://stelfox.net/knowledge_base/linux/gpg_keypairs/)
   * [Generating More Secure GPG Keys: A Step-by-Step Guide](https://spin.atomicobject.com/2013/11/24/secure-gpg-keys-guide/)

* [Guide to using YubiKey for GPG and SSH](https://github.com/drduh/YubiKey-Guide)      
* [OpenPGP Best Practices](https://riseup.net/en/security/message-security/openpgp/best-practices)  
* [GnuPG](https://www.gnupg.org/): implementation of the OpenPGP standard aka [RFC4880](http://www.ietf.org/rfc/rfc4880.txt)
   - Hybrid encryption framework based on [Web of Trust](https://en.wikipedia.org/wiki/Web_of_trust)
    - `Mail | Document | Git commit...` encryption / signature


![](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/PGP_diagram.svg/575px-PGP_diagram.svg.png)

[TOC]

## Installation

Apart from the below (preferred) solutions per OS, a cross-platform approach relies on Thunderbird and the [Enigmail](https://enigmail.wiki/) extension.

### Linux/BSD

* Install the `gnupg` package.
* You might also consider [GPGME -- GnuPG Made Easy]() -- [tutorial](http://www.nico.schottelius.org/docs/a-small-introduction-for-using-gpgme/)

### Mac OS X

* Install the [GPGTools Suite](https://gpgtools.org/)
    - GPG for Apple Mail and GPG Keychain
	- GPhttps://github.com/Falkor/dotfiles/blob/master/gnupg/gpg.confG Services and MacGPG

### Windows

[Gpg4win](http://www.gpg4win.org/) (GNU Privacy Guard for Windows) is the reference package implementation to use [GPG](https://www.gnupg.org/) under windows -- [tutorial](https://www.deepdotweb.com/2015/02/21/pgp-tutorial-for-windows-kleopatra-gpg4win/)

It includes the following programs:

* __GnuPG__, which forms the heart of Gpg4win - the actual encryption software.
* __Kleopatra__, the central certificate administration of Gpg4win, which ensures uniform user navigation for all cryptographic operations.
* __GNU Privacy Assistant (GPA)__, an alternative program for managing certificates, in addition to Kleopatra.
* __GnuPG for Outlook (GpgOL)__, an extension for Microsoft Outlook 2003 and 2007, which is used to sign and encrypt messages.
* __GPG Explorer eXtension (GpgEX)__, an extension for Windows Explorer which can be used to sign and encrypt files using the context menu.
* __Claws Mail__, a full e-mail program that offers very good support for GnuPG.

## Configuration 

see `{gpg,dirmngr,gpg-agent}.conf` which are provided as [part of my personnal dotfiles](https://github.com/Falkor/dotfiles/tree/master/gnupg).

Enable them as follows:

```bash
cd ~/.gnupg
ln -s ../path/to/dotfile/repo/gnupg config.gnupg.d  # convenient directory 
ln -s config.gnupg.d/gpg.conf .      
ln -s config.gnupg.d/dirmngr.conf .
ln -s config.gnupg.d/gpg-agent.conf .
```

#### Pinentry

You can configure your favorite pinentry program to prompt for your GPG passphrase/PIN

```bash
# Debian-like systems
$ sudo apt install pinentry-curses pinentry-qt pinentry-gtk2	
$ sudo update-alternatives --config pinentry
There ahttps://github.com/Falkor/dotfiles/blob/master/gnupg/gpg.confre 5 choices for the alternative pinentry (providing /usr/bin/pinentry).

  Selection    Path                      Priority   Status
------------------------------------------------------------
* 0            /usr/bin/pinentry-gnome3   90        auto mode
  1            /usr/bin/pinentry-curses   50        manual mode
  2            /usr/bin/pinentry-gnome3   90        manual mode
  3            /usr/bin/pinentry-gtk-2    85        manual mode
  4            /usr/bin/pinentry-qt       80        manual mode
  5            /usr/bin/pinentry-tty      30        manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
update-alternatives: using /usr/bin/pinentry-curses to provide /usr/bin/pinentry (pinentry) in manual mode
```

Note that when using `pinentry-{tty,ncurses}`, it may happen that you don't get access to the pinentry program. It's most likely a problem tied to the GPG_TTY environnement variable - ensure you set somewhere in your shell

```bash
export GPG_TTY=$(tty)
```

Alternatively, you can force your GPG agent to reset the tty used (in particular) by your pinentry program.

```bash
gpg-connect-agent "updatestartuptty" /bye >/dev/null
```

Note that managing the correct TTY across multiple tabs in your favorite shell (Guake etc.) can be cumbersome. So it's probably easier to rely on a pinentry GUI like **pinentry-gtk-2**.

## GPG Key Generation

Consider using the  provided script [`scripts/generate-gpg-key`](https://github.com/Falkor/dotfiles/blob/master/gnupg/scripts/generate-gpg-key) which implements and automate the generation of GPG key pairs according to [recommended best practices](https://help.riseup.net/en/security/message-security/openpgp/best-practices).  

```bash
$ ./scripts/generate-gpg-key -h   # help
$ ./scripts/generate-gpg-key 
# By default, operate in a temporary directory 
Working directory: GNUPGHOME = /tmp/user/<uid>/tmp.c26KOD8LdO
=> generating batch file for the master key /tmp/user/<uid>/tmp.c26KOD8LdO/generate-master-key.batch
=> generating master key
gpg: keybox '/tmp/user/<uid>/tmp.c26KOD8LdO/pubring.kbx' created
gpg: === Generating your GPG key ===
gpg: -> Generating master key (for certification only)
gpg: /tmp/user/<uid>/tmp.c26KOD8LdO/trustdb.gpg: trustdb created
gpg: directory '/tmp/user/<uid>/tmp.c26KOD8LdO/openpgp-revocs.d' created
gpg: revocation certificate stored as '/tmp/user/<uid>/tmp.c26KOD8LdO/openpgp-revocs.d/C808C0230ED24EF393EDFCA6EC70200B9BF93DCB.rev'
gpg: done
=== Current GPG key status ===
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
/tmp/user/<uid>/tmp.c26KOD8LdO/pubring.kbx
-----------------------------------------
sec   rsa4096/0x3156CC64BB58247D <date> [C]     
      6D1F481568A1D64F98BF228B3156CC64BB58247D  
uid                   [ultimate] <name> <email>

=> collecting generated Key ID
   Master Key ID for <email>: 6D1F481568A1D64F98BF228B3156CC64BB58247D
=> Generating subkey for 'sign' usage
=> Generating subkey for 'encrypt' usage
=> Generating subkey for 'auth' usage
=== Current GPG key status ===
/tmp/user/<uid>/tmp.c26KOD8LdO/pubring.kbx
-----------------------------------------
sec   rsa4096/0x3156CC64BB58247D <date> [C]     
      6D1F481568A1D64F98BF228B3156CC64BB58247D  
uid                   [ultimate] <name> <email>
ssb   rsa4096/0x48D1E2129D0CCEC6 <date> [S] [expires: <date>]
ssb   rsa4096/0xEE74576ED76B1148 <date> [E] [expires: <date>]
ssb   rsa4096/0x68E5153F63FA7B79 <date> [A] [expires: <date>]

=> exports/backup your public key
=> exports/backup your **private** master key
=> exports/backup your **private** subkeys
=> revocation cerfificate for OpenPGP (master) key 6D1F481568A1D64F98BF228B3156CC64BB58247D:
   /tmp/user/<uid>/tmp.c26KOD8LdO/openpgp-revocs.d/6D1F481568A1D64F98BF228B3156CC64BB58247D.rev
=> export GPG's trustDB to a text file
=> preparing for (optional) SSH support via the GPG subkey with 'A[uth]' usage
   assumes you specify the key to use in sshcontrol file via its keygrip internal identifier
 Current keygrips in use: (gpg -K --with-keygrip [...])
sec   rsa4096/0x3156CC64BB58247D <date> [C]     
      6D1F481568A1D64F98BF228B3156CC64BB58247D  
      Keygrip = 6F165EAF3AF6A678A072841654E6702974A885B3
uid                   [ultimate] <name> <email>
ssb   rsa4096/0x48D1E2129D0CCEC6 <date> [S] [expires: <date>]
      Keygrip = CC34AFAD18486AD790CCA9A708D858057F022FD2
ssb   rsa4096/0xEE74576ED76B1148 <date> [E] [expires: <date>]
      Keygrip = CBE87BF5CB84AE288E4829BE66B286FBCDFEAEAE
ssb   rsa4096/0x68E5153F63FA7B79 <date> [A] [expires: <date>]
      Keygrip = 47A0554C7508280F10E277B40186257857DD6E03

   selected keygrip (subkey with 'A' usage): '47A0554C7508280F10E277B40186257857DD6E03'
=> creating /tmp/user/<uid>/tmp.c26KOD8LdO/sshcontrol
/!\ WARNING: To get gpg-agent to handle requests from SSH, you still need to:
/!\ WARNING: - add 'enable-ssh-support' into ${GNUPGOME}/gpg-agent.conf
/!\ WARNING: - change the value of the SSH_AUTH_SOCK environment variable in your favorite shell configuration (.bashrc,.zshrc etc.)
/!\ WARNING:     export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
/!\ WARNING:     gpgconf --launch gpg-agent
/!\ WARNING: To cleanup the working directory (NOT done by default):
/!\ WARNING:          rm -rf /tmp/user/<uid>/tmp.c26KOD8LdO
```

If you want to generate them in the persistent (expected) directory, use 

```bash
$ export GNUPGHOME=$HOME/.gnupg   # To place in your shell config 
$ ./scripts/generate-gpg-key -d ~${GNUPGHOME} 
```

### Customization: add a photo and/or other identities

Assuming you have a JPEG photo of you, you can attach it in your key with **addphoto**

> Note: photographs must be in a JPG format and  should be as small (in byte size) as possible. A reasonable rule is to  make a picture that is no larger than 240 pixels wide by 288 pixels  high, and a size less than 10,000 bytes. Use a face shot like you would  with a passport photograph.

```bash
# Collect the Master Key ID
$ gpg -K --keyid-format 0xlong
#             vvvvvvvvvvvvvvvvvv
sec   rsa4096/0x3156CC64BB58247D <date> [C]     # <--- 0xlong version 
      6D1F481568A1D64F98BF228B3156CC64BB58247D  # <--- exact version 
uid                   [ultimate] <name> <email>
ssb   rsa4096/0x48D1E2129D0CCEC6 <date> [S] [expires: <date>]
ssb   rsa4096/0xEE74576ED76B1148 <date> [E] [expires: <date>]
ssb   rsa4096/0x68E5153F63FA7B79 <date> [A] [expires: <date>]

# Fully automated version to collect KEYID
$ KEYID=$(gpg --keyid-format long  --with-colons --fingerprint $(git config --get user.email) | awk '{print $1}')

# ... Edit the master key from its ID
$ gpg --edit-key ${KEYID}  # Note: you may rely purely on the email attached to the key with
#                            gpg --edit-key $(git config --get user.email)
# [...]
gpg> addphoto 
Pick an image to use for your photo ID.  The image must be a JPEG file.
Remember that the image is stored within your public key.  If you use a
very large picture, your key will become very large as well!
Keeping the image close to 240x288 is a good size to use.

Enter JPEG filename for photo ID: ~/path/to/picture.jpeg
# The photo will be displayed -- confirm it 
Is this photo correct (y/N/q)? y

sec  rsa4096/3156CC64BB58247D
     created: <date>  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/48D1E2129D0CCEC6
     created: <date>  expires: <date>  usage: S   
ssb  rsa4096/EE74576ED76B1148
     created: <date>  expires: <date>  usage: E   
ssb  rsa4096/68E5153F63FA7B79
     created: <date>  expires: <date>  usage: A   
gpg> save
```

To add another identity with **adduid**:

```bash
# As above
$ gpg --edit-key ${KEYID}  # Note: you may rely purely on the email attached to the key with
#                            gpg --edit-key $(git config --get user.email)
gpg> adduid 
Real name: <name2> 
Email address: <email2>
Comment: 
You selected this USER-ID:
    "<name2> <email2>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

sec  rsa4096/3156CC64BB58247D
     created: <date>  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/48D1E2129D0CCEC6
     created: <date>  expires: <date>  usage: S   
ssb  rsa4096/EE74576ED76B1148
     created: <date>  expires: <date>  usage: E   
ssb  rsa4096/68E5153F63FA7B79
     created: <date>  expires: <date>  usage: A      
[ultimate] (1)  <name> <email>
[ultimate] (2)  [jpeg image of size 4617]
[ unknown] (3). <name> <email>

gpg> save
```

Now if you check your key: 

```bash
$ gpg -K --keyid-format 0xlong
#             vvvvvvvvvvvvvvvvvv
sec   rsa4096/0x3156CC64BB58247D <date> [C]     # <--- long version 
      6D1F481568A1D64F98BF228B3156CC64BB58247D  # <--- exact version 
uid                   [ultimate] <name> <email>
uid                   [ultimate] [jpeg image of size 4617]
uid                   [ultimate] <name2> <email2>
ssb   rsa4096/0x48D1E2129D0CCEC6 <date> [S] [expires: <date>]
ssb   rsa4096/0xEE74576ED76B1148 <date> [E] [expires: <date>]
ssb   rsa4096/0x68E5153F63FA7B79 <date> [A] [expires: <date>]
```

### ~~Customization:  enforce stronger cryptography preferences.~~

**/!\ UPDATE (2023)  does not seem required any more. defaults seems ok**

By default, the encryption preferences specified in your public key are probably not as strong as they should be. Thus you should set stronger default security preferences (to use SHA512, AES256 and ZLIB by default) using the `setpref` command, *i.e.*:

```bash
# As above
$ gpg --edit-key ${KEYID}  # Note: you may rely purely on the email attached to the key with
#                            gpg --edit-key $(git config --get user.email)

```

See also [Gist: GPG Cheat Sheet  and best practices ](https://gist.github.com/MorganGeek/5e6b89d351d34dfbc576db610b0c02e8)

## Transfer your GPG key to [Multiple] Yubikeys

If you own security keys (such as yubikeys), it's time to transfer the generated keys to them! 

See (the excellent) [Dr Duh Yubikey guide](https://github.com/drduh/YubiKey-Guide#configure-smartcard) for detailed instructions.

## Enable SSH access using a GPG key for authentication

Resources:

* [blog: How to enable SSH access using a GPG key for authentication](https://opensource.com/article/19/4/gpg-subkeys-ssh)
* [Gist: OpenPGP SSH access with Yubikey and GnuPG](https://gist.github.com/artizirk/d09ce3570021b0f65469cb450bee5e29)

### Setup (sshcontrol, gpg-agent etc.)

This assumes you have a dedicated GPG subkey with authenticate capability (which is the case from the above scripted generation)

```bash
$ gpg -K --keyid-format long --with-keygrip $(git config --get user.email)
sec   rsa4096/0x3156CC64BB58247D <date> [C]     
      6D1F481568A1D64F98BF228B3156CC64BB58247D  
      Keygrip = 6F165EAF3AF6A678A072841654E6702974A885B3
uid                   [ultimate] <name> <email>
uid                   [ultimate] [jpeg image of size 4617]
uid                   [ultimate] <name2> <email2>
ssb   rsa4096/0x48D1E2129D0CCEC6 <date> [S] [expires: <date>]
      Keygrip = CC34AFAD18486AD790CCA9A708D858057F022FD2
ssb   rsa4096/0xEE74576ED76B1148 <date> [E] [expires: <date>]
      Keygrip = CBE87BF5CB84AE288E4829BE66B286FBCDFEAEAE
ssb   rsa4096/0x68E5153F63FA7B79 <date> [A] [expires: <date>]   # <-- Subkey we're interested to 
      Keygrip = 47A0554C7508280F10E277B40186257857DD6E03 # <-- Associated Keygrip to put into ~/.gnupg/sshcontrol
```

Normally the `sshcontrol` file was already populated. othewise create it as follows: 

```bash
# /!\ ADAPT Keygrip accordingly - pay attention (again) to select your 'A' subkey 
echo "<keygrip-subkey-A>" > ~/.gnupg/sshcontrol
```

* To get **gpg-agent** to handle requests from SSH, you need to enable support by adding the line `enable-ssh-support` in `~/.gnupg/gpg-agent.conf` (already done in  the provided configuration)

* Then you need to tell SSH _how_ to access the **gpg-agent**. This is done by changing the value of the `SSH_AUTH_SOCK` environment variable.
    Add the following lines in your favorite shell configuration (`.bashrc`,`.zshrc` etc.):

    ```bash
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    gpgconf --launch gpg-agent
    ```
    
    A more complete setup is provided in a dedicated script you can source in your favorite shell configuration (`.bashrc`,`.zshrc` etc.). In particular, you probably want to do the above only if `enable-ssh-support` is present in the `gpg-agent.conf` configuration file. 

You can check that it works as follows: 

```bash
# If GPG keys moved to Yubikey and Yubikey is absent
$ ssh-add -L  # Lists public key of all identities currently represented by the agent.
The agent has no identities.
# Plug [one of] your Yubikey(s)
$  ssh-add -L 
ssh-rsa <public-key>== cardno:<serial>
```

### Save public key for identity file configuration

So it's a good idea to extract the OpenPGP SSH public key which can be added (as "normal") in any server `~/.ssh/authorized_key` file. 

```bash
# remove the trailing comment cardno serial  
$ ssh-add -L | grep cardno | sed 's/\(cardno\):.*$/\1/' | tee ~/.ssh/id_rsa_openpgp_yubikey.pub
ssh-rsa <public-key>== cardno
# /!\ IMPORTANT: put the same access rights you would put on an SSH private key or some ssh-agent wrappers may fail
$ chmod 400 ~/.ssh/id_rsa_openpgp_yubikey.pub
```

As per [DrDuh Yubikey Guide on SSH](https://github.com/drduh/YubiKey-Guide#optional-save-public-key-for-identity-file-configuration):

>  By default, SSH attempts to use all the identities available via the agent. That's why when using  the `IdentityFile` option in  an ssh config, you typically point to a private key path. For the YubiKey - indeed, in general for keys stored in an ssh agent - `IdentityFile` should point to the *public* key file and `ssh` will select the appropriate private key from those available via the ssh agent. with `IdentitiesOnly yes`, `ssh` will not automatically enumerate public keys loaded into `ssh-agent` or `gpg-agent`. This means `publickey` authentication will not proceed unless explicitly named by `ssh -i [identity_file]` or in `.ssh/config` on a per-host basis.

For instance with github: 

```bash
Host github.com
  IdentitiesOnly yes
  IdentityFile ~/.ssh/id_rsa_openpgp_yubikey.pub
```

Check that it works (after uploading the public key in yoru profile, : 

```bash
# Better have a 'journal -fax' running in parallel to detect TTY issue
$ ssh git@github.com
PTY allocation request failed on channel 0
Hi svarrette-anssi! You've successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.
```

*Note* **if you are using multiple yubikeys** to store the same GPG indentity (see [`yubikeys.md`](../yubikeys.md#transfer-your-gpg-keys-to-your-first-yubikey) ), repeat the same test with each yubikey to ensure it works just fine -- **recall to invoke [`yubi-switch`](https://github.com/Falkor/dotfiles/blob/master/oh-my-zsh/custom/plugins/falkor/falkor.plugin.zsh#L366) prior to running the ssh command**. 

## GPG CLI Usage

~~~bash
gpg --list-keys [pattern]                            # List available PGP key(s)
gpg --keyserver keys.openpgp.org --search-keys <pattern> # Search \& Import
gpg --keyserver keys.openpgp.org --recv-keys <ID>        # Import
gpg --keyserver keys.openpgp.org --send-keys <ID>        # Export to server
~~~

`/!\ IMPORTANT:` sending _encrypted_ mails to `user@domain.org` assumes that you **trust** his key, _i.e._ that you _sign_ (after careful check) this key (using GPG Keychain / GPA).

~~~bash
gpg [-K] --fingerprint <mail>                  # Get (with -K) / Check fingerprint
gpg --sign-key --ask-cert-level <ID>           # Sign Key <ID> AFTER check
gpg --keyserver keys.openpgp.org  --send-keys <ID>  # Send back signed key
~~~

Now if you want to encrypt / decrypt / digitally sign files:

~~~bash
gpg --encrypt [-r <recipient>] <file>     # => <file>.gpg
rm -f <file>    # /!\ WARNING: encryption does not delete the input (clear-text) file

gpg --decrypt <file>.gpg           # Decrypt PGP encrypted file
gpg --armor --detach-sign <file>  # Generate signature file <file>.asc
~~~

## GPG Keychain / Keyring

* Linux / Mac OS: `~/.gnupg/`
* Windows:   `C:\\Documents and Settings\<LOGIN>\Application Data\gnupg\`

More genrally, you can manage your secret data with a [system keyring](https://dev.to/setevoy/what-is-linux-keyring-gnome-keyring-secret-service-and-d-bus-4kgd), i.e. [Kwallet](https://utils.kde.org/projects/kwalletmanager/) or [`gnome-keyring`](https://wiki.gnome.org/Projects/GnomeKeyring) etc. 

For instance, to install `gnome-keyring` (on Debian systems (even when relying on KDE Plasma as it's way better supported than Kwallet -- see [blog](https://www.jwillikers.com/gnome-keyring-in-kde-plasma))

```bash
$ sudo apt install gnome-keyring seahorse

# Autostart SSH and Secrets components of the GNOME keyring on login 
cp /etc/xdg/autostart/{gnome-keyring-secrets.desktop,gnome-keyring-ssh.desktop} ~/.config/autostart/
sed -i '/^OnlyShowIn.*$/d' ~/.config/autostart/gnome-keyring-secrets.desktop
sed -i '/^OnlyShowIn.*$/d' ~/.config/autostart/gnome-keyring-ssh.desktop
```

## Using GPG within git

* Sign tags using your GPG key with the `-s` option
    - add Signed-off-by line by the committer using `-s` : `git commit -s [...]`
    - GPG sign commit with `-S`: `git commit -s -S [...]`
    - tag sign: `git tag -s <name>`
* Assumes that you have configured git with your GPG signing key ID (typically into `~/.config/git/config.local`). 
    Example below -- see also [my personal configuration](https://github.com/Falkor/dotfiles/blob/master/git/config.local.example)

~~~ini
[user]
    name = Firstname Lastname
    email = firstname.lastname@domain.com
    signingkey = 0x<GPG-Key-ID>

[commit]
	gpgsign = true

[tag]
	gpgsign = true
~~~

## (old notes) Using GPG within Keybase.io

* [Blog: GPG: Strong Keys, Rotation, and Keybase](https://sungo.wtf/2016/11/23/gpg-strong-keys-rotation-and-keybase.html)
* [Playing with Keybase.io](http://nishanttotla.com/blog/playing-with-keybase-io/)
* **Alternative to Keybase.io: [Keyoxide](https://keyoxide.org)** 
    * Both rely on GPG Notations which can be added to user ID(s) and can be used to create [OpenPGP identity proofs](https://keyoxide.org/guides/openpgp-proofs).


[Keybase.io](https://keybase.io) aims to make life with GPG easier. It does a really good job but it encourages a bad behavior in key management, _i.e._ by default, it creates and stores a private key on their server. We can never truly verify the condition of their server so a Keybase-hosted private key should always be considered untrustworthy.
So we will configure [Keybase.io](https://keybase.io) to just use our existing key

Install keybase:

~~~bash
$> {apt | dnf | brew cask} install keybase
~~~

You can then configure the completion files on your system:

* [Bash completion file](https://github.com/dtiersch/keybase-completion) -- see [Issue #147](https://github.com/keybase/keybase-issues/issues/147) in the Keybase Bugtracker
* [ZSH completion file](https://github.com/rbirnie/oh-my-zsh-keybase/blob/master/keybase/_keybase) -- see [Issue #519](https://github.com/keybase/keybase-issues/issues/519) in the Keybase Bugtracker

Now you can select your (local) gpg key and import the **public** key to Keybase.io (thus using the `--no-import` option).

~~~bash
keybase pgp select --no-import <keyID>
#    Algo    Key Id             Created   UserId
=    ====    ======             =======   ======
1    4096R   <keyid>                      <firstname> <lastname> <email> [...]
Choose a key: 1
▶ INFO Bundle unlocked: <keyID>
▶ INFO Generated new PGP key:
▶ INFO   user: <uid> 
▶ INFO   4096-bit RSA key, ID <keyID>, created <date>
▶ INFO Key <keyID> imported
~~~

**Adding Trust Using Public Account**

~~~bash
# prove that the twitter account @<login> really belongs to you
$ keybase prove twitter <login>

# repeat for github, your web site etc...
$ keybase prove github <login>
$ keybase prove web https://<url>
~~~

## (Old notes) Using GPG within Git-crypt

* [reference doc](https://www.agwa.name/projects/git-crypt/)
* [Github project](https://github.com/AGWA/git-crypt)
* [tutorial](http://www.starkandwayne.com/blog/secure-your-boshworkspace-with-git-crypt/)

### Installation

~~~bash
# OSX
brew install git-crypt

# Debian/Ubuntu
sudo apt-get install libssl-dev
cd /tmp && wget https://github.com/AGWA/git-crypt/archive/0.5.0.zip
unzip 0.5.0.zip && cd git-crypt-0.5.0/
make && sudo make install
~~~

### Initial Repository Setup

Configure/setup a repository to use `git-crypt` as follows:

```bash
 $ git-crypt init
```

This will generate a symmetric key for encrypting your files (stored in `.git/git-crypt/keys/default`).

You need also to enable a git [pre-commit hook](https://git-scm.com/book/it/v2/Customizing-Git-Git-Hooks) to avoid accidentally adding unencrypted files -- see [issue #45](https://github.com/AGWA/git-crypt/issues/45).
Example of such a pre-commit hook, to be placed as `.git/hooks/pre-commit` (in executable mode), can be found on [this gist](https://gist.github.com/Falkor/848c82daa63710b6c132bb42029b30ef) -- [raw version](https://gist.github.com/Falkor/848c82daa63710b6c132bb42029b30ef/raw/605a40d778c521e8993a316fa2568ad384fd06ff/pre-commit.git-crypt.sh)

```bash
  $ curl <url/to/raw/gist> -o .git/hooks/pre-commit
  $ chmod +x .git/hooks/pre-commit
```


Now you can **share the repository with others (or with yourself) using GPG**:

```bash
  $ git-crypt add-gpg-user <ID>
```

This will create a encrypted version of the symmetric key and stores it in `.git-crypt/keys/default/0/<FINGERPRINT>.gpg`.
Example:

~~~bash
# Add yourself i.e. sign the encryption key with my GPG key and store it into '.git-crypt/'
$> git-crypt add-gpg-user <your-keyID>
[master d91d341] Add 1 git-crypt collaborator
 2 files changed, 3 insertions(+)
 create mode 100644 .git-crypt/.gitattributes> p
 create mode 100644 .git-crypt/keys/default/0/<your-exact-KeyID>.gpg
~~~

This encrypted key can be decrypted by running:

     $> git-crypt unlock

You can add as many collaborators as you wish.
Note that since distributing keys can be cumbersome, the above mentioned [tutorial](http://www.starkandwayne.com/blog/secure-your-boshworkspace-with-git-crypt/) combines `git-crypt` with the [keybase.io](https://keybase.io/docs/command_line) service, which seems btw very promising however request some tests.

### Encrypted files configuration within `.gitattributes`

Specify files/wildcard patterns to encrypt by creating a [`.gitattributes`](https://git-scm.com/docs/gitattributes) file at the root of  the repository through the following format:

```
<pattern>   filter=git-crypt diff=git-crypt
```

Example:

~~~bash
#
# specify which files to encrypt using [git-crypt](https://www.agwa.name/projects/git-crypt/)
#

# Certificate private keys
*.key filter=git-crypt diff=git-crypt

# Host SSH private keys
*ssh_*_key filter=git-crypt diff=git-crypt

# runner config
*.toml filter=git-crypt diff=git-crypt

# Apache htaccess pasword protected
*.htpasswd filter=git-crypt diff=git-crypt

# specific apache vhost hosting LDAP binding credentials
servers/gaia/www/etc/httpd/sites-available/default-ssl filter=git-crypt diff=git-crypt
~~~

Remember to commit the `.gitattributes` file.

`/!\ IMPORTANT:` you should have **unlock** the repository before adding an encrypted file.

Assuming you plan to add a `*.key` file (thus expected to be encrypted), proceed as follows:

~~~bash
# Eventually unlock the repository
$ git-crypt unlock
$ echo 'secret' > secret.key
$ git add secret.key
$ git commit -s -m "add secret.key (encrypted) file" secret.key
~~~

Note that thanks to the pre-commit hook, in case you have forgotten to unlock the repository, the above commit command would fail as follows:

~~~bash
$ git commit -s -m "add secret.key (encrypted) file" secret.key
    encrypted: secret.key *** WARNING: staged/committed version is NOT ENCRYPTED! ***

Warning: one or more files is marked for encryption via .gitattributes but
was staged and/or committed before the .gitattributes file was in effect.
Run 'git-crypt status' with the '-f' option to stage an encrypted version.
~~~

So assuming you did well, you can commit the file and check that the content is indeed encrypted:

~~~bash
$ git commit -s -m "add secret.key (encrypted) file" secret.key
[master 9ae570f] add secret.key (encrypted) file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 secret.key
$ cat secret.key
secret

# Lock back the repository
$ git-crypt lock
$ cat secret.key
GITCRYPT�ἅ�)&f\���Lp�<%
~~~

`/!\ IMPORTANT`: the pre-commit hook is a nice safeguard but **remains local** to your personal copy of the repository.
In particular, it is **not shared** with you collaborator upon cloning operations. You'll typically need to integrate the setup of that hook through the `[m|r]ake setup` operation

## (Old notes) Using GPG for Password Management with `pass`

Another nice git-based approach that team nicely with GPG relies on the `pass` utility and a carefully crafted git repository

### Password repository layout

Passwords are meant to be stored into a git repository where each password is contained in a file, encrypted with GnuPG using public keys of all the allowed admins.
The structure of the passwords repository is thus typically as follows:

~~~bash
Password Store
├── admin_gnupg      # GnuPG configuration directory for the password repository
│   ├── gpg.conf     # admin group definition
│   ├── pubring      # holds the administrator's public keys
│   └── reencrypt.sh # facility script to re-encrypt every password when admin group changes
├── extra
│   ├── ...
│   └── twitter
│       └── login.gpg # encrypted password to connect to twitter with login 'login'
└── [...]
~~~

When possible, passwords should be stored with the following structure:

    <path/to/passwords-repo>/<category>/<target>/<login>.gpg

### Password management (the manual way)

To display a password, you just need to decrypt the GPG-encrypted password, typically as follows:

    gpg -d extra/twitter/ULHPC.gpg

To add a new encrypted password, use:

    GNUPGHOME=<path_to_passwords-repo>/admin_gnupg gpg -r admin -e -o extra/twitter/ULHPC.gpg

Then, don't forget to git add/commit/push your changes.

### Password management using the [`pass` utility](http://zx2c4.com/projects/password-store/)

_Pass_ is an utility to insert, display or copy to clipboard passwords stored
into git repository. It is not mandatory to use it, but it eases password management.
After installation (`brew install pass`), using pass requires two configuration steps:

* Set the `PASSWORD_STORE_DIR` environment variable, which contains the path of the password repository:

    	export PASSWORD_STORE_DIR=<path_to_passwords-repo>

* Set the GNUPGHOME environement variable to the admin_gnupg subdirectory:

    	export GNUPGHOME=$PASSWORD_STORE_DIR/admin_gnupg

Then the CLI usage is summarized below:

~~~bash
$ pass help      # Pass usage
$ pass git pull  # Fetch latest passwords
$ pass           # List passwords
$ pass extra/twitter/login         # Display a password
$ pass -c extra/twitter/login      # Copy a password to clipboard
$ pass insert extra/twitter/toto   # Insert a new password
$ pass git push                    # Push your changes
~~~

_Notes_: Git commit is done automatically by the `pass` utility.
If you need to add comments in addition to the password, use the `-m` option to insert extra lines.

### Extra `pass` Utilities / commodities

* Zsh/Bash completions: <http://git.zx2c4.com/password-store/tree/contrib>
* Env sourcing (in your .zshrc):

    ```bash
    eval `/path/to/passwords-repo/.passrc`
    ```

* shell alias:

    ```pass
    alias pass='eval `/path/to/passwords-repo/.passrc` && pass'
    ```

