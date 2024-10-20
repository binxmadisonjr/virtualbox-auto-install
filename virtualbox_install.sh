#!/bin/bash

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install VirtualBox and dependencies
echo "Installing VirtualBox..."
sudo pacman -S --noconfirm virtualbox

# Check which kernel is in use and install appropriate host modules
kernel=$(uname -r)

if [[ $kernel == *"lts"* ]]; then
    echo "Installing VirtualBox host modules for LTS kernel..."
    sudo pacman -S --noconfirm linux-lts-headers virtualbox-host-dkms
else
    echo "Installing VirtualBox host modules for default kernel..."
    sudo pacman -S --noconfirm linux-headers virtualbox-host-modules-arch
fi

# Load necessary kernel modules
echo "Loading kernel modules..."
sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt
sudo modprobe vboxpci

# Add user to vboxusers group
echo "Adding user to vboxusers group..."
sudo usermod -aG vboxusers $USER

echo "Installation complete. Please reboot your system for changes to take effect."
