#!/bin/bash
set -euo pipefail

# Install Brew.
brew --version || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Git.
brew update

# Install brew formulas.
brew install \
  brew-cask-completion \
  bash-completion \
  docker-completion \
  git \
  node \
  pip-completion 2>/dev/null

# Install cask formulas.
brew cask install \
  docker \
  iterm2 \
  virtualbox 2>/dev/null

# Generate an SSH key (without passphrase) if needed and add it to the ssh-agent.
SSH_PRIVATE_KEY=~/.ssh/id_rsa
if [ ! -f "${SSH_PRIVATE_KEY}" ]; then
  ssh-keygen -b 4096 -t rsa -f ${SSH_PRIVATE_KEY} -q -N ""
  eval "$(ssh-agent -s)"
  ssh-add -K ${SSH_PRIVATE_KEY}
fi

# Copies the contents of the public SSH key to your clipboard.
pbcopy < "${SSH_PRIVATE_KEY}.pub"

# Open the Github instruction page to add the SSH key.
open https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
