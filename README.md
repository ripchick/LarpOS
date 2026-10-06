# 🌑 LarpOS — Blood Moon Edition (Arch Linux based)

**[Русский](#-larpos-на-русском) | [English](#-larpos-english)**

---

## 🌑 LarpOS (на русском)

**LarpOS Linux Edition** — независимый дистрибутив на базе **Arch Linux** с тематическим
оформлением **Blood Moon**: угольно-чёрный рабочий стол KDE Plasma, кровавая луна над
ночным городом, красные акценты во всей системе и фирменная цифровая маска в духе fsociety
из сериала Mr. Robot.

Это полноценный Arch: `pacman`, AUR, rolling-release, огромное репо — плюс готовый
внешний вид, автологин и предустановленный софт.

### ✨ Что внутри

| Категория | Состав |
|---|---|
| База | Arch Linux (rolling), ядро `linux`, KDE Plasma 6 (Wayland), SDDM + автологин |
| Тема | Цветовая схема Blood Moon, обои 4K (3 варианта), тема GRUB, заставка syslinux, ASCII-маска в fastfetch |
| Интернет | Firefox, NetworkManager (+ nm-applet в трее) |
| Мультимедиа | VLC, OBS Studio, GIMP, Inkscape |
| Офис | LibreOffice (Fresh), Okular-альтернатива Kate/Plasma |
| Разработка | git, vim, nano, python + pip, gcc/make (base-devel), gdb, docker + docker-compose, htop, btop |
| Утилиты | KDE-стандарт (Dolphin, Konsole, Ark, Gwenview, KCalc, Spectacle), 7zip, fastfetch (`larp-info`), gparted |
| Установка | `archinstall` (TUI), arch-install-scripts, reflector |

Полный список — [`profile/packages.x86_64`](profile/packages.x86_64).

### 🚀 Как собрать ISO

Тебе не нужен мощный ПК — ISO собирает **GitHub Actions** (см. [`build.yml`](.github/workflows/build.yml)):

1. Форкни/запушь этот репозиторий на GitHub
2. Actions → **Build LarpOS ISO** → запустится на каждом пуше
3. Готовый ISO появится в артефактах сборки; на теге — в **Releases**:
   ```bash
   git tag v1.0 && git push origin v1.0
   ```

Собрать локально (на любом Arch/дистрибутиве с Docker):

```bash
docker run --rm --privileged -v "$PWD:/build" archlinux:base-devel \
  bash -e -c 'pacman -Syu --noconfirm archiso && mkarchiso -v -w /tmp/larpos-work -o /build/out /build/profile'
```

На самой Arch Linux: `sudo pacman -S archiso && sudo mkarchiso -v -w /tmp/lw -o out profile/`

### 💾 Как записать и запустить

- **Rufus** (Windows): схема GPT, целевая UEFI (non-CSM), режим **DD**
- **Ventoy** — просто кинь ISO на флешку
- Linux/macOS: `sudo dd if=larpos-*.iso of=/dev/sdX bs=4M status=progress`
- **QEMU-тест**: `qemu-system-x86_64 -enable-kvm -m 4096 -cdrom larpos-*.iso -cpu host`
- Система грузится в Plasma под пользователем `liveuser` (пароль не нужен, `sudo` свободный)
- Установка на диск: терминал → `sudo archinstall`

> ⚠️ Нужен 64-битный CPU (любой Core i3/i5/i7, AMD64). На 32-битных CPU будет
> `PANIC: This CPU does not support 64-bit mode` — это ограничение Arch, а не баг.

### 🎨 Кастомизация

| Что поменять | Файл |
|---|---|
| Пакеты | `profile/packages.x86_64` |
| Цвета системы | `profile/airootfs/usr/share/color-schemes/BloodMoon.colors` |
| Обои | `profile/airootfs/usr/share/wallpapers/larpos-bloodmoon/` |
| Тема GRUB | `profile/airootfs/boot/grub/themes/larpblood/` |
| Меню BIOS-загрузки | `profile/syslinux/` (+ `splash.png`) |
| ASCII-маска в терминале | `profile/airootfs/usr/share/larpos/mask_ascii.txt` |
| Имя системы | `profile/airootfs/usr/lib/os-release`, `profile/profiledef.sh` |

### 📄 Правовая информация

- Код профиля — GPL-3.0. Графика — CC0-1.0.
- Основано на инструментарии [archiso](https://gitlab.archlinux.org/archlinux/archiso) (GPL).
- LarpOS **не связан** с Arch Linux и не одобрен им. Arch Linux — товарный знак
  [Levente Polyak / Arch Linux Foundation](https://archlinux.org/trademarks/).
- Маска — оригинальная цифровая графика «по мотивам» эстетики fsociety (Mr. Robot, © Universal).
  Не является копией официального арта; проект не связан с Universal/USA Network.

---

## 🌑 LarpOS (English)

**LarpOS Linux Edition** is an independent **Arch Linux-based** distribution with the
**Blood Moon** theme: charcoal-black KDE Plasma desktop, a blood moon over a night city,
red accents across the system and an original fsociety-inspired digital mask.

It is a full Arch system: `pacman`, AUR, rolling release — plus a ready-made look,
autologin and a curated software set (Firefox, LibreOffice, GIMP, Inkscape, OBS, VLC,
docker, full dev toolchain).

### Build

CI builds the ISO on every push (see `.github/workflows/build.yml`); tagging `v*`
publishes a GitHub Release with the ISO. Local build:

```bash
docker run --rm --privileged -v "$PWD:/build" archlinux:base-devel \
  bash -e -c 'pacman -Syu --noconfirm archiso && mkarchiso -v -w /tmp/larpos-work -o /build/out /build/profile'
```

### Run

Write the ISO to USB (Rufus DD mode / Ventoy / `dd`), boot, auto-login as `liveuser`,
install with `sudo archinstall`. Requires a 64-bit CPU.

### Legal

Profile code: GPL-3.0. Artwork: CC0-1.0. Based on archiso (GPL).
Not affiliated with or endorsed by Arch Linux. The mask is original fan-style artwork —
not affiliated with Universal / USA Network (Mr. Robot).

See [ATTRIBUTION.md](ATTRIBUTION.md) for full credits.
