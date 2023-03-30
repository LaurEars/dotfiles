#!/bin/sh

set -e

# Local system configuration steps
# [ ] Install xcode `xcode-select —-install`
# [ ] Install homebrew
# [ ] Install iterm2
# [ ] Create ssh key
# [ ] Download and link dotfiles e.g. `ln -s ~/code/dotfiles/.zshrc ~/.zshrc` (see below)

# create file for local configuration
touch ~/.local_secrets.sh
chmod 755 ~/.local_secrets.sh

# to set up shell integration in iterm, this file is necessary
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# create symlinks for all dotfiles in the directory
# Need to do this for all files except for .git and .idea
# Download dotfiles repo and run this command
dotfiles_dir=~/code/dotfiles
for file in "$dotfiles_dir"/.[a-zA-Z]*; do
    filename=$(basename "$file")
    if [[ "$filename" != ".git" && "$filename" != ".idea" ]]; then
        echo "Linking $dotfiles_dir/$filename to $HOME/$filename"
        ln -s "$dotfiles_dir/$filename" "$HOME/$filename"
    fi
done
