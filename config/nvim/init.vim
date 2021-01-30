" ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
" ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
" ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
" ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
" ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
" Website:  glepage.com
" GitHub:   https://github.com/GaetanLepage
" Email:    gaetan.lepage@inria.fr
"
" #---------------#
" | neovim config |
" #---------------#

"""""""""""
" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'                                              " status bar (needs special fonts)
Plug 'ryanoasis/vim-devicons'                                               " various symbols
Plug 'gruvbox-community/gruvbox'                                            " nice colorscheme
Plug 'ryanoasis/vim-devicons'                                               " coloured icons
Plug 'preservim/nerdcommenter'                                              " Nerd Commenter
Plug 'preservim/nerdtree'                                                   " NerdTree
"Plug 'ms-jpq/chadtree', {'branch':'chad', 'do': 'python3 -m chadtree deps'}
Plug 'preservim/nerdtree'                                                   " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'                                          " NerdTree Git plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                         " Fuzzy file finder (fzf)
Plug 'junegunn/fzf.vim'                                                     " fzf
Plug 'nvim-lua/popup.nvim'                                                  " [Telescope] An implementation of the Popup API from vim in Neovim.
Plug 'nvim-lua/plenary.nvim'                                                " [Telescope] Lua functions.
Plug 'nvim-telescope/telescope.nvim'                                        " [Telescope] Fuzzy finder.
Plug 'majutsushi/tagbar'                                                    " TagBar
Plug 'dstein64/nvim-scrollview', {'branch': 'main'}                         " Scrollbar
Plug 'neoclide/coc.nvim', {'branch': 'release'}                             " Coc autocompletion
Plug 'honza/vim-snippets'                                                   " Snippets engine
Plug 'tpope/vim-fugitive'                                                   " Git Fugitive
Plug 'airblade/vim-gitgutter'                                               " A Vim plugin which shows a git diff in the sign column.
Plug 'szw/vim-maximizer'                                                    " Maximizes and restores the current window in Vim.
Plug 'lervag/vimtex'                                                        " LateX
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}                      " [Python] color scheme
Plug 'tmhedberg/SimpylFold'                                                 " [Python] improved folding
Plug 'sheerun/vim-polyglot'                                                 " [Python] syntax highlighting
Plug 'dense-analysis/ale'                                                   " Linter
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }    " Markdown
call plug#end()


""""""""""""""""
" VIM SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""

""""""""
" Sets "
""""""""
filetype plugin indent on

" Line numbers
set relativenumber          " Relative line numbers
set number                  " display the absolute line number of the current line
set hidden                  " keep closed buffer open in the background
set clipboard+=unnamedplus  " Use system clipboard
set mouse=a                 " Enable mouse control
set splitbelow              " A new window is put below the current one
set splitright              " A new window is put right of the current one
set noerrorbells            " Disable the error bell for errors
set noswapfile              " Disable the swap file
set modeline                " Tags such as 'vim:ft=sh'
set modelines=100           " Sets the type of modelines
set undofile                " Automatically save and restore undo history
set incsearch               " Incremental search: show match for partly typed search command
set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
set scrolloff=8             " number of screen lines to show around the cursor
"set cursorline             " Highlight the screen line of the cursor
"set cursorcolumn           " Highlight the screen column of the cursor
set signcolumn=yes          " whether to show the signcolumn
set colorcolumn=100         " columns to highlight
set laststatus=2            " 0, 1 or 2; when to use a status line for the last window
set encoding=utf-8          " encoding used to print the PostScript file for :hardcopy
set nospell                 " highlight spelling mistakes (local to window)
syntax on                   " Enable syntax highlighting
let mapleader=' '           " Set space as the leader key
let maplocalleader=' '      " Set space as the localleader key

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Tab options
set tabstop=4               " number of spaces a <Tab> in the text stands for (local to buffer)
set softtabstop=4           " number of spaces used for each step of (auto)indent (local to buffer)
set shiftwidth=4            " number of spaces used for each step of (auto)indent (local to buffer)
set softtabstop=0           " if non-zero, number of spaces to insert for a <Tab> (local to buffer)
set expandtab               " expand <Tab> to spaces in Insert mode (local to buffer)
set smartindent             " do clever autoindenting

