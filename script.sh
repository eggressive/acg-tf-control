#!/bin/bash
sudo yum clean all
sudo yum -y update
sudo yum install -y yum-utils git
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform