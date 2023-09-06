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
echo "/nInstalling the rest. Depending on how much in in here this may take a very long time./n"
brew bundle
