# Install Brew.
function brew_install {
brew --version || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Install Git.
function brew_update {
  brew update
}
