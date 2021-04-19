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
        foomatic-db-compressed-ppds \
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
        hplip \
        hplip-data \
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
        libaacs0 \
        libamtk-5-0 \
        libamtk-5-common \
        libaom0 \
        libappstream-glib8 \
        libass9 \
        libatm1 \
        libavcodec58 \
        libavfilter7 \
        libavformat58 \
        libavutil56 \
        libbabeltrace1 \
        libbdplus0 \
        libbluray2 \
        libbs2b0 \
        libc6-dbg \
        libcairo-gobject-perl \
        libcairo-perl \
        libcbor0.6 \
        libcc1-0 \
        libchromaprint1 \
        libcodec2-0.9 \
        libcupsfilters1 \
        libdns-export1109 \
        libdw1 \
        libestr0 \
        libextutils-depends-perl \
        libextutils-pkgconfig-perl \
        libfastjson4 \
        libfido2-1 \
        libflite1 \
        libfontembed1 \
        libfwupd2 \
        libfwupdplugin1 \
        libgcab-1.0-0 \
        libglib-object-introspection-perl \
        libglib-perl \
        libgme0 \
        libgsm1 \
        libgtk3-perl \
        libgtksourceview-4-0 \
        libgtksourceview-4-common \
        libhpmud0 \
        libigdgmm11 \
        libimagequant0 \
        libindicator3-7 \
        libisc-export1105 \
        liblcms2-utils \
        liblightdm-gobject-1-0 \
        liblilv-0-0 \
        libllvm9 \
        liblouis-data \
        liblouis20 \
        liblouisutdml-bin \
        liblouisutdml-data \
        liblouisutdml9 \
        libmspack0 \
        libmysofa1 \
        libnetplan0 \
        libnorm1 \
        libnuma1 \
        libopenmpt0 \
        libpgm-5.2-0 \
        libpoppler-cpp0v5 \
        libpostproc55 \
        libqpdf26 \
        librubberband2 \
        libsane-hpaio \
        libserd-0-0 \
        libshine3 \
        libsmbios-c2 \
        libsnappy1v5 \
        libsord-0-0 \
        libsratom-0-0 \
        libssh-gcrypt-4 \
        libswresample3 \
        libswscale5 \
        libtepl-4-0 \
        libtext-charwidth-perl \
        libtext-wrapi18n-perl \
        libtss2-esys0 \
        libtumbler-1-0 \
        libutempter0 \
        libva-drm2 \
        libva-x11-2 \
        libva2 \
        libvdpau1 \
        libvidstab1.1 \
        libwnck-3-0 \
        libwnck-3-common \
        libx264-155 \
        libx265-179 \
        libxdg-basedir1 \
        libxmlb1 \
        libxmlsec1 \
        libxmlsec1-openssl \
        libxres1 \
        libxvidcore4 \
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
        openprinting-ppds \
        openssh-client \
        p7zip \
        p7zip-full \
        patch \
        pinentry-gtk2 \
        pkg-config \
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

        echo "KGWH: rdepends gnome-shell ---------------"

        apt-cache rdepends --installed gnome-shell

        apt purge -y ubuntu-session

        echo "KGWH: customize complete ---------------"
}