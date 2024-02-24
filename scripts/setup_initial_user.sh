#!/bin/bash

## Note that this script should only be used for the first user created on a newly setup system
## It should also already have root access setup using an SSH key. This is because after 
## creating a new user, it will also copy the SSH key settings to that user, 
## and disable root access via ssh

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Prompt for the new username
read -p "Enter the new username: " username

# Create a new user and add to sudo group
adduser $username
usermod -aG sudo $username

# Create .ssh directory for the new user, copy authorized_keys, and set permissions
su -c "mkdir ~/.ssh && chmod 700 ~/.ssh" $username
cp /root/.ssh/authorized_keys /home/$username/.ssh/
chown $username:$username /home/$username/.ssh/authorized_keys
chmod 600 /home/$username/.ssh/authorized_keys

# Disable SSH root login
sed -i '/PermitRootLogin yes/c\PermitRootLogin no' /etc/ssh/sshd_config

# Restart SSH service
systemctl restart ssh

# Setup Uncomplicated Firewall (UFW)
ufw allow OpenSSH
ufw --force enable

echo "Setup complete. Please test logging in as $username before closing this session."
