#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function copy_to_home() {
    # never overwrite existing .gitconfig
    if [ ! -f ~/.gitconfig ]; then
        cp .gitconfig ~/.gitconfig
    fi
    rsync --exclude ".git/" \
        --exclude "bootstrap.sh" \
        --exclude ".gitconfig" \
        --exclude "install_packages.sh" \
        --exclude "README.md" \
        -avh --no-perms . ~;
    source ~/.bashrc;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    copy_to_home;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        copy_to_home;
    fi;
fi;
unset copy_to_home;
