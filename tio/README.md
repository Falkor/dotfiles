# TIO, A serial device I/O tool

https://github.com/tio/tio

> [tio](https://github.com/tio/tio) is a serial device tool which features a straightforward command-line and configuration file interface to easily connect to serial TTY devices for basic I/O operations.

Place the proposed `config` file under `~/.config/tio/`

## Installation 

```bash
sudo apt install tio 
mkdir ~/.config/tio
curl https://raw.githubusercontent.com/Falkor/dotfiles/refs/heads/master/tio/config -o ~/.config/tio/config
```

## Usage 

Use [SHIFT] CTRL-t q to quit

## USB device on `/dev/ttyUSB<N>`

```bash 
tio usb0 # Ex: /dev/ttyUSB0
```

### Tigard 

Ex with [tigard](https://github.com/tigard-tools/tigard) to any target device: 

```bash
tio tigard 
``` 
