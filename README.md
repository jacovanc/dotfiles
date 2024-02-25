# Scripts

Run the scripts in this order:
1. setup_initial_user.sh
2. Sign in to the newly created user, as the next script will generate an ssh key for it
3. setup_ssh.sh
4. Add this new ssh key to any required services (e.g. git or any servers you want to connect to)
5. install_packages.sh 
6. Clone my nvim config and init scripts
You may need to update neovim first if it's out of date:
```bash
sudo apt update
sudo apt upgrade neovim
```
```bash
git clone https://github.com/jacovanc/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
Running nvim will now install all the plugins and setup the config


Top level script that will run them all in the correct order will be created later.
