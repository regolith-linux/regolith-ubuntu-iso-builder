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
    apt install -y software-properties-common

    add-apt-repository -y ppa:regolith-linux/unstable

    apt install -y --no-install-recommends \
        alsa-base \
        lightdm \
        lightdm-gtk-greeter \
        nautilus \
        regolith-lightdm-config \
        ubiquity-frontend-gtk \
        ubiquity-slideshow-regolith \
        ubiquity \
        eog \
        evince \
        file-roller \
        gedit \
        gnome-font-viewer \
        htop \
        neofetch \
        vim \
        regolith-system \
        i3xrocks-cpu-usage \
        i3xrocks-memory \
        i3xrocks-net-traffic \
        i3xrocks-time \
        libmutter-6-0 \
        apt-transport-https \
        curl \
        vim \
        nano \
        less \
        gnome-screenshot

    # purge
    apt-get purge -y \
        gdm3 \
        gnome-shell \
        xfce4-appfinder \
        xfce4-cpugraph-plugin \
        xfce4-dict \
        xfce4-indicator-plugin \
        xfce4-mailwatch-plugin \
        xfce4-netload-plugin \
        xfce4-notes \
        xfce4-notes-plugin \
        xfce4-notifyd \
        xfce4-panel \
        xfce4-places-plugin \
        xfce4-power-manager \
        xfce4-power-manager-data \
        xfce4-power-manager-plugins \
        xfce4-pulseaudio-plugin \
        xfce4-screenshooter \
        xfce4-session \
        xfce4-settings \
        xfce4-statusnotifier-plugin \
        xfce4-systemload-plugin \
        xfce4-taskmanager \
        xfce4-terminal \
        xfce4-verve-plugin \
        xfce4-weather-plugin \
        xfce4-whiskermenu-plugin \
        xfce4-xkb-plugin \
        libxfce4panel-2.0-4 \
        libxfce4ui-1-0 \
        libxfce4ui-2-0 \
        libxfce4ui-common \
        libxfce4ui-utils \
        libxfce4util-bin \
        libxfce4util-common \
        libxfce4util7 \
        plymouth-theme-ubuntu-logo \
        plymouth-theme-ubuntu-text \
        ubiquity-slideshow-ubuntu \
        ubuntu-artwork \
        ubuntu-community-wallpapers \
        ubuntu-community-wallpapers-bionic \
        ubuntu-core \
        ubuntu-default-settings \
        ubuntu-desktop \
        ubuntu-docs \
        ubuntu-icon-theme \
        ubuntu-live-settings \
        ubuntu-wallpapers \
        snapd \
        greybird-gtk-theme \
        libreoffice-base-core \
        libreoffice-calc \
        libreoffice-common \
        libreoffice-core \
        libreoffice-gnome \
        libreoffice-gtk3 \
        libreoffice-math \
        libreoffice-style-elementary \
        libreoffice-style-galaxy \
        libreoffice-style-tango \
        libreoffice-writer \
        mate-calc \
        mate-calc-common \
        mousepad \
        numix-gtk-theme \
        pidgin \
        pidgin-data \
        pidgin-libnotify \
        pidgin-otr \
        ristretto \
        shimmer-themes \
        thunar \
        thunar-archive-plugin \
        thunar-data \
        thunar-media-tags-plugin \
        thunar-volman \
        thunderbird \
        xfburn \
        xfpanel-switch \
        xfwm4 \
        blueman \
        mugshot \
        atril \
        catfish \
        engrampa \
        sgt-launcher \
        sgt-puzzles \
        gnome-sudoku \
        xserver-xorg-input-synaptics
}