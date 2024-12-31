# Tmux

[Tmux](https://github.com/tmux/tmux/wiki/Getting-Started), a modern terminal multiplexer, alternative to GNU screen.

* [cheatsheet](https://tmuxcheatsheet.com/)

## Installation

```bash
# Install Tmux Plugin Manager: https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
# Copy/symlink the present tmux.conf under ~/.config/tmux/ 
```

```bash
sudo apt install tmux tmuxinator
```

You also need to install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) which helps to manage several interesting plugins -- see [plugin list](https://github.com/tmux-plugins/list):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## Configuration

The default configuration is located under `$XDG_CONFIG_HOME/tmux/tmux.conf` (for compliance with the  [XDG Base Directory Specifications](https://specifications.freedesktop.org/basedir-spec/latest/)).

Copy or symlink the present [`tmux.conf`](tmux.conf) under `~/.config/tmux/`

The first time you run `tmux`, install the defined plugins with `Ctrl+b I` (aka `<prefix> I`)

## Reminder of the main `tmux` commands

Kindly refer to many [cheatsheets](https://geoffcorey.github.io/tmux/linux/tpm/cli/2023/12/23/tmux-and-tpm.html) existing online, yet here are a recall of the main commands:

* You can start a tmux session (_i.e._ creates a single window with a shell in it) with the `tmux` command.

| Command                         | Description                                        |
| :------------------------------ | :------------------------------------------------- |
| `tmux [new -s <name>]`          | start a new tmux session (named `<name>`)          |
| `tmux ls`                       | list current tmux sessions                         |
| `tmux attach [-t <name>] [-r] ` | attach to a named screen session (`-r`: read-only) |
| `tmux kill-session [-t <name>]` | kill session `<name>` (all: `tmux kill-server`)    |

Once within a tmux session, similarly to [Gnu screen](../screen/README.md), you can invoke a command which consist of a "`CTRL + b`" sequence followed by another character.
The main commands are listed in the below table:

| __Command__      | __Description__                      |
| :--------------- | :----------------------------------- |
| `Ctrl+b c`       | __create__ new tab                   |
| `Ctrl+b n`       | go to __next__ tab                   |
| `Ctrl+b p`       | go to __previous__ tab               |
| `Ctrl+b ,`       | rename / set tab title               |
| `Ctrl+b x`       | kill current tab                     |
| `Ctrl+b [0-9]`   | switch to tab number __[0-9]__       |
| `Ctrl+b d`       | __detach__                           |
| `Ctrl+b &`       | quit and killall _(not recommended)_ |
| `Ctrl+b [`       | Enter/leave copy mode                |
|                  | \texti{(up/down; space to select}    |
| `Ctrl+b ?`       | Help                                 |
| `Ctrl+b %`       | vertical split pane                  |
| `Ctrl+b "`       | horizontal split pane                |
| `Ctrl+b <arrow>` | move to pane                         |
| `Ctrl+b q`       | Show pane numbers                    |

With the Tmux plugins installed, you also have access to other commands:


| __Command__      |                       __Tmux plugin__                        | __Description__                                  |
| :--------------- | :----------------------------------------------------------: | :----------------------------------------------- |
| `Ctrl+b SPACE`   | [tmux-which-key](https://github.com/alexwforsythe/tmux-which-key) | Nice menu facilitating key navigation            |
| `Ctrl+b I`       |  [Tmux plugin manager](https://github.com/tmux-plugins/tpm)  | __install__ plugins and refresh tmux environment |
| `Ctrl+b U`       |                                                              | __update__ plugins                               |
| `Ctrl+b Alt u`   |                                                              | remove/uninstall plugins not on the plugin list  |
| `Ctrl+b shift p` | [tmux-logging](https://github.com/tmux-plugins/tmux-logging) | Enter/leave logging mode                         |

