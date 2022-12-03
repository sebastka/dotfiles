# dotfiles

## Set up

- Install:
  - Arch Linux: `pacman -S chezmoi`
  - Fedora: `dnf install https://github.com/twpayne/chezmoi/releases/download/v2.27.2/chezmoi-2.27.2-i686.rpm`
  - Debian: `curl -sL -o/tmp/chezmoi.deb https://github.com/twpayne/chezmoi/releases/download/v2.27.2/chezmoi_2.27.2_linux_amd64.deb && dpkg -i /tmp/chezmoi.deb`
  - FreeBSD: `pkg install chezmoi`
- Init: `chezmoi init sebastka`
- Apply: `chezmoi apply`

## Doc

- https://www.chezmoi.io/
- https://github.com/twpayne/chezmoi
- https://github.com/twpayne/dotfiles
- https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/
