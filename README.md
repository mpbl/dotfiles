# My linux dotfiles for vim, tmux and bash

**Warning:** If you want to give these dotfiles a try, you should first fork
this repository, review the code, and remove things you don’t want or need.
Don’t blindly use my settings unless you know what that entails. Use at your
own risk!

This repository is mainly to keep my personal changes.
Thanks to [DDrexl](https://github.com/ddrexl) who helped me getting started with vim
with, but not only, the collection of dotfiles.

## Install

Clone the repository.
```bash
git clone https://github.com/FaBrand/dotfiles
```

Run the bootstrapper script. It will overwrite the dotfiles in your home
directory, so you should make a backup.
The bootstrap script also installs a customized fork of the oh-my-zsh theme with some plugins being activated by default
```bash
./bootstrap.bash
```
## Known Problems

On some setups it appears that the install of oh-my-zsh can't wasn't successfull.
e.g. The two-lined bira theme is not used.

Try changing the defult shell like this:
```bash
chsh -s $(which zsh)
```
Open the link if this error ocurs [PAM authentication Error](https://www.google.de/search?q=ubuntu+chsh+pam+authentication+failure).


## Add your private configuration

The following files are reserved for your private local configuration:
 - `~/.gitconfig`
 - `~/.vimrc.local`
 - `~/.zshrc.local`

If they don't exist, an initial version will be set up.
Subsequent calls to the bootstrap won't overwrite these files.

## MISC
I like to use the [arc-theme](https://github.com/horst3180/arc-theme) alongside the solarized dark colorscheme.

## Feedback

Feel free to leave your [suggestions/improvements](https://github.com/FaBrand/dotfiles/issues)!

## Thanks to…

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
