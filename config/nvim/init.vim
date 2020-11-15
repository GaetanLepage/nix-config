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
Plug 'joshdick/onedark.vim' "nice colorscheme
Plug 'ryanoasis/vim-devicons' " coloured icons

Plug 'preservim/nerdcommenter' " Nerd Commenter

" NerdTree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

" Fuzzy file finder (fzf)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "fzf

" TagBar
Plug 'majutsushi/tagbar'

" Barbar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Scrollbar
Plug 'Xuyuanp/scrollbar.nvim'

Plug 'tpope/vim-surround' " git
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Nvim new LSP client
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
"Plug 'nvim-lua/diagnostic-nvim'

Plug 'mileszs/ack.vim'

" snippets allow to easily 'fill' common patterns
Plug 'honza/vim-snippets'

"""""""""""""""""""""
" LANGUAGES SUPPORT "
"""""""""""""""""""""

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter'

" Python
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tmhedberg/SimpylFold'
Plug 'sheerun/vim-polyglot'
"Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" LaTeX
Plug 'lervag/vimtex'

" Markdown
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'vim-pandoc/vim-pandoc'
Plug 'lingnand/pandoc-preview.vim'
Plug 'gabrielelana/vim-markdown'

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
syntax on
set nospell

let mapleader=' '

" Enable mouse control
set mouse=a

set laststatus=2
set encoding=utf-8

"disable fkin recording
map q <Nop>

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

" Fix Y behaviour
nmap Y y$

" fast buffer navigation
" nnoremap <F5> :buffers<CR>:buffer<Space>
"nnoremap <Tab> :tabn<CR>
"nnoremap <S-Tab> :tabp<CR>
"nmap <C-w> :q<CR>

" save by Ctrl+s
nmap <C-s> :w<CR>

" Quick indentation formatting for the whole file
map <F7> gg=G''

" Comment line or block
vmap <C-b> <plug>NERDCommenterToggle
nmap <C-b> <plug>NERDCommenterToggle

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

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

colorscheme gruvbox
"colorscheme onedark
"let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

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


""""""""""
" Barbar "
""""""""""

nnoremap <Tab> :BufferNext<CR>
nnoremap <S-Tab> :BufferPrevious<CR>
"
" Close buffer
nmap <C-w> :BufferClose<CR>

""""""""""""""""""
" Pandoc preview "
""""""""""""""""""
let g:pandoc_preview_pdf_cmd = "zathura"
nnoremap <leader>v :PandocPreview<cr>

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:coc_snippet_next = '<tab>'

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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


"""""""""""""
" Scrollbar "
"""""""""""""
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
augroup end

""""""""""""""
" TreeSitter "
""""""""""""""
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
  "ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  "highlight = {
    "enable = true,              -- false will disable the whole extension
    "-- disable = { "c", "rust" },  -- list of language that will be disabled
  "},
  "indent = {
    "enable=true
  "}
"}
"EOF


""""""""""""
" nvim-lsp "
""""""""""""
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" "nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


"""""""""""""""""""
" completion-nvim "
"""""""""""""""""""
" lua require'nvim_lsp'.pyls.setup{ on_attach=require'completion'.on_attach }
"
" " Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
"
" " Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" " Avoid showing message extra message when using completion
" set shortmess+=c
"
" " possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
" let g:completion_enable_snippet = 'UltiSnips'


"""""""""""""""""""
" diagnostic-nvim "
"""""""""""""""""""
" lua require'nvim_lsp'.pyls.setup{ attach=require'diagnostic'.on_attach }
" let g:diagnostic_enable_virtual_text=1
" let g:diagnostic_level = 'Warning'
" let g:diagnostic_virtual_text_prefix = '<<'
" let g:diagnostic_trimmed_virtual_text = 20
" let g:diagnostic_insert_delay = 1
" let g:diagnostic_enable_underline = 0
" call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
" call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
" call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
" call sign_define("LspDiagnosticsHintSign", {"text" : "ﯦ", "texthl" : "LspDiagnosticsWarning"})


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
let g:ale_python_pylint_options = '--rcfile $HOME/.pylintrc'

""""""""""""
" Markdown "
""""""""""""

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


""""""""""
" PYTHON "
""""""""""
"let g:python3_host_prog = '$HOME/.local/bin/python3'
let g:python_highlight_all = 1
let g:SimpylFold_docstring_preview = 1


"""""""""
" LATEX "
"""""""""
autocmd BufRead,BufNewFile *.tex set filetype=tex "| VimtexTocOpen
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
