#!/bin/sh

set -e

for f in `find . -type f -not -path "./.git/*" -not -path "./deploy.sh" -not -path "./.gitignore" | cut -c3-`; do
	# Only remove files (so we don't delete ~/.config by accident)
	[ -f ~/"$f" ] && rm ~/"$f"

	# If dir exists in dotfiles but not in ~ => create it
	[ -d ${f%/*} ] && [ ! -d ~/${f%/*} ] && mkdir ~/${f%/*}

	cp "$f" ~/"$f"
done

ln -s ~/.profile ~/.bash_profile

exit 0
