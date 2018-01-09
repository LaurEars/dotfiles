#!/bin/sh

# Local system configuration steps
[ ] Install homebrew
[ ] Install iterm2

# create file for local configuration
touch ~/.local_secrets.sh
chmod 755 ~/.local_secrets.sh

# to set up shell integration in iterm, this file is necessary
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
