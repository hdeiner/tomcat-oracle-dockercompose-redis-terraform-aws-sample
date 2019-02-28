#!/usr/bin/env bash

figlet -f standard "Instanciate and Provision Redis"

cd terraform-redis
terraform init
terraform apply -auto-approve
echo `terraform output redis_dns` > ../.redis_dns
cd ..