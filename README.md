  VirtualBox Installation Script README

VirtualBox Installation Script
==============================

This script automates the installation of VirtualBox and its necessary dependencies on an Arch Linux system. It also ensures that the correct host modules for your kernel are installed, loads the required kernel modules, and adds the current user to the `vboxusers` group for VirtualBox access.

Prerequisites
-------------

*   Arch Linux or an Arch-based distribution
*   A working internet connection
*   Sudo privileges for the current user

What the Script Does
--------------------

1.  **System Update**: Updates the system using `pacman`.
2.  **VirtualBox Installation**: Installs VirtualBox.
3.  **Kernel Detection**: Detects the kernel type (default or LTS) and installs the corresponding VirtualBox host modules.
4.  **Kernel Module Loading**: Loads the necessary kernel modules for VirtualBox to function.
5.  **User Group Assignment**: Adds the current user to the `vboxusers` group for VirtualBox access.
6.  **Reboot Prompt**: Prompts the user to reboot the system to apply changes.

How to Use
----------

1.  Download the script or create it manually:
    
        curl -O https://example.com/install_virtualbox.sh
    
    _(Replace `https://example.com` with the correct link if hosted somewhere)_
    
2.  Make the script executable:
    
        chmod +x install_virtualbox.sh
    
3.  Run the script:
    
        ./install_virtualbox.sh
    
4.  Reboot your system after the script completes to apply all changes:
    
        sudo reboot
    

Script Breakdown
----------------

*   **Update System:**
    
        sudo pacman -Syu --noconfirm
    
    Ensures all packages are up to date.
    
*   **Install VirtualBox:**
    
        sudo pacman -S --noconfirm virtualbox
    
    Installs VirtualBox using the `pacman` package manager.
    
*   **Kernel Detection:**
    
    The script checks if the system is using the LTS kernel (`linux-lts`) or the default kernel, and installs the appropriate host modules accordingly.
    
        if [[ $kernel == *"lts"* ]]; then
            sudo pacman -S --noconfirm linux-lts-headers virtualbox-host-dkms
        else
            sudo pacman -S --noconfirm linux-headers virtualbox-host-modules-arch
        fi
    
*   **Load Kernel Modules:**
    
    Loads the necessary kernel modules using `modprobe` to ensure VirtualBox runs properly.
    
        sudo modprobe vboxdrv
        sudo modprobe vboxnetadp
        sudo modprobe vboxnetflt
        sudo modprobe vboxpci
    
*   **User Group Assignment:**
    
    Adds the current user to the `vboxusers` group for the necessary permissions.
    
        sudo usermod -aG vboxusers $USER
    

Notes
-----

*   After installation, you **must** reboot the system for the changes to take effect.
*   Ensure that your system's kernel headers are installed for the appropriate kernel version before running VirtualBox.
