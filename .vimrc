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
set splitright
set splitbelow


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

set background=dark
colorscheme torte

"mappings
let mapleader = " "


"Block commenting
function BlockComment()
    let l:comment=split(&commentstring, '%s')
    if len(comment)==1
        call add(comment, '')
    endif
    let l:currMode=mode()
    if getline(".") =~ '^\s*'. l:comment[0]
        let l:commentLen = strchars(l:comment[0])
        let l:normalMatch = ':s/^.\{' . l:commentLen . '}//'
        let l:visualMatch = ":'<,'>s/^.\{" . l:commentLen . '}//'
        if l:currMode == "V"
            :execute l:visualMatch
        elseif l:currMode == "n"
            :execute l:normalMatch
        endif
    else
        if l:currMode == "V"
            :'<,'>s/^/\=l:comment[0]/
        elseif l:currMode == "n"
            :s/^/\=l:comment[0]/
        endif
    endif
endfunction

noremap <leader>c :call BlockComment()<CR>


"Terminal
"This will probably not work on normal vim
nnoremap <leader>t :vert term://bash<CR>  
nnoremap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>
