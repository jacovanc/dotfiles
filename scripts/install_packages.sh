#!/bin/bash

# Script to install basic software on a Linux system

# Define an array of software packages to install
software_packages=(
    "build-essential" # For make command
    "neovim"
    "tmux"
)

# Fetch repository for latest versions of neovim
echo "Fetching repository..."
sudo add-apt-repository ppa:neovim-ppa/unstable

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install software packages
for package in "${software_packages[@]}"; do
    echo "Installing $package..."
    sudo apt-get install -y $package
done

echo "Software installation complete."
