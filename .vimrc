set nocompatible				" No need for backward compatibility
set encoding=utf-8
set fileencoding=utf-8

"	Based on VimConfig.com

" General
set updatetime=100
set number					" Show line numbers
set linebreak					" Break lines at word (requires Wrap lines)
""set showbreak=+++				" Wrap-broken line prefix
set textwidth=110				" Line wrap (number of cols)
set colorcolumn=110
set showmatch					" Highlight matching brace
set visualbell					" Use visual bell (no beeping)
set t_vb=					" Set effect of visual bell to nothing

set hlsearch					" Highlight all search results
set smartcase					" Enable smart-case search
set ignorecase					" Always case-insensitive
set incsearch					" Searches for strings incrementally

set autoindent					" Auto-indent new lines
set cindent					" Use 'C' style program indenting
""set smartindent				" Enable smart-indent
set smarttab					" Enable smart-tabs
set shiftwidth=8
set tabstop=8
set noexpandtab
set softtabstop=8				" Number of spaces per Tab

" Allow per-directory .vimrc
set exrc
set secure

" Advanced
""set ruler					" Show row and column ruler information
set showtabline=2				" Show tab bar
""set autochdir					" Change working directory to open buffer
set undolevels=1000				" Number of undo levels
set backspace=indent,eol,start			" Backspace behaviour
set termguicolors

" Programming
syntax on

" Plugin manager: VimPlug
" Install plugin manager: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Install new plugins with :PlugInstall
call plug#begin('~/.vim/plugged/')
Plug 'morhetz/gruvbox'
call plug#end()

" Plugin conf

" Theme
colorscheme gruvbox

" Show unprintable characters
highlight ExtraWhitespace ctermbg=red guibg=red
highlight CarriageReturn ctermbg=red guibg=red

call matchadd('ExtraWhitespace', '\s\+$')
call matchadd('CarriageReturn', '\r\+$/')

" Bindings

"Tabs
nnoremap	t<Right>	:tabnext<CR>
nnoremap	t<Left>		:tabprev<CR>
nnoremap	tn		:tabnew<Space>

