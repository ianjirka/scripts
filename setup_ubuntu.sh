#!/bin/bash
# setup.sh: Installs commonly used packages into an Ubuntu distribution
#
# - Github CLI
# - PowerShell

# Install Github CLI
# Instructions from [GitHub](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# Install PowerShell
# Instructions from [Microsoft](https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.3#installation-via-package-repository)

# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Delete the the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell

if [[ $(grep microsoft-standard-WSL /proc/version) ]] ;then
    # We are in WSL - don't install vscode (it is recommended to install on Windows and launch from WSL)
    :
else
    # Install VS Code if not in WSL
    # Instructions from [Microsoft](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions)
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt update
    sudo apt install code
fi



# Install wslu to be able to launch web browser from WSL2
# Instructions from [StackOverflow](https://superuser.com/a/1368878)
sudo apt-get install -y wslu

cd ~
gh auth login

if [ ! -f ".dotfiles" ]; then
    git clone https://github.com/ianjirka/dotfiles.git .dotfiles
    .dotfiles/setup.sh
fi

if [ ! -f "scripts" ]; then
    git clone https://github.com/ianjirka/scripts.git scripts
fi
