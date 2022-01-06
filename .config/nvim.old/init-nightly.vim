"Setting Space to be my leader
noremap <Space> <Nop>
let mapleader = "\<Space>"

"Configuring vim-plug
call plug#begin('~/.vim-new/plugged')

" Themes
"Plug 'joshdick/onedark.vim'

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

"plug setup
nnoremap <leader>pi :PlugInstall<CR>

inoremap jk <Esc>

nnoremap <leader>o :edit<Space>

nnoremap <leader>pp "+p<CR>
vnoremap <leader>yy "+y<CR>

"Buffer Management
nnoremap <leader>bk :bd<CR>
nnoremap <leader>bb :ls<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bs :Buffers<CR>
nnoremap <leader>fs :w<CR>

nnoremap <leader>vb :vsp<Space><bar><Space>b
nnoremap <leader>hb :sp<Space><bar><Space>b

"Window Management
nnoremap <leader>sv :vsp<Space>
nnoremap <leader>sh :sp<Space>
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wc :close<CR>
nnoremap <leader>wm :only<CR>

"vimrc management
nnoremap <leader>ce :edit<Space>~/.config/nvim/init-nightly.vim<CR>
nnoremap <leader>cr :source<Space>~/.config/nvim/init-nightly.vim<CR>

"Always show status bar
set laststatus=2
set number relativenumber

set wildmenu
set wildmode=list:longest,full

set guifont=FiraCode\ Nerd\ Font
set encoding=utf-8
set clipboard+=unnamedplus

" Theme
set termguicolors
"syntax on
"colorscheme onedark