" Folding
set foldmethod=indent       " Set folding type to indent
set foldlevel=99            " Folds with a level higher than this number will be closed


""""""""""""""""""""""""
" Vim-related mappings "
""""""""""""""""""""""""
" Disable macro recording
map q <Nop>

" Quick indentation formatting for the whole file
noremap <F7> gg=G''

" Fix Y behaviour
nnoremap Y y$

" fast buffer navigation
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap <C-w> :q<CR>

" save by Ctrl+s
nmap <C-s> :w<CR>

nmap <C-t> :tabnew<CR>

" Quick indentation formatting for the whole file
map <F7> gg=G''

" Comment line or block
vmap <C-b> <plug>NERDCommenterToggle
nmap <C-b> <plug>NERDCommenterToggle

" Split navigations
let g:BASH_Ctrl_j = 'off'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Resize splits
nnoremap <leader>j :res +5<CR>
nnoremap <leader>k :res -5<CR>
nnoremap <leader>h :vertical resize +5<CR>
nnoremap <leader>l :vertical resize -5<CR>

" Esc to clear search results
nnoremap <esc> :noh<return><esc>


"""""""""""""""""
" Basic AutoCmd "
"""""""""""""""""
" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWrite * %s/\s\+$//e

" yml files indent
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab


""""""""""""""
" APPEARANCE "
""""""""""""""

colorscheme gruvbox
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/


"""""""""""""""""""
" Plugin settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""

"""""""
" FZF "
"""""""
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :History<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>t :Ag TODO<CR>

"""""""""""""
" Telescope "
"""""""""""""
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" FZF like bindings
nnoremap <C-p> :Telescope git_files<CR>
nnoremap <leader>p :Telescope oldfiles <CR>
nnoremap <leader>a :Telescope live_grep<CR>

" Use the fuzzy sorter
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})


""""""""""
" TagBar "
""""""""""
nmap <C-g> :TagbarToggle<CR>
let g:tagbar_width = 50
"autocmd FileType python,c,cpp,h,java nested :call tagbar#autoopen(0)


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

let g:coc_snippet_next = '<enter>'

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


""""""""""""
" NerdTree "
""""""""""""
"map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<CR>

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


""""""""""""
" CHADTree "
""""""""""""
"nnoremap <leader>n <cmd>CHADopen<CR>


"""""""
" ALE "
"""""""
let g:ale_linters = {
            \'python': ['pylint', 'mypy'],
            \'latex': ['chktex']}
let g:ale_set_balloons = 1


""""""""""""""
" Git Gutter "
""""""""""""""
let g:gitgutter_map_keys = 0


""""""""""""""""
" Vim Fugitive "
""""""""""""""""
nmap <leader>gs :vert Git<CR> :vertical resize 80<CR>


""""""""""""
" Markdown "
""""""""""""
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


""""""""""
" PYTHON "
""""""""""
let g:python3_host_prog = '/usr/bin/python3'
let g:python_highlight_all = 1
let g:SimpylFold_docstring_preview = 1


"""""""""
" LATEX "
"""""""""
autocmd BufRead,BufNewFile *.tex set filetype=tex "| VimtexTocOpen
" autocmd FileType tex setl updatetime=1000
let g:vimtex_view_method = 'zathura'

" TOC settings
let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo'],
      \ 'resize' : 1,
      \ 'split_width' : 50,
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \}

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
  au User VimtexEventInitPost call vimtex#compiler#compile()
  au User VimtexEventQuit     call vimtex#compiler#clean(0)
augroup END
