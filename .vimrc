set encoding=utf-8
set fileencoding=utf-8

"	Based on VimConfig.com

" General
set updatetime=100
set number					" Show line numbers
set linebreak					" Break lines at word (requires Wrap lines)
set showbreak=+++				" Wrap-broken line prefix
set textwidth=110				" Line wrap (number of cols)
set colorcolumn=110
set showmatch					" Highlight matching brace
""set visualbell				" Use visual bell (no beeping)

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
set ruler					" Show row and column ruler information
set showtabline=2				" Show tab bar
""set autochdir					" Change working directory to open buffer
set undolevels=1000				" Number of undo levels
set backspace=indent,eol,start			" Backspace behaviour

" Programming
syntax on

" Shortcuts
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Show unprintable characters
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

highlight CarriageReturn ctermbg=red guibg=red
match CarriageReturn /\r\+$/

" Plugins

