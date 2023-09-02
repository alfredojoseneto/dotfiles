"===============================================================================
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"===============================================================================

"-------------------- INITAL_CONFIGURARIONS ------------------------------------
"$ vim --version -> verify if the "+xterm_clipboard" is enable. Case not,
"install "vim-gui-common" --> $ sudo apt install vim-gui-common
"
"-------------------- PLUGIN_MANAGER -------------------------------------------
"$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"-------------------------------------------------------------------------------
"===============================================================================


" Do not save backup files.
set nobackup
set nowritebackup

" Create the vertical splits to the right 
set splitright

" Create the horizontal splits below
set splitbelow

" Update vim after file update from outside
set autoread

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Setting Mouse Support
set mouse=a

" Enable type file detection. Vim will be able to try to detect the type of file is use. 
filetype on

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

"Set cursor is able to move from end of line to next line
set whichwrap+=h,l,b,s,<,>,[,]

" Set the margin to 10000 to previne wrap
set wrapmargin=10000

" Set the text width of 10000 o previne wrap
set textwidth=10000

" Setting the behavior of the backspace
set backspace=indent,eol,start

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to the file.
set number

" Enable relative line number
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Hides the current buffer when a new file is openned
set hidden

" Highlight cursor line underneath the cursor vertically and text over 80 chars
set colorcolumn=81
highlight ColorColumn ctermbg=darkgray
highlight OverLength ctermbg=darkgrey ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Set shift width to 4 spaces.
set shiftwidth=4

" Setting smarttab to inserts blanks according to 'shiftwidth'
set smarttab

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Set the ruler to show the point in the text in the cmd
set ruler

" Setting the smart indentation
set smartindent

" Set list of chars and what chars to display
set list

"set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set listchars=tab:¦·,trail:·,nbsp:␣,eol:↲,precedes:❮,extends:❯

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd
set cmdheight=2

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Copy to the clipboard
set clipboard=unnamedplus

" The encoding should be utf-8 to activate the font icons
set encoding=utf-8


"===============================================================================
"-------------------- PLUGGINS -------------------------------------------------
"===============================================================================
" VimPlug autoinstallation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'sainnhe/sonokai'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'dracula/vim', {'as':'dracula'}
    Plug 'christoomey/vim-tmux-navigator'
call plug#end()

"-------------------------------------------------------------------------------

"===============================================================================
"-------------------- COLOR_SCHEME ---------------------------------------------
"===============================================================================
colorscheme dracula

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"===============================================================================
"-------------------- MAPPING_KEYS ---------------------------------------------
"===============================================================================

" Set the backslash as the leader key
let mapleader = " "

" Type jk to exit insert mode quickly
inoremap jk <Esc>

" Type jk to exit insert mode quickly
nnoremap <leader>h :noh<CR>

" Center the cursor vertically when moving to the next word during a search
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <C-up> <c-w>+
noremap <C-down> <c-w>-
noremap <C-left> <c-w>>
noremap <C-right> <c-w><

" Copy to and from clipboad
noremap <leader>c "+y
noremap <leader>v "+p

" Walking around wrapped words
nnoremap k gk
nnoremap j gj

" Showing Buffers
nnoremap <leader>b :ls<CR>:buffer<Space>

" Mapping some characters to edit files
inoremap <F12> <Esc>20A=<Esc>A
inoremap <S-F12> <Esc>80A=<Esc>81<Bar>v$hx
inoremap <C-F12> <Esc>20A-<Esc>A
inoremap <C-S-F12> <Esc>80A-<Esc>81<Bar>v$hx
