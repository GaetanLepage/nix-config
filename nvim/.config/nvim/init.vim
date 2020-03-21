"" Gaetan Lepage's vim config file, intended to use with neovim but surely
"" compatible with vim
"" Originally based on the vim 8 config file by Ensimag

"" - install plug with :
""      curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" (see https://github.com/junegunn/vim-plug)
"" - install the languageserver server for each language you indend to use :
""    * pyls for python (see https://github.com/palantir/python-language-server)
""    * rls for rust (see https://github.com/rust-lang-nursery/rls)
""    * clangd for c
"" - you need to install jedi for python auto-completion
"" - install some font with powerline symbols for eye candy and icons
"" (see https://github.com/powerline/fonts)
"" - You may want to install nerd fonts for more compatibility with airline and vim
"" devicons https://github.com/ryanoasis/nerd-fonts

"" after that copy this file as your $HOME/.config/nvim/init.vim (or ~/.vimrc for classic vim) and execute :PlugInstall

"""""""""""""
"""""""""""""
"" PLUGINS ""
"""""""""""""
"""""""""""""
call plug#begin('~/.config/nvim/plugged') " for neovim

Plug 'tpope/vim-sensible' " sane defaults

""""""""""""""
" APPEARANCE "
""""""""""""""
" eye candy
Plug 'vim-airline/vim-airline' " status bar (needs special fonts)
" Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " various symbols (linux, rust, python, ...)
" Plug 'deviantfero/wpgtk.vim' " Automatic theme based on wallpaper
Plug 'drewtempelmeyer/palenight.vim' "nice colorscheme

" essential plugins
" Plug 'zxqfl/tabnine-vim' " auto-complete
Plug 'tpope/vim-fugitive' " git
Plug 'scrooloose/nerdcommenter' " Nerd Commenter

" NerdTree
Plug 'scrooloose/nerdtree' " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'kien/ctrlp.vim' "ctrlP
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-surround' " git
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" snippets allow to easily 'fill' common patterns
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

"""""""""""""""""""""
" LANGUAGES SUPPORT "
"""""""""""""""""""""
" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" LaTeX editing
Plug 'lervag/vimtex'

" Jupyter
"Plug 'szymonmaszke/vimpyter' "vim-plug

call plug#end()




"""""""""""""""""
"""""""""""""""""
"" Remaps & co ""
"""""""""""""""""
"""""""""""""""""
filetype plugin indent on

set splitbelow splitright

set nocompatible
filetype off

let mapleader=' '

set laststatus=2
set encoding=utf-8

syntax on

set nospell

" Quick indentation formatting for the whole file
map <F7> gg=G''

nmap <F8> :TagbarToggle<CR>



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



" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction


" NERDTree config
let NERDTreeIgnore=[
    \ '\.pyc$',
    \ '\~$',
    \ '\.aux'
    \ ] "ignore files in NERDTree

" Automatically open NERDTree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Shortcut for nerdtree
map <C-n> :NERDTreeToggle<CR>
"Close vim if the only window left open is nerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction


let g:ctrlp_cmd = 'CtrlPMixed'


""""""""""""""
" APPEARANCE "
""""""""""""""
let g:airline_powerline_fonts = 1
colorscheme palenight
set background=dark
" Set background transparent
hi! Normal ctermbg=NONE guibg=NONE

set rnu nu " hybrid line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" replace tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" let's autoindent c files
au BufWrite *.c call LanguageClient#textDocument_formatting()


" fast buffer navigation
" nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
nmap <C-w> :bd<CR>

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

" Disable the bell for intellij
set visualbell
set noerrorbells

" yml files indent
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab



"""""""""
" LATEX "
"""""""""
" Latex live preview conf
" autocmd FileType tex setl updatetime=1000
" let g:livepreview_engine = 'pdflatex'
" let g:livepreview_previewer = 'zathura'
" let g:vimtex_compiler_progname = 'latexmk'
let g:vimtex_quickfix_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0

" Spell check
autocmd FileType tex set spell spelllang=en,fr


" Color column at 80 char
augroup collumnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType scala,java,python,tex
                \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
    let collumnLimit = 99 " feel free to customize
    let pattern =
                \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType scala,java,python,tex
                \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END
