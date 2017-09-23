"neovim config of Stephen Gates
"
"--------------------------- TODO list ---------------------------
" Auto-resource init.vim
" Find a better mapping for expandUltiSnips
" insert mode mappings, like to get some more Mac/Emacs bindings
" <leader>Tab is open as is m<tab> and <leader><leader>!!!
" Open gui item in terminal vim instance
" Fix coloration of easy-motion hints
" Make my own theme like solorized, but for f.lux computers with Easy-motion(weekend project)
" Airline theme & Git integration
" Get themes to work properly in VIM
" Change themes with a mapping

"--------------------------- Package manager ---------------------------

call plug#begin()

Plug 'gmarik/Vundle.vim' " let Vundle manage Vundle, required
Plug 'Lokaltog/vim-easymotion'
"Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'haya14busa/incsearch.vim'
Plug 'sjl/gundo.vim'
"Plug 'lervag/vimtex'
"Plug 'mhinz/vim-startify'
"Plug 'vim-airline/vim-airline'
"Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'

call plug#end()

"--------------------------- Standard settings ---------------------------

"Search
set hlsearch   " highlight searches
set incsearch  " show incremental results while typing
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

set hidden
set undofile

set tabstop=2    " size of a hard tabstop
set expandtab    " Insert spaces instead of tab characters when tab is pressed
set shiftwidth=2 " size of an 'indent'

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline

set number
set confirm     " Save prompt
set cmdheight=2 " Set the command window height to 2 lines
set mouse=a     " Enable use of the mouse for all modes

let g:is_posix=1

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

"set background=dark
"set termguicolors

"--------------------------- Plugin options ---------------------------

let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"
map <leader>Ue :UltiSnipsEdit<cr>

"--------------------------- Autocommands ---------------------------

"Source .vimrc on write
augroup reload_vimrc
  autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"Save folds
" au BufWinLeave ?* mkview
" au BufWinEnter ?* silent loadview

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
