#!/bin/zsh

exists() {
  command -v $1 >/dev/null 2>&1
}

echo Install oh my zsh
cd
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo Setup powerline fonts
local POWERLINE_URL="https://github.com/powerline/powerline/raw/develop/font"
curl $POWERLINE_URL/PowerlineSymbols.otf --create-dirs -o "$HOME/.fonts/PowerlineSymbols.otf"
fc-cache -vf $HOME/.fonts/
#curl $POWERLINE_URL/10-powerline-symbols.conf --create-dirs -o "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf"

if exists dconf; then
    echo Install solarized color scheme
    echo - select dark theme
    echo - select download seebi dircolors
    git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
    cd ~/.solarized
    ./install.sh
else
    echo Package dconf-cli required for solarized colors!
fi


