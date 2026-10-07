# Attribution / Авторство

## English

LarpOS is a hobby operating system for x86_64, built as an independent
visual and functional rework of the **IgorOS** codebase.

- Original project: **IgorOS** by **Igoreeek228** —
  https://github.com/Igoreeek228/igorOS
- License of the original: **GNU GPL-3.0**
- LarpOS license: **GNU GPL-3.0** (see `LICENSE`)

GPL-3.0 explicitly permits modification and redistribution of the code, as
long as the derived work stays GPL-3.0 and credits the original authors.
That is exactly what this file does. Forking free software is not
"stealing" — it is how free software is designed to work (the same way
Ubuntu relates to Debian, or SteamOS relates to Arch Linux).

### What LarpOS adds on top of the base

- New "Terminal Dark" visual identity: phosphor-green theme, procedurally
  generated wallpapers, neon theater-mask logo and boot splash, full icon
  set redrawn in a unified line-art style, square LED window controls.
- Four new applications: **Paint**, **Snake**, **Clock** (analog + digital,
  real CMOS RTC), **System Monitor** (uptime, FPS, frame-time oscilloscope).
- Start menu turned into a full application launcher (12 entries).
- New `larp_gfx` integer line/circle/ring primitives; fast region blit for
  the Paint canvas.
- Terminal (`larpsh`): real `date` (CMOS RTC) and `sysinfo` (PIT uptime)
  commands, phosphor output palette.
- Panic screen, boot splash and shutdown screen restyled and rebranded.
- Fixed the shipped Makefile (recipes were indented with spaces and GNU
  make refused to build; now proper tabs) — plus a GitHub Actions workflow
  that builds ISO/IMG automatically and boot-tests it in QEMU.
- Removed dead/zombie sources that were not part of the build.

### What stays from the base (with thanks)

- Limine boot protocol integration, kernel entry, IDT/PIT/serial bring-up.
- PS/2 keyboard/mouse drivers, ATA, FAT32, AC97/HDA audio drivers.
- The doomgeneric engine port (third-party, GPL; DOOM.WAD is shareware).

---

## Русский

LarpOS — хобби-операционная система для x86_64, самостоятельная визуальная
и функциональная переработка кодовой базы **IgorOS**.

- Оригинальный проект: **IgorOS** автора **Igoreeek228** —
  https://github.com/Igoreeek228/igorOS
- Лицензия оригинала: **GNU GPL-3.0**
- Лицензия LarpOS: **GNU GPL-3.0** (см. `LICENSE`)

GPL-3.0 прямо разрешает изменять и распространять код при условии, что
производная работа остаётся под GPL-3.0 и указывает авторов оригинала —
именно для этого существует этот файл. Форкать свободный софт — не «воровать»:
так свободный софт и устроен (так же соотносятся Ubuntu и Debian,
SteamOS и Arch Linux).

### Что добавлено в LarpOS

- Новая визуальная айдентика «Terminal Dark»: фосфорно-зелёная тема,
  процедурные обои, неоновая театральная маска на загрузке, полный набор
  иконок в едином линейном стиле, квадратные LED-кнопки окон.
- Четыре новых приложения: **Paint**, **Snake**, **Часы** (стрелочные +
  цифровые, настоящий CMOS RTC), **Системный монитор** (uptime, FPS,
  осциллограф времени кадра).
- Стартовое меню стало полноценным лаунчером (12 пунктов).
- Новые целочисленные примитивы `larp_gfx` (линия/круг/кольцо) и быстрый
  blit для холста Paint.
- Терминал (`larpsh`): реальные команды `date` (CMOS RTC) и `sysinfo`
  (uptime по PIT), фосфорная палитра вывода.
- Экраны паники, загрузки и выключения переработаны и переименованы.
- Исправлен Makefile из оригинала (рецепты были отбиты пробелами и GNU make
  отказывался собирать; теперь табы) + GitHub Actions, который собирает
  ISO/IMG автоматически и проверяет загрузку в QEMU.
- Удалены мёртвые исходники, не участвовавшие в сборке.

### Что сохранено из базы (с благодарностью)

- Интеграция с загрузчиком Limine, вход в ядро, IDT/PIT/serial.
- Драйверы PS/2 клавиатуры и мыши, ATA, FAT32, звук AC97/HDA.
- Порт движка doomgeneric (сторонний, GPL; DOOM.WAD — shareware).
