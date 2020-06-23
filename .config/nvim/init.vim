let mapleader =","

call plug#begin('~/.config/nvim/plugged')
"Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
"Plug 'ryanoasis/vim-devicons'
"Plug 'junegunn/goyo.vim'
"Plug 'jreybert/vimagit'
"Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-commentary'
"Plug 'kovetskiy/sxhkd-vim'
"Plug 'ap/vim-css-color'
Plug 'airblade/vim-gitgutter'
call plug#end()

"set bg=light
"set go=a
"set mouse=a
set nohlsearch
"set clipboard+=unnamedplus

let g:airline_theme='violet'
let g:airline_powerline_fonts=1
let g:airline#extensions#hunks#enabled=1  
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

" powerline symbols
  let g:airline_left_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_right_sep=''
  let g:airline_right_alt_sep=''
  let g:airline_symbols.branch=''
  let g:airline_symbols.readonly=''
  " let g:airline_symbols.linenr='☰'
  let g:airline_symbols.maxlinenr=''
  let g:airline_symbols.dirty=''

" Some basics:
  "nnoremap c "_c
  set nocompatible
  filetype plugin on
  syntax on
  set encoding=utf-8
  set number relativenumber
" Enable autocompletion:
  set wildmode=longest,list,full
" Disables automatic commenting on newline:
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  highlight! link SignColumn LineNr
" Goyo plugin makes text more readable when writing prose:
  "map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
  "map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
  set splitbelow splitright

" Nerd tree
  nmap <C-n> :NERDTreeToggle<CR>

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Check file in shellcheck:
  "map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
  nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
  "autocmd BufWritePre * %s/\s\+$//e
  "autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
  "autocmd BufWritePost files,directories !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
  autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
  autocmd BufWritePost * GitGutter
