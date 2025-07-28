#!/bin/bash
set -e

yum update -y

amazon-linux-extras enable nginx1
yum install -y nginx
systemctl start nginx
systemctl enable nginx

yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
