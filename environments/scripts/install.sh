#!/bin/bash
set -e

# Update packages
sudo dnf update -y

# Install nginx directly
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Docker
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user
