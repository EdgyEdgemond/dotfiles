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

" strip trailing whitespace: <leader>$
nnoremap <silent> <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>

" window management
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" no arrow keys :/
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>


" colors, syntax, etc
set t_Co=256
set background=dark
colorscheme molokai
filetype plugin indent on
syntax on


" statusline
hi User1 ctermbg=DarkBlue ctermfg=None
hi User2 ctermbg=DarkBlue ctermfg=Cyan
hi User3 ctermbg=DarkBlue ctermfg=Yellow

set statusline=                                 " clear the statusline when vimrc is reloaded
set statusline+=%2*%-3.3n\                      " buffer number
set statusline+=%1*%f\                          " filepath
set statusline+=%h%m%r%w                        " flags
set statusline+=%{strlen(&fenc)?&fenc:&enc}\ \  " encoding
set statusline+=%2*%{&ff},%Y\ \                 " filetype, fileformat
set statusline+=%3*char=%b,0x%-8B\              " character
set statusline+=%=                              " right align
set statusline+=%2*%04l,%04v,%p%%\ %L           " offset


" filetypes
autocmd FileType HTML setlocal ts=2 sts=2 sw=2 et


" autocmd read+new
autocmd BufRead,BufNewFile $HOME/tmp/mutt-* set textwidth=72
autocmd BufRead,BufNewFile *.wiki set ft=Wikipedia
autocmd BufRead,BufNewFile .tmux.conf set ft=tmux
autocmd BufRead,BufNewFile /srv/django/templates/* set ft=htmldjango


" netrw
let g:netrw_liststyle=3  " tree-mode


" arpeggio plugin
call arpeggio#load()
Arpeggio inoremap jk <Esc>


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
