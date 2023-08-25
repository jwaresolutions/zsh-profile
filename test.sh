#!bin/bash

# install zsh
DEBIAN_FRONTEND=noninteractive
sudo apt update && sudo apt upgrade -y
curl -L git.io/antigen > antigen.zsh #from https://github.com/zsh-users/antigen
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"

# install some packages
sudo apt install git python3 python3-pip python-is-python3 python-is-python3 -y
pip install gdown -y

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k/
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/jwaresolutions/zsh-profile.git ~/zsh-profile/

cp ~/zsh-profile/.p10k.zsh ~/
cp ~/zsh-profile/.zshrc ~/
# cd ~ && rm -rf ~/zsh-profile
/bin/zsh /home/main/.zshrc
source ~/.zshrc
