#!/bin/bash

dotfiles_dir="$(cd "$(dirname "$0")" && pwd)"

# Install xcode to install git
# xcode-select --install

# Install homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed (skipping)"
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew installs to /opt/homebrew on ARM Macs, /usr/local on Intel Macs.
# Eval shellenv so brew is available for the rest of this script.
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Install applications with homebrew
echo "Installing homebrew applications..."
brew install --cask iterm2
brew install --cask jetbrains-toolbox
brew install jq uv

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

# Set up iTerm2 Dynamic Profile
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
cp "$dotfiles_dir/iterm2-profile.json" ~/Library/Application\ Support/iTerm2/DynamicProfiles/

# macOS preferences
echo "Setting macOS preferences..."
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
defaults write NSGlobalDomain AppleFirstWeekday -dict-add gregorian -int 2
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add 1 -string "y-MM-dd"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Create symlinks for all dotfiles except .git and .idea
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
