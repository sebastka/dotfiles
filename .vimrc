" Section: Colors
set background=dark		" use darkmode
syntax enable			" enable syntax processing

" Section: Spaces and Tabs
set autoindent			" automatic indent
set cindent			" Use 'C' style program indenting
set tabstop=8			" number of visual spaces per TAB
set shiftwidth=8		" the size of an indent
set softtabstop=8		" number of spaces in tab when editing
"set smarttab			" Enable smart-tabs
"set smartindent		" Enable smart-indent
"set expandtab			" tabs are spaces
set noexpandtab

" Section: Window
set hidden			" hides buffers instead of closing them
set ttyfast			" faster rendering
set nocompatible		" No need for backward compatibility

" Section: UI Config
set updatetime=750
set encoding=utf-8		" Set UTF-* as default encoding
set fileencoding=utf-8
"set colorcolumn=110		" Line delimiter
"set textwidth=110		" Line wrap (number of cols)
set ruler			" Show row and column ruler information
set number			" show line numbers
"set relativenumber		" show relative numbers
set laststatus=2		" show statusline
set visualbell			" Use visual bell (no beeping)
set t_vb=			" Set effect of visual bell to nothing
set showcmd			" show command in bottom bar
set cmdheight=1			" height at the bottom
set undolevels=1000		" Number of undo levels
set showmatch			" Highlight matching brace
set showtabline=2		" Show tab bar
filetype indent on		" load filetype-specific indent files

" remove delay visual mode
set timeoutlen=1000 ttimeoutlen=0

"" natural split opening
set splitbelow
set splitright

" Section: Leader
let mapleader="	"		" leader is space

" Allow per-directory .vimrc
set exrc
set secure

" Section: Searching
set incsearch			" search as characters are enterd
set hlsearch			" highlight matches
set smartcase			" Enable smart-case search
set ignorecase			" Always case-insensitive

"" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Sectiozan: Mappings
"" paste toggle
set pastetoggle=<F2>

"" yank to clipboard
nnoremap <leader>y :%y+<CR>

" Plugin manager: VimPlug
" Install plugin manager: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Install new plugins with :PlugInstall
call plug#begin('~/.vim/plugged/')
Plug 'morhetz/gruvbox'
call plug#end()

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
