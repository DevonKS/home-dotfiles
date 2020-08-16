"Setting Space to be my leader
noremap <Space> <Nop>
let mapleader = "\<Space>"

"Configuring vim-plug
call plug#begin('~/.vim/plugged')

"themes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'

" ncm2 autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

"fzf
Plug 'junegunn/fzf.vim'

"git
Plug 'airblade/vim-gitgutter'

"Javascript tools
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'

"Clojure Tools
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-surround'
Plug 'venantius/vim-cljfmt'

call plug#end()

"plug setup
nnoremap <leader>pi :PlugInstall<CR>

" ncm2 autocomplete
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"linting
let g:ale_linters = {'clojure': ['clj-kondo'], 'javascript': ['eslint']}

set encoding=utf-8
set autochdir

inoremap jk <Esc>

nnoremap <leader>e :NERDTree<CR>
nnoremap <leader>o :edit<Space>

nnoremap <leader>go :Files 
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gm :GFiles?<CR>
nnoremap <leader>gs :Gag 
nnoremap <leader>ga :AgIn 
nnoremap <leader>gl :BLines<CR>
nnoremap <leader>gla :Lines<CR>
nnoremap <leader>gw :Windows<CR>
nnoremap <leader>gm :Marks<CR>
nnoremap <leader>ghf :History<CR>
nnoremap <leader>ghc :History:<CR>

nnoremap <leader>pp "+p<CR>
vnoremap <leader>yy "+y<CR>

"Buffer Management
nnoremap <leader>bk :bd<CR>
nnoremap <leader>bl :ls<CR>
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
nnoremap <leader>ce :edit<Space>~/.config/nvim/init.vim<CR>
nnoremap <leader>cr :source<Space>~/.config/nvim/init.vim<CR>

"js tools setup
" I need to disable this as it conflicts with ncm2
"let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
let g:jsx_ext_required = 0

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_use_global = 0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter = 0 
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

"Always show status bar
set laststatus=2
set number relativenumber

let g:airline_skip_empty_sections = 1

set wildmenu
set wildmode=list:longest,full

"fzf
" AgIn: Start ag in the specified directory
"
" e.g.
"   :AgIn .. foo
function! s:ag_in(bang, ...)
  if !isdirectory(a:1)
    throw 'not a valid directory: ' .. a:1
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': a:1}), a:bang)

  " If you don't want preview option, use this
  " call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1}, a:bang)
endfunction
command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)

function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! s:git_ag(bang, ...)
  let root = s:get_git_root()
  if empty(root)
    return s:warn('Not in git repo')
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000, ' '), fzf#vim#with_preview({'dir': root}), a:bang)

  " If you don't want preview option, use this
  " call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1}, a:bang)
endfunction
command! -bang -nargs=+ Gag call s:git_ag(<bang>0, <f-args>)

set t_Co=256
"colorscheme gruvbox
colorscheme nord
set guifont=FiraCode\ Nerd\ Font
set encoding=utf-8
set clipboard+=unnamedplus
