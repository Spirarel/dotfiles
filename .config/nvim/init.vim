"--------------------------- TODO list ---------------------------
"
" Figure out visual-multi
" Set up is.vim
" Find a better mapping for expandUltiSnips
" insert mode mappings, like to get some more Mac/Emacs bindings
" <leader>Tab is unmapped as is m<tab> and <leader><leader>!!!
"
"--------------------------- Package manager ---------------------------

" Conditionally, lazy-load plugins
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()

Plug 'mg979/vim-visual-multi', Cond(!exists('g:vscode')) "Newcomer
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'   , Cond(!exists('g:vscode'))
Plug 'tpope/vim-repeat'
Plug 'simnalamburt/vim-mundo' , Cond(!exists('g:vscode'))
Plug 'SirVer/ultisnips'       , Cond(!exists('g:vscode')) "Snippet engine
Plug 'honza/vim-snippets'     , Cond(!exists('g:vscode')) "Common snippets
Plug 'junegunn/goyo.vim'      , Cond(!exists('g:vscode')) "Zen-mode
Plug 'Shougo/deoplete.nvim'   , Cond(!exists('g:vscode'), { 'do': ':UpdateRemotePlugins' }) "TODO migrate to ddc.vim?
Plug 'sheerun/vim-polyglot'   , Cond(!exists('g:vscode')) "Language packs
Plug 'ggandor/leap.nvim'      , "Super easy-motion
Plug 'ggandor/flit.nvim'      , "Super sneak
Plug 'haya14busa/is.vim'      , Cond(!exists('g:vscode'))
Plug 'gbprod/substitute.nvim'

" Plug 'liuchengxu/vim-which-key'

call plug#end()

"--------------------------- Standard settings ---------------------------
"Search
set incsearch  " show incremental results while typing
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

set hidden
set undofile

set tabstop=2    " size of a hard tabstop
set expandtab    " Insert spaces instead of tab characters when tab is pressed
set shiftwidth=4 " size of an 'indent'
set autoindent

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

set clipboard+=unnamedplus

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

"Tabular
let g:haskell_tabular = 1
vmap a=   :Tabularize /=<CR>
vmap a;   :Tabularize /::<CR>
vmap a-   :Tabularize /-><CR>
vmap a#   :Tabularize /#<CR>
vmap a"   :Tabularize /"<CR>
vmap a\   :Tabularize /\|<CR>
vmap <CR> :Tabularize /

"Gundo
let g:mundo_prefer_python3 = 1
nnoremap <leader>u :MundoToggle<CR>

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
au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC

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

:set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

lua << EOF
-- Leap
require('leap')
vim.keymap.set({'n', 'x', 'o'}, 'm', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'M', '<Plug>(leap-backward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'gm', '<Plug>(leap-cross-window)')

-- Flit
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
