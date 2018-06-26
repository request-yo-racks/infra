#!/bin/bash
set -euo pipefail

# This script needs to be standalone to be run like this:
# bash <(curl -fsSL https://raw.githubusercontent.com/request-yo-racks/infra/master/bootstrap/bootstrap-osx.sh)
# Therefore cannot import other scripts.

: ${RYR_BOOTSTRAP_SILENT:=1}
if [ "${RYR_BOOTSTRAP_SILENT}" -eq "1" ]; then
  exec &>/dev/null
fi

# Install brew if needed.
brew --version || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update brew.
brew update

# Install brew formulas.
brew install \
  brew-cask-completion \
  bash-completion \
  docker-completion \
  editorconfig \
  git \
  node \
  pip-completion \
  python3 \
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
