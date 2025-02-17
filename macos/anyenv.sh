#!/bin/sh

anyenv install --init
anyenv install pyenv
anyenv install nodenv
anyenv install tfenv

pyenv install 3.9.5
nodenv install 16.15.0
nodenv global 16.15.0
