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

# Install neovim - build from source
# We do this because ubuntu doesn't have neovim later than v0.6, and we need at least v0.8
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
cd .. && rm -rf neovim

echo "Software installation complete."

