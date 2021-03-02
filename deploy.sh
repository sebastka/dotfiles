#!/bin/sh

set -e

for f in `find . -type f -not -path "./.git/*" -not -path "./deploy.sh" -not -path "./.gitignore" | cut -c3-`; do
	# Only remove existing files (so we don't delete ~/.config by accident)
	if [ -f ~/"$f" ]; then
		rm ~/"$f"
	fi

	# If dir exists in dotfiles but not in ~ => create it
	if [ -d ${f%/*} ] && [ ! -d ~/${f%/*} ]; then
		mkdir ~/${f%/*}
	fi

	cp "$f" ~/"$f"
done

exit 0