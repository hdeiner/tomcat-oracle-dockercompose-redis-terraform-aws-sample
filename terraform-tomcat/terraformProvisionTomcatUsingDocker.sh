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

echo "Start the tomcat server"
sudo docker-compose -f compose-tomcat.yml -p redis-oracle-tomcat up -d

echo "Waiting for Tomcat to start"
while true ; do
  curl -s localhost:8080 > tmp.txt
  result=$(grep -c "HTTP Status 404" tmp.txt)
  if [ $result = 1 ] ; then
    echo "Tomcat has started"
    break
  fi
  sleep 1
done
rm tmp.txt

# Deploy the app to test
sudo docker cp oracleConfig.properties tomcat:/usr/local/tomcat/webapps/oracleConfig.properties
sudo docker cp passwordAPI.war tomcat:/usr/local/tomcat/webapps/passwordAPI.war

# Allow Tomcat time to digest
sleep 10

# Console help
echo "ls -l /usr/local/tomcat/webapps/"
sudo docker exec -it tomcat bash -c "ls -l /usr/local/tomcat/webapps"
echo "cat /usr/local/tomcat/webapps/oracleConfig.properties"
sudo docker exec -it tomcat bash -c "cat /usr/local/tomcat/webapps/oracleConfig.properties"