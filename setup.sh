#!bin/bash

# install zsh
sudo apt update 
DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade
DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade

# install some packages
DEBIAN_FRONTEND='noninteractive' apt install -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' git python3 python3-pip python-is-python3 python-is-python3 zsh
pip install gdown
apt-get autoremove -y
apt-get clean
apt-get autoclean

# install oh-my-zsh and theme/plugins/fonts
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k/
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/jwaresolutions/zsh-profile.git ~/zsh-profile/

cp ~/zsh-profile/.p10k.zsh ~/
cp ~/zsh-profile/.zshrc ~/
# cd ~ && rm -rf ~/zsh-profile
chsh -s $(which zsh)
zsh
