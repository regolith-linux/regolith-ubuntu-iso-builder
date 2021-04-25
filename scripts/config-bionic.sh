#!/bin/bash

# This script provides common customization options for the ISO
# 
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The version of Ubuntu to generate.  Successfully tested: focal, groovy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="bionic"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-generic"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="regolith-linux-$TARGET_UBUNTU_VERSION-1.6.0"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try Regolith"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install Regolith"

# Packages to be removed from the target system after installation completes succesfully
export TARGET_PACKAGE_REMOVE="
    ubiquity \
    casper \
    discover \
    laptop-detect \
    os-prober \
    gnome-shell \
    gdm3 \
    ubuntu-session \
    ubuntu-desktop \
"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    echo "Regolith: customize start ------------------"
    
    # General system requirements
    apt install -y \
        memtest86+ \
        software-properties-common \
        whoopsie

    # Add Regolith PPA to apt configuration
    add-apt-repository -y ppa:regolith-linux/unstable

    # Install Regolith packages
    # TODO: remove plymouth-theme-regolith, regolith-lightdm-config after fix
    apt-get install -y \
        firefox \
        firefox-locale-en \
        gnome-software \
        plymouth-theme-regolith \
        plymouth-themes \
        regolith-lightdm-config \
        regolith-system \
        software-properties-gtk \
        ubiquity-slideshow-regolith

    # Due to some unknown contention these must be removed before gnome-shell
    apt-get purge -y \
        plymouth-theme-ubuntu-logo \
        plymouth-theme-ubuntu-text

    # Remove desktop components unneeded by Regolith
    apt-get purge -y \
        gdm3 \
        gnome-shell \
        ubiquity-slideshow-ubuntu \
        ubuntu-session

    # Set wallpaper for installer.  JPG -> PNG is intentional.
    cp /usr/share/backgrounds/lucas-bellator-C0OD8OM-oM0-unsplash.jpg /usr/share/backgrounds/warty-final-ubuntu.png

    echo "Regolith: customize end ------------------"
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.3"
