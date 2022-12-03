# dotfiles

## 1. Install `chezmoi`

- Arch Linux: `pacman -S chezmoi`
- Fedora: `dnf install https://github.com/twpayne/chezmoi/releases/download/v2.27.2/chezmoi-2.27.2-i686.rpm`
- Debian: `curl -sL -o/var/cache/apt/archives/chezmoi_2.27.2_linux_amd64.deb https://github.com/twpayne/chezmoi/releases/download/v2.27.2/chezmoi_2.27.2_linux_amd64.deb && dpkg -i /var/cache/apt/archives/chezmoi_2.27.2_linux_amd64.deb`
- FreeBSD: `pkg install chezmoi`

## 2. Init

`chezmoi init sebastka`

## 3. Apply

`chezmoi apply`
