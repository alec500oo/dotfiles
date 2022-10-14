" This is my vim config file
" Alec Matthews <me@alecmatthews.dev>

" Only use lsp server from coc.nvim
let g:ale_disable_lsp = 1

" Plugins {{{
" Auto-install vim-plug
let vim_plug_data_dir = '~/.vim'
if empty(glob(vim_plug_data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo ' . vim_plug_data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

" File type plugins
Plug 'sheerun/vim-polyglot'
Plug 'cstrahan/vim-capnp'

" Linting Engine
Plug 'dense-analysis/ale'

" Compleation Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug '~/.vim/dracula-pro'

call plug#end()
" }}}

" Set Numbers
" TODO: only enable in programming modes
set number relativenumber numberwidth=3

" Editor Settings
filetype on
filetype indent on
syntax on
set showcmd
set updatetime=300

" Search Settings
set incsearch hlsearch

" coc.nvim {{{
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "\<TAB>" :
	\ coc#refresh()
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <c-@> coc#refresh()

" Navigate Diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-previous)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Navigate lint errors
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename
nmap <leader>rn <Plug>(coc-rename)
" }}}

" Backup, Swap, and Undo {{{
" Don't write backup file
set nobackup nowritebackup

if exists("*mkdir")
	set swapfile directory^=$HOME/.vim/swap//
	if !isdirectory(&directory)
		call mkdir(&directory, 'p', 0o700)
	endif
endif
" }}}

" Abbreviations {{{
iabbrev @@ me@alecmatthews.dev
iabbrev ccopy Copyright <c-R>=strftime("%Y")<cr> Alec Matthews, all rights reserved.
" }}}

" Key Mappings {{{
let mapleader = "\\"
let maplocalleader = "_"

" control
" Exit insert mode
inoremap jk <esc> 

" movement
nnoremap H 0
nnoremap L $

" Remove pesky arrow key mappings {{{
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" }}}

" Run through quickfix list
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprevious<cr>

" Highlight trailing whitespace
nnoremap <leader>w :match Error /\v\s+$/<cr>
nnoremap <leader>W :match none<cr>

" Very magic search all the time
nnoremap / /\v
nnoremap ? ?\v

" Clear search highlight
nnoremap <leader>ch :nohlsearch<cr>

" Move line up or down
noremap <leader>- ddp
noremap <leader>_ ddkP

" make words uppercase
nnoremap <c-u> viwU
inoremap <c-u> <esc>bviwUea

" surround (")
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l

" edit vimrc _fast_
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" open previous buffer to the right
nnoremap <leader>opb :execute 'rightbelow vsplit' bufname("#")<cr>
" }}}

" File Type Settings {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldlevelstart=0
	autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_capnp
	autocmd!
	autocmd FileType capnp setlocal autoindent tabstop=2 shiftwidth=2 expandtab
augroup END

augroup filetype_python
	autocmd!
	autocmd FileType python setlocal autoindent tabstop=4 shiftwidth=4 expandtab
augroup END

augroup filetype_json
	autocmd!
	autocmd FileType json setlocal autoindent tabstop=4 shiftwidth=4 expandtab
augroup END

augroup filetype_c
	autocmd FileType c setlocal nowrap
	autocmd FileType c nnoremap <localleader>c I//<esc>
augroup END

augroup filetype_html
	autocmd!
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

augroup filetype_markdown
	autocmd!
	autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^[-=]\\{2,\\}$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^[-=]\\{2,\\}$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}

" Status Line {{{
set laststatus=2	" Always show statusline
set statusline=%r	" Read-only
set statusline+=%m	" Modified
set statusline+=%.32F	" File path
set statusline+=\ %y	" Deduced file type
set statusline+=%=	" Switch to right side
set statusline+=%v,\ %l/%L	" Ruler
"}}}

" Editor Look {{{
" Remove color from empty space in SignColumn
highlight clear SignColumn

" Put signs in the same line as numbers
set signcolumn=number

" Set scheme to Dracula Pro (if it exists)
silent! colorscheme dracula_pro_van_helsing
" }}}

