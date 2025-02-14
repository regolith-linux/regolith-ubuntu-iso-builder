#!/bin/bash

# This script provides common customization options for the ISO
#
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The brand name of the distribution
export TARGET_DISTRO_NAME="Regolith"

# The version of the distribution to be installed
export TARGET_DISTRO_VERSION="2.1.0"

# The version of Ubuntu to generate.  Successfully tested: bionic, cosmic, disco, eoan, jammy, groovy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="jammy"

# The Ubuntu Mirror URL. It's better to change for faster download.
# More mirrors see: https://launchpad.net/ubuntu/+archivemirrors
export TARGET_UBUNTU_MIRROR="http://us.archive.ubuntu.com/ubuntu/"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-generic"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="${TARGET_DISTRO_NAME-mini// /_}"

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
    snapd \
"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    apt update

    apt install -y \
        gpg \
        wget \
        software-properties-common

    wget -qO - https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg
    echo -e "\ndeb [arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | sudo tee /etc/apt/sources.list.d/regolith.list

    # Fix firefox ~ https://ubuntuhandbook.org/index.php/2022/04/install-firefox-deb-ubuntu-22-04/
    apt-get purge -y firefox
    add-apt-repository -y ppa:mozillateam/ppa
    echo "Package: firefox*" > /etc/apt/preferences.d/mozillateamppa
    echo "Pin: release o=LP-PPA-mozillateam" >> /etc/apt/preferences.d/mozillateamppa
    echo "Pin-Priority: 501" >> /etc/apt/preferences.d/mozillateamppa
    apt update

    # install graphics and desktop
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
        memtest86+ \
        metacity \
        nautilus \
        network-manager-openvpn \
        network-manager-openvpn-gnome \
        network-manager-pptp-gnome \
        plymouth-theme-regolith-logo \
        policykit-desktop-privileges \
        regolith-system-ubuntu \
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

    # purge
    apt-get purge -y \
        aisleriot \
        evolution-data-server \
        evolution-data-server-common \
        gdm3 \
        gnome-mahjongg \
        gnome-mines \
        gnome-sudoku \
        hitori \
        lightdm-gtk-greeter \
        plymouth-theme-spinner \
        plymouth-theme-ubuntu-text \
        transmission-common \
        transmission-gtk \
        ubuntu-desktop \
        ubuntu-session \
        snapd

    apt-get autoremove -y

    # Set wallpaper for installer
    cp /usr/share/backgrounds/pia21972.png /usr/share/backgrounds/warty-final-ubuntu.png

    # Specify Regolith session for autologin
    echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf.d/10_regolith.conf
    echo "user-session=regolith" >> /etc/lightdm/lightdm.conf.d/10_regolith.conf
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"
