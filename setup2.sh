#!bin/bash

# install some packages
sudo apt install git python3 python3-pip python-is-python3 python-is-python3 gdown -y
pip install gdown

# install powerlevel10k and dependencies
#git clone https://github.com/ryanoasis/nerd-fonts.git
#cd nerd-fonts
#./install.sh
#cd ~ && rm -rf nerd-fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/jwaresolutions/zsh-profile.git ~/zsh-profile/
cd ~/zsh-profile
cp .p10k.zsh ~/
cp .zshrc ~/
cd ~ && rm -rf ~/zsh-profile
source ~/.zshrc
