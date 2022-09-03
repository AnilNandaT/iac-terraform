#!/bin/bash

sudo aws s3 cp s3://prepaire-packer-artifact/sonarqube-9.5.0.56709.zip /opt/sonarqube-9.5.0.56709.zip
sudo aws s3 cp s3://prepaire-packer-artifact/jdk-11.0.15_linux-x64_bin.tar.gz /opt/jdk-11.0.15_linux-x64_bin.tar.gz

sudo yum install -y unzip
sudo yum update -y
sudo unzip /opt/sonarqube-9.5.0.56709.zip -d /opt/

sudo tar -xf /opt/jdk-11.0.15_linux-x64_bin.tar.gz -C /opt/

sudo mv /opt/jdk-11.0.15 /opt/java
sudo mv /opt/sonarqube-9.5.0.56709 /opt/sonarqube

sudo useradd sonarqube

sudo chown -R sonarqube:sonarqube /opt/sonarqube /opt/java

sudo tee /etc/systemd/system/sonarqube.service << EOF
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=simple
User=sonarqube
Group=sonarqube
PermissionsStartOnly=true
ExecStart=/bin/nohup /opt/java/bin/java -Xms32m -Xmx32m -Djava.net.preferIPv4Stack=true -jar /opt/sonarqube/lib/sonar-application-9.5.0.56709.jar
StandardOutput=syslog
LimitNOFILE=131072
LimitNPROC=8192
TimeoutStartSec=5
Restart=always
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable sonarqube.service
sudo systemctl start sonarqube.service

sudo yum remove -y unzip