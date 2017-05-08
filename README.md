# My linux dotfiles for bash and vim

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

Clone the repository wherever you want.

```bash
git clone https://github.com/ddrexl/dotfiles.git
```

To install or update, go to your local `dotfiles` repository and run the bootstrapper script:
The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
cd dotfiles && source bootstrap.sh
```

You can give the -f switch, to avoid the confirmation prompt:

```bash
source bootstrap.sh -f
```

### Git-free install

To install or update these dotfiles without Git:

```bash
cd; curl -#L https://github.com/ddrexl/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

### Add your private configuration

If `~/.bash/private` exists, it will be sourced along with the other files. You can use this to add
commands you don’t want to commit to a public repository, e.g. your Git Credentials.

Here's an example `~/.bash/private`:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="John Doe"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="john.doe@domain.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.bash/private` to override settings, functions and aliases from my dotfiles repository.
It’s probably better to [fork this repository](https://github.com/ddrexl/dotfiles/fork) instead, though.

### Install helpful packages

This script will install some command line tools I find useful (using apt install).

```bash
./install_packages.sh
```

## Feedback

If you have suggestions/improvements
[welcome](https://github.com/ddrexl/dotfiles/issues)!


## Thanks to…

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
