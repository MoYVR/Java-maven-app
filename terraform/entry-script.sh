#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
docker run -p 8080:80 nginx

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
