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
Plug 'luochen1990/rainbow'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'SevereOverfl0w/vim-replant', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fireplace'
Plug 'clojure-vim/async-clj-omni'
Plug 'tpope/vim-surround'
Plug 'venantius/vim-cljfmt'
Plug 'snoe/clj-refactor.nvim'

call plug#end()

"plug setup
nnoremap <leader>pi :PlugInstall<CR>

let g:rainbow_active = 1
let g:rainbow_conf = {
\  'guifgs': ['#5e81ac', '#a3be8c', '#ebcb8b', '#bf616a', '#b48ead'],
\  'ctermfgs': ['12', '2', '3', '1', '5']
\}

" ncm2 autocomplete
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
let ncm2#complete_delay = 300
let g:ncm2#matcher = 'substrfuzzy'

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"linting
let g:ale_linters = {'clojure': ['clj-kondo'], 'javascript': ['eslint']}

set encoding=utf-8
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

"""Clojure Keyboard Shortcuts
nmap <Leader>msf <Plug>(sexp_capture_next_element)
nmap <Leader>msb <Plug>(sexp_capture_prev_element)
nmap <Leader>mbf <Plug>(sexp_emit_tail_element)
nmap <Leader>mbb <Plug>(sexp_emit_head_element)

nmap <Leader>mwi <Plug>(sexp_round_head_wrap_list)
nmap <Leader>mwI <Plug>(sexp_round_tail_wrap_list)
nmap <Leader>mw[ <Plug>(sexp_square_head_wrap_list)
nmap <Leader>mw] <Plug>(sexp_square_tail_wrap_list)
nmap <Leader>mw{ <Plug>(sexp_curly_head_wrap_list)
nmap <Leader>mw} <Plug>(sexp_curly_tail_wrap_list)
nmap <Leader>mWi <Plug>(sexp_round_head_wrap_element)
nmap <Leader>mWI <Plug>(sexp_round_tail_wrap_element)
nmap <Leader>mW[ <Plug>(sexp_square_head_wrap_element)
nmap <Leader>mW] <Plug>(sexp_square_tail_wrap_element)
nmap <Leader>mW{ <Plug>(sexp_curly_head_wrap_element)
nmap <Leader>mW} <Plug>(sexp_curly_tail_wrap_element)

nmap <Leader>mi <Plug>(sexp_insert_at_list_head)
nmap <Leader>ma <Plug>(sexp_insert_at_list_tail)

nmap <Leader>mrs <Plug>(sexp_splice_list)
nmap <Leader>mrf <Plug>(sexp_raise_list)
nmap <Leader>mre <Plug>(sexp_raise_element)

nmap <Leader>mfh <Plug>(sexp_swap_list_backward)
nmap <Leader>mfl <Plug>(sexp_swap_list_forward)
nmap <Leader>meh <Plug>(sexp_swap_element_backward)
nmap <Leader>mel <Plug>(sexp_swap_element_forward)

nmap <Leader>mlf :Require<CR>
nmap <Leader>mla :<C-U>call replant#ui#refresh()<CR>
nmap <Leader>mlaf :<C-U>call replant#ui#refresh_all()<CR>

nmap <Leader>mtb :Eval<Space>(clojure.test/run-tests)<CR>
nmap <Leader>mta :ReplantTestProject<CR>
" TODO
" ReplantApropos
" ReplantApropos but for the current buffer
" ReplantFindSymbol (Might need to sort out cider-nrepl and refactor-nrepl deps)
" clj-refactor
" vim-fireplace keybindings

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
