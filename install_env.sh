#!/bin/bash
# Install all environment

dir_install=~/build_install_temp/

rm -r ${dir_install}
mkdir ${dir_install}
cd ${dir_install}

# Update + utils package
sudo apt-get -y update
sudo apt-get -y install build-essential
sudo apt-get -y install software-properties-common apt-transport-https wget curl gnupg valgrind net-tools

# SnapD
sudo apt -y install snapd

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get -y install ./google-chrome-stable_current_amd64.deb

# Fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get -y update
sudo apt-get -y install fish
exit
chsh -s `which fish` # set default shell
#Fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
#add fisher packages
fisher install edc/bass
#oh-my-fish
curl -L https://get.oh-my.fish | fish
#setup omf + theme
omf install robbyrussell
omf theme robbyrussell


# NVM (for fish)
fisher install jorgebucaran/nvm.fish
nvm install lts/fermium

# Git
sudo apt-get install git
git config --global user.name "theocerutti"
git config --global user.email "theo.cerutti@epitech.eu"
git config --global credential.helper store

# VLC
sudo snap install vlc

# Docker
sudo apt-get -y install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
exit
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Intellij Toolbox
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $DIR
./jetbrains-toolbox
cd ${dir_install}

# Vscode
sudo snap install code

# Terminator
sudo apt-get -y install terminator

# Mongo
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse'
sudo apt-get -y install mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# Postgres
sudo apt-get -y install postgresql postgresql-contrib

# MariaDB
sudo apt-get -y install mariadb-server
echo "Please Setup mariadb"
sudo mysql_secure_installation

# Htop
sudo apt-get -y install htop

# Flameshot
sudo snap install flameshot

# Discord
sudo snap install discord

# Postman
sudo snap install postman

# Gnome shell
sudo apt-get -y install chrome-gnome-shell gnome-shell-extension-prefs gnome-tweaks

# Delete temp directory
cd ~
rm -rf ${dir_install}
