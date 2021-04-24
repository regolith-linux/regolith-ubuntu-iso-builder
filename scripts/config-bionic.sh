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
export TARGET_NAME="regolith-linux-bionic-1.6.0"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try Regolith"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install Regolith"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    echo "KGWH start ------------------ "

    touch /etc/apt/preferences

    cat <<EOF > /etc/apt/preferences
Package: gnome-shell
Pin: release *
Pin-Priority: -1
EOF

    # Install script to install PPA
    apt install -y software-properties-common

    # Regolith PPA
    add-apt-repository -y ppa:regolith-linux/unstable

    echo "KGWH purge ------------------ "
    apt purge -y gnome-shell gdm3 ubuntu-session
    apt-get autoremove -y

    # echo "KGWH debug --------------------- "
    # apt-cache rdepends --installed jetty

    echo "KGWH install --------------------- "
    # Base system for Regolith on Ubuntu
    apt install --no-install-recommends -y \
        alsa-base \
        anacron \
        apparmor \
        apport-gtk \
        appstream \
        apt-config-icons \
        apt-transport-https \
        apt-utils \
        avahi-autoipd \
        bash-completion \
        bind9-dnsutils \
        build-essential \
        command-not-found \
        curl \
        debconf-i18n \
        ed \
        eog \
        ethtool \
        evince \
        file-roller \
        firefox \
        firefox-locale-en \
        fonts-ubuntu \
        fonts-yrsa-rasa \
        friendly-recovery \
        fwupd \
        fwupd-signed \
        gedit \
        gedit-common \
        ghostscript-x \
        gir1.2-goa-1.0 \
        gir1.2-gtksource-4 \
        gir1.2-wnck-3.0 \
        gnome-accessibility-themes \
        gnome-font-viewer \
        gnome-screenshot \
        gnome-software \
        gnome-software-common \
        gnome-terminal \
        gstreamer1.0-libav \
        gstreamer1.0-tools \
        gtk2-engines-pixbuf \
        hdparm \
        htop \
        i3xrocks-cpu-usage \
        i3xrocks-memory \
        i3xrocks-net-traffic \
        i3xrocks-time \
        i965-va-driver \
        info \
        init \
        install-info \
        intel-media-va-driver \
        iproute2 \
        iputils-ping \
        iputils-tracepath \
        irqbalance \
        isc-dhcp-client \
        isc-dhcp-common \
        language-pack-en \
        language-pack-en-base \
        language-pack-gnome-en \
        language-pack-gnome-en-base \
        less \
        libamtk-5-0 \
        libamtk-5-common \
        libappstream-glib8 \
        libbabeltrace1 \
        libc6-dbg \
        libcairo-gobject-perl \
        libcairo-perl \
        libcbor0.6 \
        libcc1-0 \
        libcodec2-0.9 \
        libdns-export1109 \
        libdw1 \
        libestr0 \
        libextutils-depends-perl \
        libextutils-pkgconfig-perl \
        libfastjson4 \
        libfontembed1 \
        libfwupd2 \
        libfwupdplugin1 \
        libglib-object-introspection-perl \
        libglib-perl \
        libgtk3-perl \
        libgtksourceview-4-0 \
        libgtksourceview-4-common \
        libigdgmm11 \
        libisc-export1105 \
        liblcms2-utils \
        liblightdm-gobject-1-0 \
        libmspack0 \
        libnorm1 \
        libnuma1 \
        libpgm-5.2-0 \
        libsmbios-c2 \
        libsnappy1v5 \
        libssh-gcrypt-4 \
        libtepl-4-0 \
        libtext-charwidth-perl \
        libtext-wrapi18n-perl \
        libutempter0 \
        libva-drm2 \
        libva-x11-2 \
        libva2 \
        libxdg-basedir1 \
        libxres1 \
        libzmq5 \
        lightdm \
        lightdm-gtk-greeter \
        lm-sensors \
        logrotate \
        lshw \
        ltrace \
        manpages \
        memtest86+ \
        mesa-utils \
        mesa-va-drivers \
        mesa-vdpau-drivers \
        nano \
        nautilus \
        neofetch \
        netcat-openbsd \
        openssh-client \
        p7zip-full \
        pinentry-gtk2 \
        pkg-config \
        plymouth-themes \
        plymouth-theme-regolith \
        poppler-utils \
        powermgmt-base \
        python3-commandnotfound \
        python3-dateutil \
        python3-debian \
        python3-distupgrade \
        python3-gdbm \
        python3-netifaces \
        python3-olefile \
        python3-pexpect \
        python3-pil \
        python3-ptyprocess \
        python3-renderpm \
        python3-reportlab \
        python3-reportlab-accel \
        python3-update-manager \
        python3-yaml \
        regolith-lightdm-config \
        regolith-desktop-standard \
        regolith-system \
        rsync \
        rsyslog \
        secureboot-db \
        software-properties-gtk \
        ssl-cert \
        strace \
        tcpdump \
        time \
        tpm-udev \
        ubiquity-slideshow-regolith \
        ubuntu-minimal \
        ubuntu-release-upgrader-core \
        ubuntu-release-upgrader-gtk \
        ubuntu-standard \
        ufw \
        update-manager \
        update-manager-core \
        update-notifier \
        update-notifier-common \
        va-driver-all \
        vdpau-driver-all \
        vim \
        wamerican \
        whiptail \
        xclip

        # Set wallpaper for installer.  JPG -> PNG is intentional.
        cp /usr/share/backgrounds/lucas-bellator-C0OD8OM-oM0-unsplash.jpg /usr/share/backgrounds/warty-final-ubuntu.png

        echo "KGWH: customize complete ---------------"
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.2"