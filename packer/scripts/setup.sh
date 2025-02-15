#!/bin/bash
# A Bash script to install Docker and Docker Compose on Ubuntu 22
# updated with instructions from https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

# fix: debconf: unable to initialize frontend: Dialog
echo set debconf to Noninteractive
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

# Install Docker

# Update existing packages:
sudo apt-get -y update
# fix: Could not get lock /var/lib/dpkg/lock-frontend. It is held by process
while sudo lsof /var/lib/dpkg/lock-frontend ; do sleep 10; done;  

sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    apt-transport-https \
    software-properties-common
# Add the GPG key for the official Docker repository to the system:
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# Add the Docker repository to APT sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# fix: Could not get lock /var/lib/apt/lists/lock. It is held by process
while sudo lsof /var/lib/apt/lists/lock ; do sleep 10; done;  
# Install Docker:
sudo apt-get -y update

# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
apt-cache policy docker-ce

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Test your installation:
docker compose version