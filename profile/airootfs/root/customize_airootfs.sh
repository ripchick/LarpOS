#!/bin/bash
#
# LarpOS airootfs customization.
# Runs via arch-chroot AFTER package installation, so it can safely
# overwrite files owned by packages (e.g. /usr/lib/os-release from
# the 'filesystem' package) without causing pacman file conflicts.

_osr=/usr/lib/os-release

# Preserve IMAGE_ID / IMAGE_VERSION lines injected earlier by mkarchiso
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

exit 0
