#!/bin/sh

set -e

# Install xcode to install git
# xcode xcode-select --install

# Install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
# Install iterm2 with homebrew
brew install --cask iterm2

# create file for local configuration
touch ~/.local_secrets.sh
chmod 755 ~/.local_secrets.sh

# to set up shell integration in iterm, this file is necessary
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# Link dotfiles e.g. `ln -s ~/code/dotfiles/.zshrc ~/.zshrc` (see below)
# create symlinks for all dotfiles in the directory
# Need to do this for all files except for .git and .idea
dotfiles_dir=~/code/dotfiles
for file in "$dotfiles_dir"/.[a-zA-Z]*; do
    filename=$(basename "$file")
    if [[ "$filename" != ".git" && "$filename" != ".idea" ]]; then
        echo "Linking $dotfiles_dir/$filename to $HOME/$filename"
        ln -s "$dotfiles_dir/$filename" "$HOME/$filename"
    fi
done
