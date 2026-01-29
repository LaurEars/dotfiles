#!/bin/sh

# Install xcode to install git
# xcode xcode-select --install

# Install homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed (skipping)"
else
    echo "Installing Homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi

# Install iterm2 with homebrew
if brew list --cask iterm2 >/dev/null 2>&1; then
    echo "iTerm2 already installed (skipping)"
else
    echo "Installing iTerm2..."
    brew install --cask iterm2
fi

# create file for local configuration
if [[ -f ~/.local_secrets.sh ]]; then
    echo "~/.local_secrets.sh already exists (skipping)"
else
    echo "Creating ~/.local_secrets.sh"
    touch ~/.local_secrets.sh
    chmod 755 ~/.local_secrets.sh
fi

# to set up shell integration in iterm, this file is necessary
if [[ -f ~/.iterm2_shell_integration.zsh ]]; then
    echo "iTerm2 shell integration already exists (skipping)"
else
    echo "Downloading iTerm2 shell integration..."
    curl -L https://iterm2.com/shell_integration/zsh \
    -o ~/.iterm2_shell_integration.zsh
fi

# Link dotfiles e.g. `ln -s ~/code/dotfiles/.zshrc ~/.zshrc` (see below)
# create symlinks for all dotfiles in the directory
# Need to do this for all files except for .git and .idea
dotfiles_dir=~/code/dotfiles
for file in "$dotfiles_dir"/.[a-zA-Z]*; do
    filename=$(basename "$file")
    target="$HOME/$filename"

    if [[ "$filename" != ".git" && "$filename" != ".idea" ]]; then
        if [[ -L "$target" ]]; then
            echo "Symlink already exists: $target (skipping)"
        elif [[ -e "$target" ]]; then
            echo "File already exists: $target (skipping, back up manually if needed)"
        else
            echo "Linking $dotfiles_dir/$filename to $target"
            ln -s "$dotfiles_dir/$filename" "$target"
        fi
    fi
done
