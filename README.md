# Florida's Dotfiles

## Development Tools Setup

### Install Homebrew and packages

`./bash.sh` 

### Terminal Setup

Add `/usr/local/bin/fish` to `/etc/shells` to set fish as default shell

```
$ echo "/usr/local/bin/fish" >> /etc/shells
```

Run command to update default shell

```
$ chsh -s /usr/local/bin/fish
```

Copy powerline config to home folder

```
cp term/powerline.py ~/.config/term
```

Copy base16-ocean preset
```
cp term/base16-ocean.sh ~/.config/term
```

Import iterm colours from `term/OceanPreset.itermcolors`

### Install additional dev Tools

`./extras.sh` 