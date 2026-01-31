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

# Install applications with homebrew
echo "Installing applications..."
brew install --cask iterm2
brew install --cask jetbrains-toolbox

# create file for local configuration
touch ~/.local_secrets.sh
chmod 755 ~/.local_secrets.sh

# to set up shell integration in iterm, this file is necessary
if [[ -f ~/.iterm2_shell_integration.zsh ]]; then
    echo "iTerm2 shell integration already exists (skipping)"
else
    echo "Downloading iTerm2 shell integration..."
    curl -L https://iterm2.com/shell_integration/zsh \
    -o ~/.iterm2_shell_integration.zsh
fi

# Create symlinks for all dotfiles except .git and .idea
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
