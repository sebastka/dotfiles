#!/bin/sh

set -e

for f in `find . -type f -not -path "./.git/*" -not -path "./deploy.sh" -not -path "./.gitignore" | cut -c3-`; do
	rm ~/"$f"
	cp "$f" ~/"$f"
done

exit 0