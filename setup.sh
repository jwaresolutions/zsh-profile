#!bin/bash
cd ~
sudo apt update && sudo apt upgrade -y && sudo apt install zsh -y
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
