"neovim config of Stephen Gates
"
"--------------------------- TODO list ---------------------------
" Auto-resource init.vim -- This is done? 2018-08-13
" Find a better mapping for expandUltiSnips
" insert mode mappings, like to get some more Mac/Emacs bindings
" <leader>Tab is open as is m<tab> and <leader><leader>!!!
" Open gui item in terminal vim instance
" Fix coloration of easy-motion hints
" Airline theme & Git integration
" Get themes to work properly in VIM
" Change themes with a mapping

"--------------------------- Package manager ---------------------------

call plug#begin()

Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'haya14busa/incsearch.vim'
Plug 'simnalamburt/vim-mundo' 
"Plug 'lervag/vimtex'
" Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Newcomer TODO evaluate
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale' "Newcomer TODO evaluate
Plug 'NLKNguyen/papercolor-theme'

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

" Wrap settings
set wrap lbr

let g:is_posix=1

"--------------------------- Mappings ---------------------------

"Return to normal mode
imap fd <ESC>
vmap fd <ESC>

let mapleader = "\<space>"

"Temporary mapping to edit .vimrc
map <leader>fed :e $MYVIMRC<cr>
" map y to act like d and c, i.e. to yank until EOL
map Y y$

" Avoid duplicate functionality/make behave like atom
nmap cc ciw

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
let g:mundo_prefer_python3 = 1
nnoremap <leader>u :MundoToggle<CR>

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

" Terminal mode mapping
:tnoremap fd <C-\><C-n>

" Goyo ("Distraction-free mode")
nmap <leader><CR> :Goyo<CR>

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

" nmap <leader>Tn ':set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>'

"--------------------------- Themes ---------------------------

colorscheme PaperColor
set background=dark



"--------------------------- Plugin options ---------------------------

let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir = "~/.config/nvim/plugged/ultisnips/snippets"
map <leader>Ue :UltiSnipsEdit<cr>

let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


"--------------------------- Autocommands ---------------------------

"Source .vimrc on write
augroup reload_vimrc
  autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC
augroup END

"Save folds
" au BufWinLeave ?* mkview
" au BufWinEnter ?* silent loadview

"Make :q quit in Goyo
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

"Start terminal in insert mode
autocmd BufEnter term://* startinsert

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
