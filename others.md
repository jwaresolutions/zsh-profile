#### Anaconda

the wget command from below was the latest when this was created. dont be lazy and get the latest version.
copy the name of the latest version of Anaconda3.*Linux-x86_64.sh from https://repo.anaconda.com/archive/


```
wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
zsh Anaconda3-2023.07-2-Linux-x86_64.sh
export PATH="/root/anaconda3/bin:$PATH"
```


#### Docker
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

#### Aider (Requires Anaconda)

```
conda create -n Aider python=3.11.4
export OPENAI_API_KEY={yourkeyhere}
conda activate Aider
pip install aider-chat
sudo apt install universal-ctags
```

#### Run universal-ctags in the git directory
```
ctags .
```

#### run Aider
```
aider --map-tokens 4096 --chat-history-file ~/aider/.aider.chat.history.md --input-history-file ~/aider/.aider.input.history --no-auto-commits
```

