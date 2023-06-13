let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'ptzz/lf.vim'
call plug#end()

" Plug 'ap/vim-css-color'

set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set bg=dark
let g:solarized_termcolors=256
colorscheme solarized
set termguicolors

" set cursorline cursorcolumn
" highlight CursorLine guibg=#41474d
" highlight CursorColumn guibg=#41474d

set wildmode=longest,list,full

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
autocmd StdinReadPre * let s:std_in=1

map <leader>f :Goyo \| set linebreak<CR>

map <leader>o :setlocal spell! spelllang=en_us<CR>

map <leader>l :set wrap!<CR>

map <leader>h :ColorToggle<CR>

map <leader>H :set cursorline! cursorcolumn!<CR>

set splitbelow splitright

map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nm <leader>d :call ToggleDeadKeys()<CR>
imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
nm <leader>i :call ToggleIPA()<CR>
imap <leader>i <esc>:call ToggleIPA()<CR>a
nm <leader>q :call ToggleProse()<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let g:user_emmet_mode='n'
let g:user_emmet_leader_key='-'

map <leader>s :!clear && shellcheck %<CR>

nnoremap Q :%s//g<Left><Left>

map <leader>c :setlocal formatoptions-=cro<CR>
map <leader>C :setlocal formatoptions=cro<CR>

map <leader>p :!opout <c-r>%<CR><CR>

autocmd VimLeave *.tex !texclear %

let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

vnoremap <C-c> "+y
map <leader>y "+y
map <C-p> "+P

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

autocmd BufWritePre * %s/\s\+$//e

autocmd BufWritePost files,directories !shortcuts

autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

map <leader>c :w! \| !compiler <c-r>%<CR>

noremap [<space> o<ESC>
noremap ]<space> O<ESC>
