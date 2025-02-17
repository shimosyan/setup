#!/bin/sh

### zsh
sudo apt install zsh
git clone https://github.com/zplug/zplug $HOME/.zplug
curl -sf https://raw.githubusercontent.com/shimosyan/setup/main/wsl/.zshrc -o $HOME/.zshrc

### git
git config --global core.ignorecase false
