#!/bin/bash

sudo tee /etc/yum.repos.d/mongodb-org-5.0.repo << EOF
[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
EOF

sudo tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/oraclelinux/8/
gpgcheck=0
enabled=1
EOF

yum clean all
sudo yum -y install oracle-epel-release-el8
sudo yum-config-manager --enable ol8_developer_EPEL
sudo yum -y update
sudo yum -y install wireguard-tools
sudo yum -y remove iptables-services
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service


gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A

gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; sudo rpm --import key.tmp; rm -f key.tmp

sudo rpm --import https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc
sudo yum -y install pritunl mongodb-org
sudo systemctl enable mongod pritunl
sudo systemctl start mongod pritunl

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
