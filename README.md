# dotfiles

## Set up

- Get latest release version number: `cz_version="$(git ls-remote --refs --sort="version:refname" --tags https://github.com/twpayne/chezmoi.git | cut -d/ -f3 | sed -n '$p' | sed 's/^v//')"`
- Install:
  - Arch Linux: `pacman -S chezmoi`
  - Fedora: `dnf install "$(printf 'https://github.com/twpayne/chezmoi/releases/download/v%s/chezmoi-%s-i686.rpm' "$cz_version" "$cz_version")"`
  - Debian: `curl -sL -o/tmp/chezmoi.deb "$(printf 'https://github.com/twpayne/chezmoi/releases/download/v%s/chezmoi_%s_linux_amd64.deb' "$cz_version" "$cz_version")" && dpkg -i /tmp/chezmoi.deb`
  - FreeBSD: `pkg install chezmoi`
- Init: `chezmoi init sebastka`
- Apply: `chezmoi apply`

## Doc

- https://www.chezmoi.io/
- https://github.com/twpayne/chezmoi
- https://github.com/twpayne/dotfiles
- https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/
