"vimrc of Stephen Gates

"--------------------------- TODO list ---------------------------
"1. Find a better mapping for expandUltiSnips

" insert mode mappings, like to get some more Mac/Emacs bindings
" <leader>Tab is open as is m<tab> and <leader><leader>!!!
" Open gui item in terminal vim instance
" Fix coloration of easy-motion hints
" Make my own theme like solorized, but for f.lux computers with Easy-motion(weekend project)
" Airline theme & Git integration
" Get themes to work properly in VIM
" Change themes with a mapping

"--------------------------- Package manager ---------------------------

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
Plugin 'mhinz/vim-startify'
Plugin 'vim-airline/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'

Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'

call vundle#end()         " required
filetype plugin indent on " required
filetype indent plugin on " try to identity a file for auto-indenting and plugins

"--------------------------- Standard settings ---------------------------
syntax on

"Search
set hlsearch   " highlight searches
set incsearch  " show incremental results while typing
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

set hidden
set undofile
set undodir=~/.vim/undo
set wildmenu
set showcmd " Show partial commands in the last line of the screen

set tabstop=2    " size of a hard tabstop
set expandtab    " Insert spaces instead of tab characters when tab is pressed
set shiftwidth=4 " All indentation levels use 'shiftwidth' number of characters
set shiftwidth=2 " size of an 'indent'
set autoindent "When no filetype-specific indenting, maintain indentation level

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline
set backspace=indent,eol,start " Allow custom backspace movement

set ruler       " Display cursos position on last line or in status
set number
set confirm     " Save prompt
set cmdheight=2 " Set the command window height to 2 lines
set mouse=a     " Enable use of the mouse for all modes
set laststatus=2

let g:is_posix=1

"--------------------------- Mappings ---------------------------

"Return to normal mode
inoremap fd <ESC>
vnoremap fd <ESC>

let mapleader = "\<space>"

"Temporary mapping to edit .vimrc
map <leader>fed :e $MYVIMRC<cr>
map <leader>bh :Startify<cr>
" map y to act like d and c, i.e. to yank until EOL
map Y y$

"incsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
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
vmap a"   :Tabularize /"<CR>
vmap <CR> :Tabularize /

"Gundo
let g:gundo_prefer_python3 = 1
nnoremap <leader>u :GundoToggle<CR>

"Multiple-cursors THESE WILL NOT WORK UNTIL THE PACKAGE IS UPDATED
"let g:multi_cursor_quit_key='fd'
"let g:multi_cursor_insert_maps = {'f':1}

" Easily switch buffers, switch windows & generate new splits
nmap [b :bp<CR>
nmap ]b :bn<CR>

nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap <C-x>      :wincmd q<CR>

nmap <leader>wh :vert sbn<CR>
nmap <leader>wj :below sbn<CR>:wincmd j<CR>
nmap <leader>wk :sbn<CR>
nmap <leader>wl :vert belowright sbn<CR>

"--------------- Adopted from tpope/vim-unimpaired ------------------

function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>BlankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>BlankDown", a:count)
endfunction

nnoremap <silent> <Plug>BlankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>BlankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

nmap [<Space> <Plug>BlankUp
nmap ]<Space> <Plug>BlankDown

"--------------------------- Themes ---------------------------

call togglebg#map("<F5>")
set background=dark
"colorscheme solarized
colorscheme monokai

"--------------------------- Plugin options ---------------------------

let g:ycm_python_binary_path = '/usr/local/bin/python3'

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"
map <leader>Ue :UltiSnipsEdit<cr>

"--------------------------- Autocommands ---------------------------

"Source .vimrc on write
augroup reload_vimrc
  autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"Save folds
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

"--------------------------- Testing ---------------------------

"""function! g:UltiSnips_Complete()
"""    call UltiSnips#ExpandSnippet()
"""    if g:ulti_expand_res == 0
"""        if pumvisible()
"""            return "\<C-n>"
"""        else
"""            call UltiSnips#JumpForwards()
"""            if g:ulti_jump_forwards_res == 0
"""               return "\<TAB>"
"""            endif
"""        endif
"""    endif
"""    return ""
"""endfunction
"""
"""au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
"""let g:UltiSnipsExpandTrigger="<C-j>"
"""let g:UltiSnipsJumpForwardTrigger="<C-j>"
