#!/bin/bash
# Script to install Terraform on Azure VMSS instances
# This script should be run as part of the VMSS custom script extension

set -e

echo "Starting Terraform installation on VMSS instance..."

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt-get install -y gnupg software-properties-common wget zip unzip curl

# Add HashiCorp GPG key
echo "Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the key's fingerprint
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

# Add HashiCorp repository
echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
echo "Installing Terraform..."
sudo apt-get update -y
sudo apt-get install -y terraform

# Verify installation
echo "Verifying Terraform installation..."
terraform version

# Install Azure CLI (needed for Azure authentication)
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify Azure CLI installation
echo "Verifying Azure CLI installation..."
az version

# Install Git (if not already installed)
echo "Installing Git..."
sudo apt-get install -y git

# Install jq for JSON processing
echo "Installing jq..."
sudo apt-get install -y jq

# Create workspace directory for Azure DevOps agent
echo "Creating Azure DevOps agent workspace..."
sudo mkdir -p /agent
sudo chmod -R 777 /agent

echo "========================================="
echo "Terraform installation completed successfully!"
echo "Terraform version:"
terraform version
echo "Azure CLI version:"
az version --output json | jq -r '.["azure-cli"]'
echo "========================================="
echo "Instance is ready for Azure DevOps agent deployment"
