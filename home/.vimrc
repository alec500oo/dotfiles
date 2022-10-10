" This is my vim config file
" Alec Matthews <me@alecmatthews.dev>

" Plugins {{{
" Auto-install vim-plug
let vim_plug_data_dir = '~/.vim'
if empty(glob(vim_plug_data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo ' . vim_plug_data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-plug'

" File type plugins
Plug 'cstrahan/vim-capnp'
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

" Search Settings
set incsearch hlsearch

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
set statusline+=%.24F	" File path
set statusline+=\ %y	" Deduced file type
set statusline+=%=	" Switch to right side
set statusline+=%v,\ %l/%L	" Ruler
"}}}

