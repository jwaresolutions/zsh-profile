#!bin/bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt update && sudo apt upgrade -y && sudo apt install git python3 python3-pip python-is-python3 python-is-python3 gdown -y

git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ~
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clonehttps://github.com/jwaresolutions/zsh-profile.git
cd zsh-profile
cp .p10k.zsh ~/
cp .zshrc ~/
source ~/.zshrc
