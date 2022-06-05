#!/bin/bash

# This script provides common customization options for the ISO
# 
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The brand name of the distribution
export TARGET_DISTRO_NAME="Regolith"

# The version of the distribution to be installed
export TARGET_DISTRO_VERSION="2.0.0"

# The version of Ubuntu to generate.  Successfully tested: focal, groovy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="jammy"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-generic"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="${TARGET_DISTRO_NAME// /_}"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try $TARGET_DISTRO_NAME"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install $TARGET_DISTRO_NAME"

# A link to a web page containing release notes associated with the installation
# Selectable in the first page of the Ubiquity installer
export RELEASE_NOTES_URL="https://regolith-desktop.com/docs/reference/Releases/regolith-2.0-release-notes/"

# Name and version of distribution
export VERSIONED_DISTRO_NAME="$TARGET_DISTRO_NAME $TARGET_DISTRO_VERSION $TARGET_UBUNTU_VERSION"

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
    budgie-core \
    metacity \
"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    echo "Regolith: start ------------------"
    
    # General system requirements
    apt install -y \
        memtest86+ \
        software-properties-common \
        whoopsie

    # Add Regolith repo to apt configuration
    wget -qO - https://regolith-desktop.io/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg
    echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.io/release-ubuntu-jammy-amd64 jammy main" | sudo tee /etc/apt/sources.list.d/regolith.list
    apt update

    # Install Regolith packages
    # TODO: remove plymouth-theme-regolit after fix in regolith-system
    # NOTE: metacity satisfies a hard-coded window manager dependency for ubiquity
    apt-get install -y \
        acpi-support \
        acpid \
        apt-transport-https \
        apturl \
        apturl-common \
        avahi-autoipd \
        dmz-cursor-theme \
        eog \
        file-roller \
        firefox \
        firefox-locale-en \
        gnome-disk-utility \
        gnome-font-viewer \
        gnome-power-manager \
        gnome-screenshot \
        kerneloops \
        language-pack-en \
        language-pack-en-base \
        language-pack-gnome-en \
        language-pack-gnome-en-base \
        less \
        libnotify-bin \
        metacity \
        nautilus \
        network-manager-openvpn \
        network-manager-openvpn-gnome \
        network-manager-pptp-gnome \
        plymouth-theme-regolith-logo \
        plymouth-themes \
        policykit-desktop-privileges \
        regolith-distro-ubuntu \
        rfkill \
        rsyslog \
        shim-signed \
        software-properties-gtk \
        ssl-cert \
        syslinux \
        syslinux-common \
        thermald \
        ubiquity-slideshow-regolith \
        ubuntu-release-upgrader-gtk \
        update-notifier \
        vim \
        wbritish \
        xcursor-themes \
        xdg-user-dirs-gtk \
        zip

    apt-get install --no-install-recommends -o Debug::pkgProblemResolver=true -y \
        gnome-software

    # Due to some unknown contention these must be removed before gnome-shell
    apt-get -o Debug::pkgProblemResolver=true purge -y \
        plymouth-theme-ubuntu-text \
        plymouth-theme-spinner \
        gnome-remote-desktop

    # Remove desktop components unneeded by Regolith
    apt-get -o Debug::pkgProblemResolver=true purge -y \
        gdm3 \
        gnome-shell \
        ubuntu-session \
        ubiquity-ubuntu-artwork

    # Set wallpaper for installer.  JPG -> PNG is intentional.
    # Disabled temporarily for 2.0
    # cp /usr/share/backgrounds/dennis-schweizer-18nR85wWyLY-unsplash.jpg /usr/share/backgrounds/warty-final-ubuntu.png

    # Specify Regolith session for autologin
    echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf.d/10_regolith.conf
    echo "user-session=regolith" >> /etc/lightdm/lightdm.conf.d/10_regolith.conf 

    echo "Regolith: end ------------------"
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"
