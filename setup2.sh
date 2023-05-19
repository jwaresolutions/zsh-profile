#!bin/zsh

# install some packages
sudo apt install git python3 python3-pip python-is-python3 python-is-python3 -y
pip install gdown

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k/
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/jwaresolutions/zsh-profile.git ~/zsh-profile/
cd ~/zsh-profile
cp .p10k.zsh ~/
cp .zshrc ~/
cd ~ && rm -rf ~/zsh-profile
source ~/.zshrc
