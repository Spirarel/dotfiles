"vimrc of Stephen Gates

"todo
"include a shortcut to insert space in normal mode
"airline
"Fix coloration of easy-motion hints

"--- Package manager ---

set nocompatible
filetype off "Required off for vundle initialization

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'Lokaltog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'haya14busa/incsearch.vim'
Plugin 'sjl/gundo.vim'
Plugin 'lervag/vimtex'
Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-airline/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required
filetype indent plugin on "try to identity a file for auto-indenting and plugins
syntax on

"Search
set hlsearch  " highlight searches
set incsearch " show incremental results while typing
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

set hidden
set undofile
set wildmenu
set showcmd " Show partial commands in the last line of the screen

set tabstop=2    " size of a hard tabstop
set expandtab    " Insert spaces instead of tab characters when tab is pressed
set shiftwidth=4 " All indentation levels use 'shiftwidth' number of characters
set shiftwidth=2 " size of an 'indent'

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline
set backspace=indent,eol,start " Allow custom backspace movement
set autoindent "When no filetype-specific indenting, maintain indentation level

set ruler       " Display cursos position on last line or in status
set number
set confirm     " Save prompt
set cmdheight=2 " Set the command window height to 2 lines
set mouse=a     " Enable use of the mouse for all modes

"--------------------------- Mappings ---------------------------

"Return to normal mode
inoremap fd <ESC>
vnoremap fd <ESC>

let mapleader = "\<space>"

"Temporary mapping to edit .vimrc
map <leader>fed :e $MYVIMRC<cr>
" map y to act like d and c, i.e. to yank until EOL
map Y y$

"incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Toggle spell check on and off
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us "Spell check language is English(US)

"Easymotion
map m <Plug>(easymotion-prefix)
map mw <Plug>(easymotion-bd-w)
map mh <Plug>(easymotion-linebackward)
map ml <Plug>(easymotion-lineforward)

"Tabular
let g:haskell_tabular = 1
vmap a=   :Tabularize /=<CR>
vmap a;   :Tabularize /::<CR>
vmap a-   :Tabularize /-><CR>
vmap a#   :Tabularize /#<CR>
vmap <CR> :Tabularize /

"Gundo
let g:gundo_prefer_python3 = 1
nnoremap <leader>u :GundoToggle<CR>

"Multiple-cursors THESE WILL NOT WORK UNTIL THE PACKAGE IS UPDATED
"let g:multi_cursor_quit_key='fd'
"let g:multi_cursor_insert_maps = {'f':1}

"--------------------------- Themes ---------------------------

let g:solarized_termcolors=256
call togglebg#map("<F5>")
set background=dark
"colorscheme solarized
colorscheme monokai

"------------------------------------------------------------
"Syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0 "restore to 1 when/if ready to use Syntastic
"let g:syntastic_check_on_wq = 0
"let g:syntastic_haskell_checkers = ['hlint', 'ghc_mod']

"""""" Tab completion
"""""" will insert tab at beginning of line, will use completion if not at beginning
"""""set wildmode=list:longest,list:full
"""""function! InsertTabWrapper()
"""""      let col = col('.') - 1
"""""      if !col || getline('.')[col - 1] !~ '\k'
"""""        return "\<tab>"
"""""      else
"""""        return "\<c-p>"
"""""      endif
"""""endfunction
"""""inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
"""""inoremap <S-Tab> <c-n>
"""""
"""""" . scan the current buffer, b scan other loaded buffers that are in the  buffer list, u scan the unloaded buffers that are in the buffer list, w scan buffers from other windows, t tag completion
"""""set complete=.,b,u,w,t,]
"""""
"""""" Keyword list  NOT IMPLEMENTED YET
"""""set complete+=k~/.vim/keywords.txt

"Source .vimrc on write
augroup reload_vimrc
  autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
