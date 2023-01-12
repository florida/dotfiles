# Florida's Dotfiles

## Development Tools Setup

### Terminal Setup and Installing Command Line Tools

```bash
$ ./cli_setup.sh 
```

This script would set up the following and it's dependencies

* Xcode Command Line Tools
* HomeBrew 
* GNU GPG
* OhMyZsh
* NVM (Node Version Manager)
* Removing Terminal login message

### Git SSH and GPG setup

```bash
$ ./git_setup.sh
```

This script would setup the following

* Global git config
* Generates SSH key
* Generates GPG key 

Import iterm colours from `term/OceanPreset.itermcolors`

### Install additional dev Tools

`./extras.sh` 