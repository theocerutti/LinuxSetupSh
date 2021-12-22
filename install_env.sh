#!/bin/bash
# Install all environment

log() {
    echo -e "#######################\n# $1\n#######################"
}


ME=theo

dir_install=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)/tmp

rm -rf ${dir_install}
mkdir ${dir_install}
cd ${dir_install}

# Update + utils package
log "Install Utils package"
sudo apt -y update
sudo apt -y install build-essential
sudo apt -y install software-properties-common apt-transport-https wget curl gnupg valgrind net-tools

# SnapD
log "Install SnapD"
sudo apt -y install snapd

# Teams
log "Install Teams"
sudo snap install teams

# Notion
log "Install Notion"
sudo snap install notion-snap

# Java + Maven
log "Install Java + Maven"
sudo apt -y install default-jre
sudo apt -y install default-jdk
sudo apt -y install maven

# Chrome
log "Install Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install ./google-chrome-stable_current_amd64.deb

# Git
log "Install Git + Set config"
sudo apt install git
git config --global user.name "theocerutti"
git config --global user.email "theo.cerutti@epitech.eu"
git config --global credential.helper store

# VLC
log "Install VLC"
sudo snap install vlc

# Docker
log "Install Docker"
sudo apt -y install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $ME
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Docker-compose
log "Install Docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Vscode
log "Install VSCode"
sudo snap install code

# Terminator
log "Install Terminator"
sudo apt -y install terminator

# Htop
log "Install Htop"
sudo apt -y install htop

# Flameshot
log "Install Flameshot"
sudo snap install flameshot

# Discord
log "Install Discord"
sudo snap install discord

# Postman
log "Install Postman"
sudo snap install postman

# Gnome shell
log "Install Gnome Shell"
sudo apt -y install chrome-gnome-shell gnome-shell-extension-prefs gnome-tweaks

# Minikube
log "Install Minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Ansible
log "Install Ansible"
sudo apt -y install ansible

# Terraform
log "Install Terraform"
sudo apt -y update && sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt -y install terraform

# Virtualbox
log "Install Virtualbox"
wget https://download.virtualbox.org/virtualbox/6.1.30/virtualbox-6.1_6.1.30-148432~Ubuntu~eoan_amd64.deb
sudo dpkg -i virtualbox-6.1_6.1.30-148432~Ubuntu~eoan_amd64.deb

# Vagrant
log "Install Vagrant"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant

# Flutter
log "Install Flutter"
sudo snap install flutter --classic
flutter doctor

# Intellij Toolbox
log "Install Intellij Toolbox"
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
JETBRAIN_BIN_DIR=$(find . -maxdepth 1 -type d -name jetbrains-toolbox-\* -print | head -n1)
cd $JETBRAIN_BIN_DIR
./jetbrains-toolbox
cd ${dir_install}

# Mongo
log "Install Mongo"
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo add-apt-repository -y 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse'
sudo apt -y install mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# Postgres
log "Install Postgres"
sudo apt -y install postgresql postgresql-contrib
sudo -u postgres createuser --interactive
sudo -u postgres createdb $ME

# MariaDB
log "Install Mariadb"
sudo apt -y install mariadb-client

# MUST BE THE LAST
# Fish
log "Install Fish"
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt -y update
sudo apt -y install fish
chsh -s `which fish` # set default shell
fish
#Fisher
log "Install Fisher"
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
source ~/.config/fish/config.fish
#add fisher packages
log "Install Fish bass"
fisher install edc/bass
#oh-my-fish
log "Install Fish om-my-fish"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#setup omf + theme
log "Install Fish omf + theme"
omf install robbyrussell
omf theme robbyrussell

# NVM
log "Install NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
cp ./config.fish ~/.config/fish/config.fish
source ~/.config/fish/config.fish
nvm install lts/fermium

# Install brew gulp bower
log "Install bower + gulp + brew"
npm install -g brew gulp bower

# Delete temp directory
rm -rf ${dir_install}

log "Successfull installation. Please reboot your computer.
