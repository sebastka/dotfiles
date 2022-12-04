#!/bin/sh

[ ! -d "$XDG_STATE_HOME/vim/bundle/Vundle.vim" ] || exit 0

mkdir -p "$XDG_STATE_HOME/vim/bundle"
git clone https://github.com/VundleVim/Vundle.vim.git "$XDG_STATE_HOME/vim/bundle/Vundle.vim"
vim +PluginInstall +qall
