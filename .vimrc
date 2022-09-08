" Plugin Manager
if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif

call plug#begin("~/.vim/plugins")

Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'udalov/kotlin-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set nocompatible
set hidden
set title
set shell=/bin/zsh
set autowrite
set confirm
set clipboard=unnamedplus
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
set colorcolumn=121
set lazyredraw  " dont redraw when executing macros

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

if &l:modifiable | setlocal fileformat=unix | endif
" jump to last known cursor position
augroup vimrcEx
    autocmd!
    autocmd BufReadPost * if line("'\'") > 0 && line("'\'") <= line("$") | exe "normal g`\"" | endif
augroup END


" various keymaps
" clear search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
" disable ex mode
:nnoremap Q <nop>

" whitespace visibility: <leader>s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <leader>1 1gt<cr>
nmap <silent> <leader>2 2gt<cr>
nmap <silent> <leader>3 3gt<cr>
nmap <silent> <leader>4 4gt<cr>
nmap <silent> <leader>5 5gt<cr>
nmap <silent> <leader>6 6gt<cr>

" strip trailing whitespace: <leader>$
nnoremap <silent> <leader>$ :call Preserve("%s/\\s\\+$//e")<cr>

" copy into buffer
vmap <silent> <leader>c "+y
vmap <silent> <leader>p "+p

" json format selection
map <leader>j !python -m json.tool<cr>

" Disable command history
map q: <nop>

" insert breakpoints
au FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

" window management
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

map <c-s> :wq<cr>

map <space> /

nmap <A-j> mz:m+<cr>
" no arrow keys :/
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>

imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
imap <down> <nop>
" inoremap jk <Esc>

imap <PageUp> <up>
imap <PageDown> <down>

vmap <left> <nop>
vmap <right> <nop>
vmap <up> <nop>
vmap <down> <nop>

noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
map <leader>pp :setlocal paste!<cr>

nmap <leader>a <Plug>(coc-codeaction-line)

:command WQ wq
:command Wq wq
:command W w
:command Q q

" colors, syntax, etc
set t_Co=256
set background=dark
colorscheme jellybeans
filetype plugin indent on
syntax on


" statusline
hi user1 ctermbg=darkblue ctermfg=NONE
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
autocmd filetype rst setlocal ts=2 sts=2 sw=2 et
autocmd filetype js setlocal ts=2 sts=2 sw=2 et
autocmd filetype yaml setlocal ts=2 sts=2 sw=2 et


" autocmd read+new
autocmd bufread,bufnewfile $home/tmp/mutt-* set textwidth=72
autocmd bufread,bufnewfile *.wiki set ft=wikipedia
autocmd bufread,bufnewfile .tmux.conf set ft=tmux
autocmd bufread,bufnewfile .yaml set ft=yaml
autocmd bufread,bufnewfile /srv/django/templates/* set ft=htmldjango


" flake8
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\    'python': ['autopep8', 'black', 'flake8', 'isort', 'prospector', 'pycodestyle', 'pyls', 'pylint', 'yapf']
\}
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_python_pycodestyle_options = '--max-line-length=120'
" let g:PyFlakeOnWrite = 1
" let g:PyFlakeForcePyVersion = 3
" let g:PyFlakeCWindow = 10
" let g:PyFlakeMaxLineLength = 120
" let g:PyFlakeCheckers = 'pycodestyle,mccabe,frosted'
" let g:PyFlakeDisabledMessages = 'E701'

" netrw
let g:netrw_liststyle=3  " tree-mode

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

" XML formatter
function! DoFormatXML() range
	" Save the file type
	let l:origft = &ft

	" Clean the file type
	set ft=

	" Add fake initial tag (so we can process multiple top-level elements)
	exe ":let l:beforeFirstLine=" . a:firstline . "-1"
	if l:beforeFirstLine < 0
		let l:beforeFirstLine=0
	endif
	exe a:lastline . "put ='</PrettyXML>'"
	exe l:beforeFirstLine . "put ='<PrettyXML>'"
	exe ":let l:newLastLine=" . a:lastline . "+2"
	if l:newLastLine > line('$')
		let l:newLastLine=line('$')
	endif

	" Remove XML header
	exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

	" Recalculate last line of the edited code
	let l:newLastLine=search('</PrettyXML>')

	" Execute external formatter
	exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

	" Recalculate first and last lines of the edited code
	let l:newFirstLine=search('<PrettyXML>')
	let l:newLastLine=search('</PrettyXML>')
	
	" Get inner range
	let l:innerFirstLine=l:newFirstLine+1
	let l:innerLastLine=l:newLastLine-1

	" Remove extra unnecessary indentation
	exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

	" Remove fake tag
	exe l:newLastLine . "d"
	exe l:newFirstLine . "d"

	" Put the cursor at the first line of the edited code
	exe ":" . l:newFirstLine

	" Restore the file type
	exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>

" Terraform
" Syntastic Config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes=['py']

" " (Optional)Remove Info(Preview) window
" set completeopt-=preview

" " (Optional)Hide Info(Preview) window after completions
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" " (Optional) Enable terraform plan to be include in filter
" let g:syntastic_terraform_tffilter_plan = 1
"
" " (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
" let g:terraform_completion_keys = 1
"
" " (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
" let g:terraform_registry_module_completion = 0
