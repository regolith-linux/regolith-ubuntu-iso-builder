#!/bin/bash

# This script provides common customization options for the ISO
#
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.1"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try Regolith without installing"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install Regolith"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    # Install script to install PPA
    apt install -y software-properties-common

    # Regolith PPA
    add-apt-repository -y ppa:regolith-linux/unstable

    # Base system for Regolith on Ubuntu
    apt install -y --no-install-recommends \
        alsa-base \
        apt-transport-https \
        curl \
        eog \
        evince \
        file-roller \
        gnome-font-viewer \
        gnome-screenshot \
        htop \
        i3xrocks-cpu-usage \
        i3xrocks-memory \
        i3xrocks-net-traffic \
        i3xrocks-time \
        less \
        libmutter-6-0 \
        lightdm \
        lightdm-gtk-greeter \
        nano \
        nautilus \
        neofetch \
        regolith-lightdm-config \
        regolith-system \
        ubiquity \
        ubiquity-frontend-gtk \
        ubiquity-slideshow-regolith \
        vim

    # purge packages installed by Ubuntu but uneeded in Regolith
     apt-get purge -y \
        gdm3 \
        gnome-shell \
        plymouth-theme-ubuntu-logo \
        plymouth-theme-ubuntu-text \
        ubiquity-slideshow-ubuntu \
        ubuntu-desktop \
        ubuntu-docs \
        ubuntu-mono \
        ubuntu-session \
        ubuntu-settings \
        ubuntu-standard \
        ubuntu-wallpapers-focal \
        ubuntu-wallpapers \
        snapd \
        libreoffice-base-core \
        libreoffice-calc \
        libreoffice-common \
        libreoffice-core \
        libreoffice-gnome \
        libreoffice-gtk3 \
        libreoffice-math \
        libreoffice-style-breeze \
        libreoffice-style-colibre \
        libreoffice-style-elementary \
        libreoffice-style-tango \
        libreoffice-writer \
        thunderbird 
}