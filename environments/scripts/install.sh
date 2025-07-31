#!/bin/bash
set -e

# Update packages
sudo dnf update -y

# Install nginx
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Docker
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Install Dynatrace OneAgent
sudo wget -O Dynatrace-OneAgent.sh "https://njo37624.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?arch=x86" --header="Authorization: Api-Token dt0c01.OVILZWQLOAVZCXRYLQW5W5VV.4TDAY2YSLZRIYZWUTZ6N3F4FCBEBZZZBEXTNE5OTSGBDC6PEPSVSF7B6XPR2KCGK"

sudo wget https://ca.dynatrace.com/dt-root.cert.pem

( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-OneAgent.sh ) | sudo openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

sudo /bin/bash Dynatrace-OneAgent.sh --set-monitoring-mode=fullstack --set-app-log-content-access=true
