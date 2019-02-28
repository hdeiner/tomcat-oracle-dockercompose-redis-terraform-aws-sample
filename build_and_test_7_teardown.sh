#!/usr/bin/env bash

figlet -f standard "Teardown Everything"

cd terraform-redis
terraform destroy -auto-approve
cd ..

cd terraform-oracle
terraform destroy -auto-approve
cd ..

cd terraform-tomcat
terraform destroy -auto-approve
cd ..

rm ./.redis_dns ./.oracle_dns ./.tomcat_dns liquibase.properties oracleConfig.properties