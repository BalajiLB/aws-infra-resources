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

# Dynatrace OneAgent install
if [[ -z "$DYNATRACE_API_TOKEN" ]]; then
  echo "Error: DYNATRACE_API_TOKEN is not set"
  exit 1
fi

# Download installer
sudo wget -O Dynatrace-OneAgent.sh "https://njo37624.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?arch=x86" \
  --header="Authorization: Api-Token $DYNATRACE_API_TOKEN"

# Verify installer
sudo wget https://ca.dynatrace.com/dt-root.cert.pem

( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-OneAgent.sh ) \
  | sudo openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

# Install OneAgent
sudo /bin/bash Dynatrace-OneAgent.sh --set-monitoring-mode=fullstack --set-app-log-content-access=true
