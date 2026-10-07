<div align="center">

<img src="docs/banner.png" alt="LarpOS — Blood Moon" width="800"/>

# 🌘 LarpOS — Blood Moon

**Arch-based live Linux · Hyprland Edition · graphical installer · built in CI**

![CI](https://github.com/larpos/LarpOS/actions/workflows/build.yml/badge.svg)
![License](https://img.shields.io/badge/license-GPL--3.0-blue)
![Arch](https://img.shields.io/badge/based%20on-Arch%20Linux-1793D1?logo=archlinux&logoColor=white)
![WM](https://img.shields.io/badge/desktop-Hyprland-e0342f)
![Installer](https://img.shields.io/badge/installer-Calamares-ff7a45)

</div>

---

> **Blood Moon** — живая Arch-система с тайловым Wayland-рабочим столом **Hyprland**,
> тёмно-красной темой, графическим установщиком **Calamares** и встроенным
> **центром приложений**. Загрузился с флешки — уже работаешь; понрáвилось —
> жмёшь «Install LarpOS».

## ⚡ Что внутри

| Компонент | Что это |
|---|---|
| 🪟 **Hyprland** | динамический тайловый композитор Wayland: анимации, blur, скругления, тени |
| 📊 **Waybar** | статус-бар с workspaces, сетью, звуком, батареей и треем |
| 🚀 **Wofi** | лаунчер приложений (`Super+D`) |
| 🖥 **Kitty** | терминал с палитрой Blood Moon (`Super+Enter`) |
| 💾 **Calamares** | графический установщик: разметка диска, юзер, GRUB — как у «больших» дистрибутивов |
| 📦 **App Center** | встроенный `larpos-apps`: браузеры, игры (Steam/Lutris), dev-инструменты — ставится в пару кликов |
| 🔔 **Dunst** | уведомления в стиле Blood Moon |
| 🖼 **5 обоев 4K** | сгенерированная Blood Moon коллекция (луна, арка, фазы, сетка) |
| ⚡ **fastfetch** | приветствие с фирменным лого в стиле Arch |

## 🚀 Быстрый старт

1. **Скачай ISO** со страницы [Releases](https://github.com/larpos/LarpOS/releases) (файл `*.iso` или части `*.part-*`).
   Если качал частями — склей:
   ```bash
   cat larpos-*.iso.part-* > larpos-*.iso
   ```
2. **Проверь контрольную сумму**:
   ```bash
   sha256sum -c SHA256SUMS
   ```
3. **Запиши на флешку** (от 8 ГБ):
   - **Rufus** (Windows): выбрать ISO → Start → **DD mode**;
   - **Ventoy** (Windows/Linux): просто закинуть ISO;
   - **Linux**: `dd if=larpos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync`
4. **Загрузись** с USB. В BIOS/UEFI выключи **Secure Boot**.
5. Система **сам залогинит** тебя как `liveuser` (Hyprland). Установка — значок **Install LarpOS** в меню (`Super+D`).

> 🔑 В живой сессии `liveuser` имеет **sudo без пароля**. Root-пароля нет.

## ⌨️ Горячие клавиши Hyprland

| Клавиши | Действие |
|---|---|
| `Super + Enter` | терминал (Kitty) |
| `Super + D` | лаунчер приложений (Wofi) |
| `Super + Q` | закрыть окно |
| `Super + M` | выйти из сессии |
| `Super + F` | полный экран |
| `Super + V` | плавающее окно (toggle) |
| `Super + [1..0]` | рабочие столы 1–10 |
| `Super + Shift + [1..0]` | переместить окно на стол |
| `Super + ЛКМ / ПКМ` | двигать / менять размер окна |
| `Alt + Shift` | переключить раскладку **us ⇄ ru** |
| `Print` / `Shift + Print` | скриншот области / всего экрана |
| `XF86Audio / Brightness` | звук и яркость работают из коробки |

## 📦 Центр приложений

```bash
larpos-apps
```
или значок **LarpOS App Center** в лаунчере. Категории: браузеры, мессенджеры,
разработка (`code`, `neovim`), графика (Krita, Blender), игры (Steam, Lutris,
gamemode, mangohud), офис, системные утилиты. Мульти-выбор по `TAB`, установка
одним `Enter` через `pacman`. Там же — раздел **About project**.

## 🖼 Обои

<details open>
<summary>Галерея (в комплекте ISO, <code>/usr/share/backgrounds/larpos/</code>)</summary>

| | |
|---|---|
| ![bloodmoon-arch](profile/airootfs/usr/share/backgrounds/larpos/bloodmoon-arch.png) | ![crimson-veil](profile/airootfs/usr/share/backgrounds/larpos/crimson-veil.png) |
| *bloodmoon-arch* — обои по умолчанию | *crimson-veil* |
| ![moon-gate](profile/airootfs/usr/share/backgrounds/larpos/moon-gate.png) | ![moon-phases](profile/airootfs/usr/share/backgrounds/larpos/moon-phases.png) |
| *moon-gate* | *moon-phases* |

</details>

## 🛠 Сборка из исходников

Нужен любой Linux с Docker:

```bash
docker run --rm --privileged -v "$PWD:/build" archlinux:base-devel \
    bash -e -c 'pacman -Syu --noconfirm archiso && mkarchiso -v -w /work -o /out /build/profile'
```

Или просто запушь тег `v*` — [GitHub Actions](.github/workflows/build.yml)
соберёт ISO и опубликует Release автоматически (ISO > 1900 MiB автоматически
делится на части и сопровождается `SHA256SUMS`).

## 📁 Структура репозитория

```
LarpOS/
├── .github/workflows/build.yml   # CI: сборка ISO + публикация Release
├── docs/                         # баннер для README
└── profile/                      # archiso-профиль (mkarchiso 91)
    ├── profiledef.sh             # параметры образа (zstd-14, bios+uefi)
    ├── packages.x86_64           # список пакетов
    ├── pacman.conf               # с включённым [multilib]
    ├── airootfs/                 # оверлей живой системы
    │   ├── etc/greetd/           # автологин в Hyprland
    │   ├── etc/calamares/        # установщик: модули + брендинг
    │   ├── etc/skel/.config/     # hyprland, waybar, wofi, dunst, kitty…
    │   ├── root/customize_airootfs.sh
    │   └── usr/share/{backgrounds,larpos}/
    ├── syslinux/  ·  grub/  ·  efiboot/   # загрузчики (Blood Moon тема)
```

## ❓ FAQ

<details>
<summary><b>Загрузился — чёрный экран/консоль, что делать?</b></summary>

Проверь настройки VM/BIOS: для VirtualBox — EFI включён, видеопамять 128 МБ,
контроллер VMSVGA. На железе — Secure Boot выключен. Запасной вход: `Ctrl+Alt+F2`
(автологин liveuser в консоль), рабочий стол руками: `startplasma…` нет — команда
`Hyprland` (или `sudo systemctl start greetd`).
</details>

<details>
<summary><b>Steam не ставится из App Center?</b></summary>

В ISO включён репозиторий `[multilib]` — Steam ставится из живой сессии и в
установленной системе. Если не ставится — обнови базы: `sudo pacman -Sy`.
</details>

<details>
<summary><b>После установки просит логин — это норма?</b></summary>

Да. В живой сессии автологин `liveuser`; в установленной системе Calamares
отключает автологин и показывает greetd. Создай своего пользователя в установщике.
</details>

## 🙏 Благодарности

- [Arch Linux](https://archlinux.org) — база и [archiso](https://gitlab.archlinux.org/archlinux/archiso);
- [Hyprland](https://hyprland.org), [Waybar](https://github.com/Alexays/Waybar), [Calamares](https://calamares.io) — рабочий стол и установщик;
- Сообщество Arch Wiki — бесценный источник знаний.

*LarpOS — фанатский проект. Не аффилирован с Arch Linux и не одобрен им.*
Лицензия — [GPL-3.0](LICENSE). Подробности в [ATTRIBUTION.md](ATTRIBUTION.md).
