#!/bin/bash

# Update package repositories
sudo apt-get update

# Install OpenJDK 11
yes | sudo apt install openjdk-11-jdk-headless

# Wait for 30 seconds before installing Jenkins package
echo "Waiting for 30 seconds before installing the Jenkins package..."
sleep 30

# Download Jenkins package key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package repositories with new Jenkins repository
sudo apt-get update

# Install Jenkins
yes | sudo apt-get install jenkins

# Wait for 30 seconds before installing Terraform
echo "Waiting for 30 seconds before installing Terraform..."
sleep 30

# Download Terraform
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip

# Install unzip utility
yes | sudo apt-get install unzip

# Unzip Terraform package
unzip 'terraform*.zip'

# Move Terraform binary to bin directory
sudo mv terraform /usr/local/bin/
