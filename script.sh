#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum clean all
sudo yum -y update
sudo yum install -y yum-utils git
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform version > /var/tmp/tf-version.txt
su - ec2-user -c 'terraform -install-autocomplete'
