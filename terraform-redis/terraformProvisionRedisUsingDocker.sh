#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# Install Docker
sudo apt-get -qq install -y docker-ce

# Install Docker-Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Start the redis server"
sudo docker-compose -f compose-redis.yml -p redis-oracle-tomcat up -d

echo "Waiting for Redis to start"
while true ; do
  result=$(sudo docker logs redis 2> /dev/null | grep -c "Ready to accept connections")
  if [ $result = 1 ] ; then
    echo "Redis has started"
    break
  fi
  sleep 1
done
