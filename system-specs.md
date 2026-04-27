# System Specifications - DustinNix

## Overview
- **Hostname**: DustinNix
- **NixOS Version**: 25.11
- **Flake Configuration**: Managed via Nix Flakes
- **User**: omniladder
- **Timezone**: America/New_York

## Hardware Configuration
- **Platform**: x86_64-linux
- **CPU**: Intel (with KVM support)
- **Boot Modules**: xhci_pci, nvme, usbhid, usb_storage, sd_mod
- **Filesystem**: ext4
- **Boot Loader**: GRUB with EFI support, OS Prober enabled
- **Bluetooth**: Enabled (powers on at boot)

## Display & Session Management
- **Display Manager**: SDDM
  - Theme: Catppuccin Mocha Mauve
  - Package: KDE Packages SDDM
- **Window Manager**: Niri (scrollable-tiling Wayland compositor)
- **Fallback WM**: Sway (configured but Niri is primary)
- **X Server**: Enabled (for SDDM)

## Desktop Environment & Tools

### Wayland Tools
- **Wallpaper Daemon**: swww
- **Widget System**: eww (auto-starts with graphical session)
- **Notifications**: Mako
- **Application Launcher**: Rofi
- **Screen Locker**: Swaylock
- **Idle Manager**: Swayidle
- **Clipboard**: wl-clipboard

### Terminal & Shell
- **Terminal Emulators**:
  - Alacritty (primary)
  - Wezterm
- **Shell**: Zsh
  - Theme: Powerlevel10k
  - Plugins: zsh-autopair, syntax highlighting, autosuggestions
  - Auto-starts tmux (session: main)
  - Tools: zoxide, fzf
- **Multiplexer**: tmux
- **Man Pager**: Neovim

## Themes & Styling

### Color Scheme
- **Theme**: Catppuccin Mocha (system-wide)

### GTK
- **GTK Theme**: Catppuccin Mocha Blue Standard
- **Icon Theme**: Papirus-Dark
- **Cursor Theme**: Catppuccin Mocha Dark (24px)
- **Dark Mode**: Enabled for GTK3/4

### Qt
- **Platform Theme**: qtct (Qt6)
- **Kvantum**: Catppuccin Mocha Blue

### Fonts
- **Terminal Font**: JetBrains Mono Nerd Font
- **Icon Font**: Font Awesome
- **SDDM Font**: Noto Sans

## Development Environment

### Editors & IDEs
- **Primary Editor**: Neovim (custom config from github:Omniladder/nvim-config)
- **Code Editors**:
  - VS Code
  - Claude Code
  - Cursor

### Version Control
- **Git**: Configured
  - User: Omniladder
  - Email: dustintobrien@gmail.com

### Programming Languages & Tools

#### Languages
- **C/C++**: gcc
- **Rust**: cargo
- **Go**: go
- **Python**: python3
- **JavaScript/Node**: nodejs

#### Development Tools
- **File Manager**: Yazi
- **Network Tools**: nmap, tcpdump
- **Utilities**: unzip

## Applications

### Web Browsers
- Firefox (primary)
- Chromium
- Brave
- LibreWolf
- Qutebrowser
- Vivaldi

### Communication
- Discord
- Vesktop (alternative Discord client)

### Media & Entertainment
- **Music Player**: spotify-player
- **Screen Recording**: OBS Studio
- **Bluetooth Manager**: bluetuith

### Productivity
- **LaTeX**: texliveFull
- **Network Performance**: speedtest-cli
- **System Info**: fastfetch

## System Services & Features

### Network
- **Network Manager**: Enabled
- **VPN**: Tailscale (enabled)
- **Time Sync**: timesyncd (enabled)

### Input Configuration
- **Keyboard Daemon**: keyd
  - Capslock remapped to: Up

### System Settings
- **Wayland Support**: NIXOS_OZONE_WL=1 (for Electron apps)
- **Unfree Packages**: Allowed
- **Home Manager**: Enabled with backup extension (.hm-bak)

### Systemd Services
- swww-daemon (wallpaper)
- eww-daemon (widgets)
- eww-widgets (auto-opens windowOne)

## Quick Access Aliases
- `switch`: Rebuild and switch NixOS configuration
- `packages`: Edit packages.nix
- `flakes`: Edit flake configuration

## Configuration Locations
- **Niri Config**: ~/.config/niri
- **Eww Config**: ~/.config/eww
- **Alacritty Config**: ~/.config/alacritty
- **Rofi Config**: ~/.config/rofi
- **Kvantum Config**: ~/.config/Kvantum
- **Mako Config**: ~/.config/mako
- **Swaylock Config**: ~/.config/swaylock
- **Wallpapers**: ~/.config/wallpapers
- **Powerlevel10k**: ~/.p10k.zsh

## Repository Structure
```
flakes/
├── flake.nix (main flake configuration)
├── CatP/
│   ├── hosts/
│   │   ├── DustinNix/ (laptop configuration)
│   │   └── Desktop/ (desktop configuration)
│   ├── home/omniladder/ (user-specific home-manager config)
│   ├── modules/ (modular system configuration)
│   │   ├── desktop/ (WM, notifications, etc.)
│   │   ├── dev/ (development tools)
│   │   ├── languages/ (programming language setups)
│   │   ├── themes/ (GTK, Qt theming)
│   │   ├── browser/ (web browsers)
│   │   ├── system/ (bootloader, display manager)
│   │   └── network/ (networking)
│   └── profiles/ (preset configurations)
```
