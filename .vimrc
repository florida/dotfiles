set shell=/bin/bash                 " use bash

set nocompatible                    " be iMproved, required
filetype off                        " required
set rtp+=~/.vim/bundle/Vundle.vim
let g:ruby_path=$RUBY_BUILD

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-cucumber', {'rtp': 'vim/'}
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'pangloss/vim-javascript'
Bundle 'Valloric/YouCompleteMe'
Bundle 'git://git.wincent.com/command-t.git'
Plugin 'bling/vim-airline'
Bundle 'chriskempson/base16-vim'
Bundle 'dkprice/vim-easygrep'
Bundle 'derekwyatt/vim-scala'
Bundle 'kana/vim-textobj-user'
Bundle 'vim-scripts/matchit.zip'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-endwise'
Bundle 'raimondi/delimitmate'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'groenewege/vim-less'
Bundle 'rizzatti/dash.vim'
Bundle 'burnettk/vim-angular'
Bundle 'ap/vim-css-color'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'scrooloose/nerdcommenter'
Bundle 'briancollins/vim-jst'
call vundle#end()                   " required
filetype plugin indent on           " required

runtime /Users/florida/Dropbox/Development/dotfiles/vim/bundle/matchit.zip/plugin/matchit.vim

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>


if has("gui_running")
  set t_Co=256 " 256 color mode
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Input:h12
  endif
endif

syntax enable

" set options
set number
set splitbelow
set splitright
set vb
set modifiable
set laststatus=2
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set tabstop=2
set shiftwidth=2
set expandtab
set linespace=4
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256 " 256 color mode
set background=dark
set hidden
set incsearch
set showmatch
set nobackup
set nowritebackup
set noswapfile


autocmd BufWritePre * :%s/\s\+$//e
colorscheme base16-ocean

let g:ragtag_global_maps = 1

" Airline/Powerline Config
let g:Powerline_symbols = 'unicode'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" You complete me python interpreter
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Nerdtree Config
let g:NERDTreeChDirMode=2" in .vimr

let mapleader = ","

" EasyGrep Config
let g:EasyGrepCommand=1
let g:EasyGrepRecursive=1
let g:EasyGrepFilesToExclude="*.log,tmp/*,coverage/*,*.swp,*.swo,.git/*"
let g:CommandTWildIgnore= "node_modules/**"
let delimitMate_expand_space = 1
au FileType tcl let b:delimitMate_expand_space = 1

" Keybindings
map <C-n> :NERDTreeToggle<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nmap ,n :NERDTreeFind<CR>

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <F2> :bp <BAR> bd #<CR>
nmap <F3> :bprevious<CR>
nmap <F4> :bnext<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
nmap <silent> <leader>o :Dash<CR>

" Normal mode
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Resizing splits

" Moving lines
nnoremap <D-J> :m .+1<CR>==
nnoremap <D-K> :m .-2<CR>==

" Insert mode
inoremap <D-J> <ESC>:m .+1<CR>==gi
inoremap <D-K> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <D-J> :m '>+1<CR>gv=gv
vnoremap <D-K> :m '<-2<CR>gv=gv

nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP