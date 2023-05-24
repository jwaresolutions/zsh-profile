#!bin/zsh
source ~/.zshrc

# install some packages
sudo apt install git python3 python3-pip python-is-python3 python-is-python3 -y
pip install gdown

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k/
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/jwaresolutions/zsh-profile.git ~/zsh-profile/

cp ~/zsh-profile/.p10k.zsh ~/
cp ~/zsh-profile/.zshrc ~/
# cd ~ && rm -rf ~/zsh-profile
source ~/.zshrc
