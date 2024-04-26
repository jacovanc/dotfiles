#!/bin/bash

# Add repos
## Caddy repo
echo "Adding the Caddy package repo"
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# Define an array of software packages to install
software_packages=(
    "unzip"
    "xclip"
    "xsel"
    "ripgrep"
    "build-essential" # For make command
    "tmux"
    "caddy"
    "php"
    "php-cli"
    "php-mbstring"
    "php-xml"
    "php-curl"
    "php-zip"
    "php-bcmath"
    "php-json"
    "php-gd"
    "python3-pip"
    "python3-dev"
    "python3-setuptools"
)

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

# Setup composer
echo "Downloading the Composer installer" 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
echo "Running the installer" 
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
echo "Installing PHP extensions"
rm nvim-linux64.tar.gz

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install tmux plugins
echo "Installing tmux package manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
## You may need to finish tmux setup manually:
## Open tmux and install plugins using <Leader I> command

# Install thefuck
pip3 install thefuck --user

# Set git to ignore file permissions
git config core.fileMode false
git config --global core.fileMode false

echo "Software installation complete."

source ~/.bashrc
