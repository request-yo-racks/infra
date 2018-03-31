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
  git-extras \
  hub \
  liquidprompt

# Install cask formulas.
brew cask install \
  iterm2

# Setup liquidpromt
LP_BIN=/usr/local/share/liquidprompt
if ! grep "[ -f ${LP_BIN} ] && . ${LP_BIN}" ~/.bash_profile; then
  echo '' >> ~/.bash_profile
  echo '# Configure LiquidPrompt.' >> ~/.bash_profile
  echo "[ -f ${LP_BIN} ] && . ${LP_BIN}" >> ~/.bash_profile
fi
