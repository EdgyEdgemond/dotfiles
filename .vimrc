" -----------------------------------------------------------------------------
" vimrc
" Mel Boyce <mel@melboyce.com>
" -----------------------------------------------------------------------------

" https://github.com/tpope/vim-pathogen
call pathogen#infect()

set nocompatible
set hidden
set title
set shell=/bin/zsh
set autowrite
set confirm
set clipboard+=unnamed
set laststatus=2
set matchtime=5  " this is the default value
set number
set backspace=indent,eol,start
set nobackup
set history=1000
set ruler
set showcmd
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase  " ignore case on searches unless explicitly cased
set cmdheight=2
set backupskip+=/var/spool/cron/*
set fileformat=unix
set wildmode=longest,list
set wildmenu
set viminfo^=!
set encoding=utf-8
set nowrap
set sidescrolloff=15
set sidescroll=1
set cursorline
set showtabline=2  " always show the tabline
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set smarttab
set scrolloff=999
let mapleader=","
"let &colorcolumn=join(range(81,999),",")
set colorcolumn=81

" backups
set noswapfile
set nobackup
set nowb

" preserve undo
set undodir=~/.vim/backups
set undofile

" stop vim from clobbering the scrollback buffer
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=


" jump to last known cursor position
augroup vimrcEx
    autocmd!
    autocmd BufReadPost * if line("'\'") > 0 && line("'\'") <= line("$") | exe "normal g`\"" | endif
augroup END


" various keymaps
" clear search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" whitespace visibility: <leader>s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>
vmap <silent> <leader>c :s/^/#<cr>

nmap <silent> <leader>1 1gt<cr>
nmap <silent> <leader>2 2gt<cr>
nmap <silent> <leader>3 3gt<cr>
nmap <silent> <leader>4 4gt<cr>
nmap <silent> <leader>5 5gt<cr>
nmap <silent> <leader>6 6gt<cr>

" strip trailing whitespace: <leader>$
nnoremap <silent> <leader>$ :call Preserve("%s/\\s\\+$//e")<cr>

" window management
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" no arrow keys :/
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>

imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
imap <down> <nop>

vmap <left> <nop>
vmap <right> <nop>
vmap <up> <nop>
vmap <down> <nop>

:command WQ wq
:command Wq wq
:command W w
:command Q q

" colors, syntax, etc
set t_co=256
set background=dark
colorscheme jellybeans
filetype plugin indent on
syntax on


" statusline
hi user1 ctermbg=darkblue ctermfg=none
hi user2 ctermbg=darkblue ctermfg=cyan
hi user3 ctermbg=darkblue ctermfg=yellow

set statusline=                                 " clear the statusline when vimrc is reloaded
set statusline+=%2*%-3.3n\                      " buffer number
set statusline+=%1*%f\                          " filepath
set statusline+=%h%m%r%w                        " flags
set statusline+=%{strlen(&fenc)?&fenc:&enc}\ \  " encoding
set statusline+=%2*%{&ff},%y\ \                 " filetype, fileformat
set statusline+=%3*char=%b,0x%-8b\              " character
set statusline+=%=                              " right align
set statusline+=%2*%04l,%04v,%p%%\ %l           " offset


" filetypes
autocmd filetype html setlocal ts=2 sts=2 sw=2 et


" autocmd read+new
autocmd bufread,bufnewfile $home/tmp/mutt-* set textwidth=72
autocmd bufread,bufnewfile *.wiki set ft=wikipedia
autocmd bufread,bufnewfile .tmux.conf set ft=tmux
autocmd bufread,bufnewfile /srv/django/templates/* set ft=htmldjango


" netrw
let g:netrw_liststyle=3  " tree-mode

" django-tmux

let g:tmux_djangotest_manage_py="python manage.py"
let g:tmux_djangotest_test_cmd="test"
let g:tmux_djangotest_test_file_contains="TestCase"
let g:tmux_djangotest_file_prefix="source ../activate &&"
let g:tmux_djangotest_tmux_cmd="screen#ScreenShell"

"settings for screen-tmux
let g:ScreenImpl="Tmux"
let g:ScreenShellTmuxInitArgs="-2"
let g:ScreenShellQuitOnVimExit="1"
map <leader>q :ScreenQuit<cr>

"run test on Ctrl+b
noremap <C-b> :python run_django_test()<cr>

" arpeggio plugin
" call arpeggio#load()
" arpeggio inoremap jk <esc>


" functions
function! Preserve(command)
    " save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " execute the command
    execute a:command
    " restore previous search and position
    let @/=_s
    call cursor(l, c)
endfunction
