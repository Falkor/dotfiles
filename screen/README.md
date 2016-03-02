# Falkor's Dotfiles - GNU Screen configuration

[GNU Screen](http://www.gnu.org/software/screen/‎) is a tool to manage persistent terminal sessions.
It allows to create several virtual consoles inside a single terminal, enabling:

* the user to connect to a remote system  by ssh then start screen and create multiple terminal windows and run applications in each, without the need for additional ssh connections;
* the decoupling of the terminal from the running applications, thus even if the network connection is broken, or the user needs to disconnect from the remote system, the applications started in screen windows, will keep running and the user can later reconnect to the screen session and continue work.

I personally dislike the fact that by default there is no visual way to know that I'm under a screen session.
The provided [`.screenrc`](.screenrc) helps to offer a status bar displaying the valuable information of the screen:

* the host running the original screen session (bottom left)
* a window list at the bottom -- the current one beeing placed between red parenthesis
* date and time (I always like to keep track of the time ;))

## Screenshot

![](https://raw.githubusercontent.com/Falkor/dotfiles/master/screenshots/screenshot_falkor_screen.png)

## Installation

TODO

## Basic commands (cheat-sheet)

You can start a screen session (_i.e._ creates a single window with a shell in it) with the `screen` command.
Its main command-lines options are listed below:

| Command      | Description                                                                                                  |
|--------------|--------------------------------------------------------------------------------------------------------------|
| `screen`     | start a new screen session                                                                                   |
| `screen -ls` | does not start screen, but prints a list of `pid.tty.host` strings identifying your current screen sessions. |
| `screen -r`  | resumes from a __detached__ screen session                                                                   |
| `screen -x`  | attach to a not detached screen session in __Multi display mode__*                                           |
|              |                                                                                                              |

* _Note_: Multi display mode allows you and another user to _share_ the same session which proves to be quite useful to debug remote systems.

Once within a screen, you can invoke a screen command which consist of a "`CTRL + a`" sequence followed by another character.
The main commands are listed in the below table:

| Screen Command             | Mnemonic    | Description                                                     |
|----------------------------|-------------|-----------------------------------------------------------------|
| `CTRL + a c`               | (create)    | creates a new Screen window. The default Screen number is zero. |
| `CTRL + a n`               | (next)      | switches to the next window.                                    |
| `CTRL + a p`               | (prev)      | switches to the previous window.                                |
| `CTRL + a d`               | (detach)    | detaches from a Screen                                          |
| `CTRL + a A`               | (title)     | rename the current window                                       |
| `CTRL + a 0-9`             | (go to 0-9) | switches between windows 0 through 9.                           |
| `CTRL + a k` or `CTRL + d` | (kill)      | destroy the current window                                      |
| `CTRL + a ?`               | (help)      | display a list of all the command options available for Screen. |
|                            |             |                                                                 |
