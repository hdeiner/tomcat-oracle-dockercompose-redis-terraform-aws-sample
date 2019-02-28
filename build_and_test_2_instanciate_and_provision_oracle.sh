#!/usr/bin/env bash

figlet -f standard "Instanciate and Provision Oracle"

cd terraform-oracle
terraform init
terraform apply -auto-approve
echo `terraform output oracle_dns` > ../.oracle_dns
cd ..
