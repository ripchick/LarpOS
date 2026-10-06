#!/bin/bash
#
# LarpOS airootfs customization.

_osr=/usr/lib/os-release

_img="$(grep -h '^IMAGE_ID=' "${_osr}" 2>/dev/null)"
_imgv="$(grep -h '^IMAGE_VERSION=' "${_osr}" 2>/dev/null)"

version="$(date -u +%Y.%m)"

cat > "${_osr}" <<OSR
NAME="LarpOS"
PRETTY_NAME="LarpOS (Arch Linux based)"
ID=larpos
ID_LIKE=arch
BUILD_ID=rolling
VERSION=${version}
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

# Service wiring: recreate ALL symlinks natively at build time.
# Windows checkouts (core.symlinks=false) mangle repo symlinks into plain
# text files, which systemd loads as empty no-op units.
ln -sfn /usr/lib/systemd/system/sddm.service /etc/systemd/system/display-manager.service
ln -sfn /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
ln -sfn /usr/lib/systemd/system/NetworkManager.service /etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -sfn /etc/systemd/system/choose-mirror.service /etc/systemd/system/multi-user.target.wants/choose-mirror.service
ln -sfn /usr/lib/systemd/system/systemd-timesyncd.service /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service

rm -f /etc/os-release
ln -s /usr/lib/os-release /etc/os-release

if [ -f /usr/lib/systemd/system/vboxservice.service ]; then
    ln -sfn /usr/lib/systemd/system/vboxservice.service /etc/systemd/system/multi-user.target.wants/vboxservice.service
fi

echo "customize_airootfs.sh run successfully"
exit 0
