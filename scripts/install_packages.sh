#!/bin/bash

# Script to install basic software on a Linux system

# Define an array of software packages to install
software_packages=(
    "build-essential" # For make command
    "tmux"
)

# Fetch repository for latest versions of neovim
# echo "Fetching repository..."
# sudo add-apt-repository ppa:neovim-ppa/unstable

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install software packages
for package in "${software_packages[@]}"; do
    echo "Installing $package..."
    sudo apt-get install -y $package
done

# Download and extract Neovim binary release
echo "Downloading Neovim binary release..."
wget -O nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

echo "Extracting Neovim binary release..."
sudo tar xzf nvim-linux64.tar.gz -C /usr/local/

echo "Neovim installation complete."

# Clean up downloaded files
echo "Cleaning up..."
rm nvim-linux64.tar.gz

echo "Software installation complete."

