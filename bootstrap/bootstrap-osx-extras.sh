#!/bin/bash
set -euo pipefail

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
  echo ''
fi
