#!/bin/bash
set -euo pipefail

# Import OSX common functions.
source bootstrap-osx-common.sh

: ${BS_SILENT:=1}
if [ "${BS_SILENT}" -eq "1" ]; then
  exec &>/dev/null
fi

# Install brew if needed.
brew_install

# Update brew.
brew_update

# Install brew formulas.
brew install \
  brew-cask-completion \
  bash-completion \
  docker-completion \
  editorconfig \
  git \
  node \
  pip-completion \
  shellcheck

# Install cask formulas.
brew cask install \
  docker \
  virtualbox \
  virtualbox-extension-pack

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
