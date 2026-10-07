#!/bin/bash
#
# LarpOS airootfs customization (Hyprland Edition).
# Runs via arch-chroot AFTER package installation, so it can safely
# overwrite files owned by packages without pacman file conflicts.

_osr=/usr/lib/os-release

# Preserve IMAGE_ID / IMAGE_VERSION lines injected earlier by mkarchiso
_img="$(grep -h '^IMAGE_ID=' "${_osr}" 2>/dev/null)"
_imgv="$(grep -h '^IMAGE_VERSION=' "${_osr}" 2>/dev/null)"

version="$(date -u +%Y.%m)"

cat > "${_osr}" <<OSR
NAME="LarpOS"
PRETTY_NAME="LarpOS 2.0 Blood Moon (Arch Linux based)"
ID=larpos
ID_LIKE=arch
BUILD_ID=rolling
VERSION=2.0
VERSION_ID=2.0
VARIANT="Hyprland Edition"
VARIANT_ID=hyprland
ANSI_COLOR="0;31"
HOME_URL="https://github.com/larpos"
SUPPORT_URL="https://wiki.archlinux.org/"
BUG_REPORT_URL="https://github.com/larpos/issues"
OSR

if [ -n "${_img}" ]; then
    printf '%s\n' "${_img}" >> "${_osr}"
fi
if [ -n "${_imgv}" ]; then
    printf '%s\n' "${_imgv}" >> "${_osr}"
fi

# ---------------------------------------------------------------------------
# Service wiring: recreate ALL symlinks natively, here in the build chroot.
# Git checkouts on Windows (core.symlinks=false) turn repo symlinks into
# plain text files containing the target path; systemd then loads those as
# empty no-op units. Rebuilding the links here makes the produced ISO
# correct regardless of how the repo was cloned.
# ---------------------------------------------------------------------------
# greetd + tuigreet: the display manager (autologin on live, login on install)
ln -sfn /usr/lib/systemd/system/greetd.service /etc/systemd/system/multi-user.target.wants/greetd.service
# explicit graphical default target
ln -sfn /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
# networking / time / mirrors
ln -sfn /usr/lib/systemd/system/NetworkManager.service /etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -sfn /etc/systemd/system/choose-mirror.service /etc/systemd/system/multi-user.target.wants/choose-mirror.service
ln -sfn /usr/lib/systemd/system/systemd-timesyncd.service /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service

# /etc/os-release must be a real symlink to the branded file above
rm -f /etc/os-release
ln -s /usr/lib/os-release /etc/os-release

# VirtualBox guest service (time sync, clipboard) - only if pkg is present
if [ -f /usr/lib/systemd/system/vboxservice.service ]; then
    ln -sfn /usr/lib/systemd/system/vboxservice.service \
        /etc/systemd/system/multi-user.target.wants/vboxservice.service
fi

# Mask tty1 getty: greetd owns vt1 (it conflicts with getty@tty1 anyway,
# but an explicit mask makes boot logs clean)
rm -f /etc/systemd/system/getty@tty1.service
ln -sfn /dev/null /etc/systemd/system/getty@tty1.service

# Enable fstrim + pacman cache housekeeping for installed systems
ln -sfn /usr/lib/systemd/system/fstrim.timer /etc/systemd/system/timers.target.wants/fstrim.timer


# ---------------------------------------------------------------------------
# Calamares installer configuration. The cachyos-calamares package ships its
# own /etc/calamares files; this script runs AFTER package installation via
# arch-chroot, so writing our configs here overwrites them without pacman
# file conflicts.
# ---------------------------------------------------------------------------
mkdir -p /etc/calamares/branding/larpos /etc/calamares/modules

cat > /etc/calamares/settings.conf <<'EOF_SET'
modules-search: [ local ]

sequence:
    show:
        - welcome
        - locale
        - keyboard
        - partition
        - users
        - summary
    exec:
        - partition
        - mount
        - unpackfs
        - machineid
        - fstab
        - locale
        - keyboard
        - localecfg
        - users
        - displaymanager
        - networkcfg
        - hwclock
        - services-systemd
        - bootloader
        - grubcfg
        - umount

branding: larpos
prompt-install: true
dont-chroot: false
EOF_SET

cat > /etc/calamares/branding/larpos/branding.desc <<'EOF_BR'
---
componentName:  larpos

strings:
    productName:         LarpOS
    shortProductName:    LarpOS
    version:             2.0
    shortVersion:        2.0
    versionedName:       LarpOS 2.0 Blood Moon
    shortVersionedName:  LarpOS 2.0
    bootloaderEntryName: LarpOS

images:
    productLogo:         "larpos.png"
    productIcon:         "larpos.png"
    productWelcome:      "larpos.png"

slideshow:               "slideshow.qml"
slideshowAPI:            2

style:
    sidebarBackground:   "#14090d"
    sidebarText:         "#e8dfe0"
    sidebarTextSelect:   "#ff5560"
EOF_BR

cat > /etc/calamares/branding/larpos/slideshow.qml <<'EOF_QML'
import QtQuick

Rectangle {
    id: root
    color: "#14090d"

    Image {
        id: logo
        source: "larpos.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        width: 180
        height: 180
        fillMode: Image.PreserveAspectFit
    }

    Text {
        anchors.centerIn: parent
        text: "Welcome to LarpOS"
        color: "#ff5560"
        font.pixelSize: 34
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        text: "Arch-based  -  Hyprland  -  Blood Moon"
        color: "#e8dfe0"
        font.pixelSize: 18
    }
}
EOF_QML

cp /usr/share/larpos/branding/logo_256.png /etc/calamares/branding/larpos/larpos.png

cat > /etc/calamares/modules/unpackfs.conf <<'EOF_UNP'
---
unpack:
    -   source: "/run/archiso/bootmnt/arch/x86_64/airootfs.sfs"
        sourcefs: "squashfs"
        destination: ""
EOF_UNP

cat > /etc/calamares/modules/users.conf <<'EOF_USR'
---
defaultGroups:
    - users
    - wheel
    - video
    - audio
    - storage
    - input
autologin: false
userShell: /bin/zsh
EOF_USR

cat > /etc/calamares/modules/displaymanager.conf <<'EOF_DM'
---
displaymanagers: []
basicSetup: false
sysconfigSetup: false
EOF_DM

cat > /etc/calamares/modules/partition.conf <<'EOF_PRT'
---
efiSystemPartition: "/boot/efi"
efiSystemPartitionSize: "512MiB"
EOF_PRT

cat > /etc/calamares/modules/bootloader.conf <<'EOF_BLD'
---
efiBootLoader: "grub"
kernel: "/boot/vmlinuz-linux"
img: "/boot/initramfs-linux.img"
fallback: "/boot/initramfs-linux-fallback.img"
timeout: "5"
kernelLine: "LarpOS Linux"
fallbackKernelLine: "LarpOS Linux (fallback)"
grubInstall: "grub-install"
grubMkconfig: "grub-mkconfig"
grubCfg: "/boot/grub/grub.cfg"
EOF_BLD

cat > /etc/calamares/modules/welcome.conf <<'EOF_WLC'
---
requirements:
    requiredStorage: 12
    requiredMemory: 2048
    internetCheckUrl: "https://archlinux.org"
EOF_WLC

# Remove CachyOS installer launcher so only ours shows in the menu
rm -f /usr/share/applications/calamares*.desktop 2>/dev/null

echo "customize_airootfs.sh run successfully"
exit 0
