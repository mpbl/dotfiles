#!/bin/bash
# install some basic command line utilities using apt

packages=(
    build-essential
    clang-format
    cmake
    curl
    dconf-cli
    exuberant-ctags
    git
    python-dev
    python3-dev
    rsync
    tmux
    tree
    vim
    xsel
    zsh
    silversearcher-ag
)

sudo apt update
echo ${packages[*]} | xargs sudo apt install --assume-yes

unset packages;

# install zsh
# This is the original repository
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Patch with the fix for the solarized shell
if [ -z "$zsh" ]; then
    echo '$ZSH was not set, using default value'
    export ZSH=~/.oh-my-zsh
fi
rm -rf $zsh
git clone https://github.com/FaBrand/oh-my-zsh.git $zsh

# Install a fuzzy file finder for the command line (https://github.com/junegunn/fzf)
which fzf > /dev/null
if [[ $? -eq 1 ]]; then
    fzf_install_dir="/tmp/fzf"
    mkdir -p $fzf_install_dir
    cd $fzf_install_dir
    git clone --depth 1 https://github.com/junegunn/fzf.git $fzf_install_dir
    $fzf_install_dir/install
    cd -
fi
