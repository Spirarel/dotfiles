"--------------------------- TODO list ---------------------------
" Set up is.vim
" Figure out visual-multi
" vscode integration
"
" Find a better mapping for expandUltiSnips
" insert mode mappings, like to get some more Mac/Emacs bindings
" <leader>Tab is unmapped as is m<tab> and <leader><leader>!!!
" Open gui item in terminal vim instance
" Airline theme & Git integration
" Get themes to work properly in VIM
" Change themes with a mapping

"--------------------------- Package manager ---------------------------

call plug#begin()

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'simnalamburt/vim-mundo' 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Newcomer TODO evaluate
Plug 'sheerun/vim-polyglot'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'haya14busa/is.vim'

" Plug 'liuchengxu/vim-which-key'

call plug#end()

"--------------------------- Standard settings ---------------------------

"Search
set nohlsearch "hlsearch   " highlight searches
set incsearch  " show incremental results while typing
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

set hidden
set undofile

set tabstop=2    " size of a hard tabstop
set expandtab    " Insert spaces instead of tab characters when tab is pressed
set shiftwidth=4 " size of an 'indent'

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

"Get to vimrc quickly (from spacemacs)
map <leader>fed :e $MYVIMRC<cr>

" map y to act like d and c, i.e. to yank until EOL
map Y y$

" Avoid duplicate functionality/make behave like atom
nmap cc ciw

"Toggle spell check on and off
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us "Spell check language is English(US)

"Leap
lua require('leap')
lua vim.keymap.set({'n', 'x', 'o'}, 'm', '<Plug>(leap-forward-to)')
lua vim.keymap.set({'n', 'x', 'o'}, 'M', '<Plug>(leap-backward-to)')
lua vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-cross-window)')

"Flit
lua <<EOF
require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  multiline = true,
  -- Liku `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}
EOF

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

" Set no wrap
nmap <leader>nw :set nowrap!<CR>

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

" colorscheme PaperColor
" set background=dark



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


" :set number relativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" :augroup END

let g:python3_host_prog='/Users/stephen/.pyenv/shims/python3'

"--------------------------- Testing ---------------------------

