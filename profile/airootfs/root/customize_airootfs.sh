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

echo "customize_airootfs.sh run successfully"
exit 0
