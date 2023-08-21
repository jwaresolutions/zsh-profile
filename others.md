Install stupid anaconda

copy the name of the latest version of Anaconda3.*Linux-x86_64.sh from https://repo.anaconda.com/archive/
wget https://repo.anaconda.com/archive/{Anaconda file name}

wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
zsh Anaconda3-2023.07-2-Linux-x86_64.sh
export PATH="/root/anaconda3/bin:$PATH"



Install stupid docker
```
sudo apt update
sudo apt install ca-certificates curl apt-transport-https -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y
```
