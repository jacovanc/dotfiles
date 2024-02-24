#!/bin/bash

# Script to generate an SSH key pair
# Also starts the SSH agent and adds the key it it

# Ask for the email address to associate with the key
read -p "Enter the email address for your SSH key: " email

# Default SSH key path
default_ssh_key_path="/home/$(whoami)/.ssh/id_rsa"

# Ask for the file path to save the key and use the default if none is provided
read -p "Enter the file in which to save the key ($default_ssh_key_path): " ssh_key_file
ssh_key_file=${ssh_key_file:-$default_ssh_key_path}

# Create the SSH key pair
ssh-keygen -t rsa -b 4096 -C "$email" -f "$ssh_key_file"

# Start the SSH agent in the background
eval "$(ssh-agent -s)"

# Add your SSH private key to the ssh-agent
ssh-add "$ssh_key_file"

echo "SSH key generation complete."
echo "Your public key (for adding to services):"
cat "${ssh_key_file}.pub"
