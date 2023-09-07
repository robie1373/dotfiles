#!/bin/zsh

# script to install most apps I require on a new mac.

# start with xcode command line tools
if [ ! -d "/Library/Developer/CommandLineTools/" ]; then
  printf "/nAbout to install command line tools. This can take a while. Plug in?/n"
  xcode-select --install
fi

# Next get brew
if [ ! -f "/opt/homebrew/bin/brew" ]; then
  printf "/nInstalling Homebrew becasue it is missing.../n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# now install chezmoi
printf "/nInstalling chezmoi/n"
brew install chezmoi
# run chezmoi to get the bootstrap.sh This will also install all your other 
# dotfiles.
chezmoi init --apply --verbose https://github.com/robie1373/dotfiles.git

# Once we have our Brewfile we can use that to install the rest
BREWFILEDIR=".brewfiles"

if read -q "choice?Do you want to install the base bundle? (Recommended) [yN]\n"; then
  brew bundle --file $HOME/$BREWFILEDIR/Brewfile.base
fi

if read -q "choice?Do you want to install the coding bundle? [yN]\n"; then
  brew bundle --file $HOME/$BREWFILEDIR/Brewfile.coding
fi

if read -q "choice?Do you want to install the hareware dev bundle? [yN]\n"; then
  brew bundle --file $HOME/$BREWFILEDIR/Brewfile.hardware
fi
# 1password 8 and the app store are having a hissy fit, so remind yourself
# to install it manually like a troglodite.
if read -q "choice?Do you need 1password? It has to be installed manually. [yN]\n"; then
  open https://1password.com/downloads/mac/
fi
