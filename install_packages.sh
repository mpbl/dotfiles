#!/usr/bin/env bash
# install some basic command line utilities using apt

packages=(
vim
git
tree
cmake
build-essential
exuberant-ctags
curl
rsync
clang-format
python-dev
python3-dev
)

sudo apt update
echo ${packages[*]} | xargs sudo apt install --assume-yes

unset packages;
