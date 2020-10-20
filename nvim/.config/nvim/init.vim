" Gaetan Lepage's vim config file, intended to use with neovim but surely
"" compatible with vim
"" Originally based on the vim 8 config file by Ensimag

"" - install some font with powerline symbols for eye candy and icons
"" (see https://github.com/powerline/fonts)
"" - You may want to install nerd fonts for more compatibility with airline and vim
"" devicons https://github.com/ryanoasis/nerd-fonts

"" after that copy this file as your $HOME/.config/nvim/init.vim (or ~/.vimrc for classic vim) and execute :PlugInstall

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged') " for neovim

Plug 'tpope/vim-sensible' " sane defaults

" eye candy
Plug 'vim-airline/vim-airline' " status bar (needs special fonts)
Plug 'ryanoasis/vim-devicons' " various symbols (linux, rust, python, ...)
Plug 'drewtempelmeyer/palenight.vim' "nice colorscheme
Plug 'gruvbox-community/gruvbox' "nice colorscheme
Plug 'ryanoasis/vim-devicons' " coloured icons

Plug 'preservim/nerdcommenter' " Nerd Commenter

" NerdTree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

" Fuzzy file finder (fzf)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "fzf

" TagBar
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-surround' " git
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mileszs/ack.vim'

" snippets allow to easily 'fill' common patterns
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

"""""""""""""""""""""
" LANGUAGES SUPPORT "
"""""""""""""""""""""
" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tmhedberg/SimpylFold'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" LaTeX
Plug 'lervag/vimtex'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" TOML
Plug 'cespare/vim-toml'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""
" Remaps & co "
"""""""""""""""
filetype plugin indent on

" Use system clipboard
set clipboard+=unnamedplus

set splitbelow splitright

set nocompatible
filetype off

let mapleader=' '

" Enable mouse control
set mouse=a

set laststatus=2
set encoding=utf-8

syntax on

set nospell

" Quick indentation formatting for the whole file
map <F7> gg=G''

" replace tabs
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab

" enable folding
set foldmethod=indent
set foldlevel=99
"nnoremap <space> za

" fast buffer navigation
" nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nmap <C-w> :q<CR>

" save by Ctrl+s
nmap <C-s> :w<CR>

" Quick indentation formatting for the whole file
map <F7> gg=G''

" Comment line or block
vmap <C-b> <plug>NERDCommenterToggle
nmap <C-b> <plug>NERDCommenterToggle


" split navigations
let g:BASH_Ctrl_j = 'off'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" esc to clear search results
nnoremap <esc> :noh<return><esc>

" yml files indent
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab


"""""""""""""""""
" Basic AutoCmd "
"""""""""""""""""
" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWrite * %s/\s\+$//e

" let's autoindent c files
au BufWrite *.c call LanguageClient#textDocument_formatting()


""""""""""""""
" APPEARANCE "
""""""""""""""

"colorscheme palenight
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#ale#enabled = 1
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

set background=dark
" Set background transparent
"hi! Normal ctermbg=NONE guibg=NONE

set rnu nu " hybrid line numbers

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Color column at 99 char
augroup collumnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType scala,java,python
                \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
    let collumnLimit = 99 " feel free to customize
    let pattern =
                \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType scala,java,python
                \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""
" FZF "
"""""""
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :History<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>t :Ag TODO<CR>


""""""""""
" TagBar "
""""""""""
nmap <C-g> :TagbarToggle<CR>
let g:tagbar_width = 50
"autocmd FileType python,c,cpp,h,java nested :call tagbar#autoopen(0)


"""""""
" COC "
"""""""
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-texlab',
    \ 'coc-markdownlint',
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ ]

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" configure maralla/completor to use tab
" other configurations are possible (see website)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


""""""""""""
" ChadTree "
""""""""""""
nnoremap <C-n> :CHADopen<CR>
let g:chadtree_settings = {
            \ 'keymap': {
                \ 'collapse': [],
                \ 'primary': ['<enter>', '<2-leftmouse>'],
                \ 'secondary': [],
                \ 'tertiary': ['t'],
                \ 'trash': []
            \ },
            \ 'width': 35}


"""""""
" ALE "
"""""""
let g:ale_linters = {
            \'python': ['pylint', 'mypy'],
            \'latex': ['chktex']}
let g:ale_set_balloons = 1


""""""""""
" PYTHON "
""""""""""
let g:python3_host_prog = '$HOME/.local/bin/python3'
let g:python_highlight_all = 1
let g:ale_python_pylint_options = '--rcfile ~/.pylint.rc'
let g:SimpylFold_docstring_preview = 1


"""""""""
" LATEX "
"""""""""
"autocmd BufRead,BufNewFile *.tex set filetype=tex | VimtexTocOpen
" autocmd FileType tex setl updatetime=1000
let g:vimtex_view_method = 'zathura'

let g:tex_flavor = 'latex'

let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_quickfix_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0
"nmap <C-m> :VimtexTocToggle <CR>
autocmd FileType tex,latex nnoremap <buffer> m :VimtexView<CR>

autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'

" Spell check
autocmd FileType tex,latex,markdown setlocal spell spelllang=en,fr

" folding
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

" Compile on initialization, cleanup on quit
augroup vimtex_event_1
  au!
  au User VimtexEventQuit     call vimtex#compiler#clean(0)
  au User VimtexEventInitPost call vimtex#compiler#compile()
augroup END
