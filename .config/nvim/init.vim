syntax enable
filetype plugin indent on

set encoding=utf8
set number
set title
set autoindent
set background=dark
set nobackup
set smarttab
set shiftwidth=2 
set tabstop=2 
set ai
set si
set nowrap
set mouse=a
set cursorline

set ignorecase
set path+=**
set wildignore+=*/node_modules/*
set wildignore+=*/deps/*

call plug#begin(stdpath('data'), 'plugged')
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround' 
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovim/nvim-lspconfig'
" Plug 'williamboman/nvim-lsp-installer'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-system-copy'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'alvan/vim-closetag'
Plug 'mhinz/vim-signify'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
call plug#end()

set updatetime=100

colorscheme gruvbox

let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:NERDTreeGitStatusUseNerdFonts = 1

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTree<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require('telescope').setup()

lua require('nvim-treesitter.configs').setup { highlight = { enable = true} }

