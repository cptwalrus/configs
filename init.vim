syntax on

set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nohlsearch
set scrolloff=8
set signcolumn=yes


"
" Give more space for displaying messages.
set cmdheight=2

set comments=s1:/*,mb:\ *,e1x:\ */

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey



call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'

Plug 'mbbill/undotree'

"nvim-lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

"vim debugging... maybe this is a bad idea?
Plug 'puremourning/vimspector'

"GLSL syntax
Plug 'tikhomirov/vim-glsl'

"Rust stuff
Plug 'rust-lang/rust.vim'

call plug#end()

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark


"mappings
let mapleader = " "

let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

"vimspector mappings
nnoremap <silent> <leader><F10> :call vimspector#StepInto()<CR>
nnoremap <silent> <leader><F5> :call vimspector#LaunchWithSettings( #{ configuration: 'Default' } )<CR>
nnoremap <leader><F4> :VimspectorReset<CR>
nnoremap <leader>w :VimspectorWatch<space> 

"Telescope settings
let g:telescope_cache_results = 1
let g:telescope_prime_fuzzy_find = 1
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

"LSP stuff shamelessly stolen from ThePrimeagen
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vll :call LspLocationList()<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
