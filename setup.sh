#!/bin/bash

# Step 1: Create bitwarden user and group
sudo adduser --disabled-login --gecos "Bitwarden User" bitwarden
sudo passwd bitwarden

# Step 2: Add the bitwarden user to the docker group
sudo groupadd docker  # Ensures the 'docker' group exists
sudo usermod -aG docker bitwarden

# Step 3: Create and set permissions for the Bitwarden directory
sudo mkdir -p /opt/bitwarden
sudo chmod -R 700 /opt/bitwarden
sudo chown -R bitwarden:bitwarden /opt/bitwarden

# Step 4: Wait for 5 seconds (use sleep instead of wait)
sleep 5

# Step 5: Switch to the bitwarden user and download Bitwarden install script
echo "Switching to user 'bitwarden'..."
su - bitwarden -c "
    cd /opt/bitwarden
    curl -Lso bitwarden.sh 'https://func.bitwarden.com/api/dl/?app=self-host&platform=linux' && chmod 700 bitwarden.sh
    ./bitwarden.sh install
"

echo "Bitwarden installation script has finished."
