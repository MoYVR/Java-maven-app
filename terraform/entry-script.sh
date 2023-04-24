#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker 
sudo usermod -aG docker ec2-user

# install docker-compose 
apt update && apt install python3-venv python3-dev libffi-dev libssl-dev
mkdir -p /opt/local/docker-compose
python3 -m venv /opt/local/docker-compose/venv

/opt/local/docker-compose/venv/bin/pip install --upgrade pip
/opt/local/docker-compose/venv/bin/pip install docker-compose

ln -s /opt/local/docker-compose/venv/bin/docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
