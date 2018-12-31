#!/bin/bash

# Install Docker CE Stable
# JL: Add Docker’s official GPG key:
#     reference link:  https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify that the key fingerprint is 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
# sudo apt-key fingerprint 0EBFCD88
# JL: Use the following command to set up the stable repository.
#     platform: x86_64/amd64
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# JL: Update the apt package index.
sudo apt-get update
# JL: Install the latest version of Docker CE, or go to the next step to install a specific version:
sudo apt-get install -y docker-ce

# Give the ubuntu user the right to launch containers
# JL: Create the docker group and add your user.
sudo usermod -a -G docker ubuntu

# Install nvidia-docker
# JL: Download the nividia docker
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb && \
# JL: Install nvidia docker package
sudo dpkg -i nvidia-docker*.deb && \
# JL: Remove downloaded nvidia docker package
rm -f nvidia-docker*.deb

# Cleanup
# JL: Clears out the local repository of retrieved package files.
sudo apt-get clean && \
# JL: autoremove is used to remove packages that were automatically installed 
#     to satisfy dependencies for other packages and are now no longer needed.
sudo apt-get autoremove && \
# JL: Remove the cache contents in /var/lib/apt/lists after refreshing the 
#     package lists
#     When you run sudo apt-get update (or use the Refresh button in a 
#     package manager), a list of packages will get downloaded from the 
#     Ubuntu servers. These files are then stored in /var/lib/apt/lists/.
sudo rm -r /var/lib/apt/lists/*

echo ""
echo "******************************************************************"
echo "*                                                                *"
echo "* Logging out for changes to take effect!                        *"
echo "*                                                                *"
echo "******************************************************************"
echo ""

exit
