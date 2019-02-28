#!/usr/bin/env bash

figlet -f standard "Instanciate and Provision Tomcat"

export REDIS=$(echo `cat ./.redis_dns`)

echo "Build fresh war for Tomcat deployment"
mvn -q clean compile war:war

echo "Build the oracleConfig.properties file for the Tomcat application under test"
redis-cli -h $REDIS get OracaleConfigURL > oracleConfig.properties
redis-cli -h $REDIS get OraclConfigUser >> oracleConfig.properties
redis-cli -h $REDIS get OracleConfigPassword >> oracleConfig.properties

cd terraform-tomcat
terraform init
terraform apply -auto-approve
echo `terraform output tomcat_dns` > ../.tomcat_dns
cd ..

