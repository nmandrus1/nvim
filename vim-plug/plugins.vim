" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Plugins for lsp and auto-complete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Plugin for rust development
Plug 'simrat39/rust-tools.nvim'
" Dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Theme
Plug 'joshdick/onedark.vim'
" File Tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Commentary
Plug 'tpope/vim-commentary'
" Which Key
Plug 'liuchengxu/vim-which-key'

call plug#end()
