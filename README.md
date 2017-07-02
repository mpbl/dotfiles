# My linux dotfiles for vim, tmux and bash

**Warning:** If you want to give these dotfiles a try, you should first fork
this repository, review the code, and remove things you don’t want or need.
Don’t blindly use my settings unless you know what that entails. Use at your
own risk!

## Install

Clone the repository.
```bash
git clone https://github.com/ddrexl/dotfiles.git
```

Run the package install script. It will install some essential packages for my
dotfiles.
```bash
cd dotfiles # enter the repo dir
./install_packages.bash
```

Run the bootstrapper script. It will overwrite the dotfiles in your home
directory, so you should make a backup.
```bash
./bootstrap.bash
```

## Add your private configuration

The following files are reserved for your private local configuration:
 - `~/.gitconfig`
 - `~/.vimrc.local`
 - `~/.bashrc.local`

If they don't exist, an initial version will be set up.
Subsequent calls to the bootstrap won't overwrite these files.

## Finalize vim

On the first time you start vim, it will install plug.vim and ubuntu mono powerline fonts.
Wait until it's done and run (in vim):
```vim
:PlugInstall
```

To install YouCompleteMe with semantic support for C++, run:
```bash
cd ~/.vim/plugged/youcompleteme   # go to plugin directory
./install.py --clang-completer    # compile ycm
```

## Feedback

Feel free to leave your [suggestions/improvements](https://github.com/ddrexl/dotfiles/issues)!

## Thanks to…

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
