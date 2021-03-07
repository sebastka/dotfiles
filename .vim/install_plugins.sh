#!/bin/sh

#
#	vim-gitgutter
#

rm -rf ~/.vim/pack/airblade/start/vim-gitgutter/
mkdir -p ~/.vim/pack/airblade/start
cd ~/.vim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git
vim -u NONE -c "helptags vim-gitgutter/doc" -c q

exit 0

