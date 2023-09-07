# script to install most apps I require on a new mac.

# start with xcode command line tools
if [ ! -d "/Library/Developer/CommandLineTools/" ]; then
  echo "/nAbout to install command line tools. This can take a while. Plug in?/n"
  xcode-select --install
fi

# Next get brew
if [ ! -f "/opt/homebrew/bin/brew" ]; then
  echo "/nInstalling Homebrew becasue it is missing.../n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# now install chezmoi
echo "/nInstalling chezmoi/n"
brew install chezmoi
# run chezmoi to get the bootstrap.sh This will also install all your other 
# dotfiles.
chezmoi --init --apply robie1373

# Once we have our Brewfile we can use that to install the rest
if read -q "choice?Do you want to install the base bundle? (Recommended) [yN]"; then
  brew bundle --file $HOME/Brewfile.base
fi

if read -q "choice?Do you want to install the coding bundle? [yN]"; then
  brew bundle --file $HOME/Brewfile.coding
fi

if read -q "choice?Do you want to install the hareware dev bundle? [yN]"; then
  brew bundle --file $HOME/Brewfile.hardware
fi
# 1password 8 and the app store are having a hissy fit, so remind yourself
# to install it manually like a troglodite.
echo "You still have to instal 1password manually because grrr..."
open https://1password.com/downloads/mac/
