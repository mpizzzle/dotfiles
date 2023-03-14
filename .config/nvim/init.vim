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
Plug 'PyGamer0/vim-apl', { 'branch': 'main' }
Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
Plug 'git@git.sr.ht:~detegr/nvim-bqn'
call plug#end()

"set bg=light
"set go=a
"set mouse=a
set nohlsearch
set expandtab
set tabstop=4
"set clipboard+=unnamedplus

let g:airline_theme='violet'
let g:airline_powerline_fonts=1
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

" swapfile directory
  set dir=~/.local/share/nvim/swap/

" bqn executable name
  let g:nvim_bqn='bqn'

" airline symbols
  let g:airline_left_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_right_sep=''
  let g:airline_right_alt_sep=''
  let g:airline_symbols.branch=''
  let g:airline_symbols.readonly='∅'
  let g:airline_symbols.colnr = ' ⍆'
  let g:airline_symbols.linenr = ' ⍖'
  let g:airline_symbols.maxlinenr = ' ¶ '
  let g:airline_symbols.dirty=''
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.notexists = ' ∉'

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

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
