#!/bin/bash

tmp_dir="/tmp/gtcs"
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git $tmp_dir
cd $tmp_dir || exit 1
./install.sh --install-dircolors
unset tmp_dir
