#!bin/zsh

# the wget command from below was the latest when this was created. dont be lazy and get the latest version. copy the name of the latest version of Anaconda3.*Linux-x86_64.sh from https://repo.anaconda.com/archive/

wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
zsh Anaconda3-2023.07-2-Linux-x86_64.sh
export PATH="/root/anaconda3/bin:$PATH"
