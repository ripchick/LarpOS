#!/usr/bin/env bash
# shellcheck disable=SC2034
#
# LarpOS — Blood Moon (Hyprland Edition)
# Arch-based live ISO. Built with archiso 91.

iso_name="larpos"
iso_label="LARPOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="LarpOS Project <https://github.com/larpos>"
iso_application="LarpOS Blood Moon Live/Installer DVD (Hyprland Edition)"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
# zstd 14 + 1M blocks (no xz-only options)
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '14' '-b' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/customize_airootfs.sh"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/larpos-apps"]="0:0:755"
  ["/usr/local/bin/larpos-install"]="0:0:755"
)
