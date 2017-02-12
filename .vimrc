"vimrc of Stephen Gates

"todo
"include a shortcut to insert space in normal mode
"airline
"Fix coloration of easy-motion hints

"--- Package manager ---

set nocompatible "Basically always used
filetype off "Required off for vundle initialization

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'lervag/vimtex'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'crusoexia/vim-monokai'
Plugin 'sjl/gundo.vim'
"Plugin 'vim-airline/vim-airline'
Plugin 'haya14busa/incsearch.vim'

call vundle#end()            " required
filetype plugin indent on    " required

filetype indent plugin on "try to identity a file for auto-indenting and plugins
syntax on

"------------------------------------------------------------
" Vim with default settings does not allow easy switching between multiple
" files
" in the same editor window. Users can use multiple split windows or
" multiple
" tab pages to edit multiple files, but it is still best to enable an option
" to
" allow easier switching between files.

" One such option is the 'hidden' option, which allows you to re-use the
" same
" window and switch from an unsaved buffer without saving it first. Also
" allows
" you to keep an undo history for multiple files when re-using the same
" window
" in this way. Note that using persistent undo also lets you undo in
" multiple
" files even in the same window, but is less efficient and is actually
" designed
" for keeping undo history after closing Vim entirely. Vim will complain if
" you
"
" computer
" crashes.
"--- Search options ---

set hlsearch "highlight searches
set incsearch "show incremental results while typing

set hidden
set undofile
set wildmenu

set showcmd " Show partial commands in the last line of the screen

" size of a hard tabstop
set tabstop=2
" Insert spaces instead of tab characters when tab is pressed
set expandtab
" All indentation levels use 'shiftwidth' number of characters
set shiftwidth=4
" size of an 'indent'
set shiftwidth=2

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline

set ignorecase " Use case insensitive search, except when using capital letters
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
"
" " When opening a new line and no filetype-specific indenting is enabled,
" keep
" " the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
"
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
" set nostartofline
"
" Display the cursor position on the last line of the screen or in the
" status
" line of a window
set ruler
"
" Always display the status line, even if only one window is displayed
"set laststatus=2
"
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
"
" Use visual bell instead of beeping when doing something wrong
" set visualbell
"
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
" set t_vb=
"
" Enable use of the mouse for all modes
set mouse=a
"
" Set the command window height to 2 lines, to avoid many cases of having to
"press <Enter> to continue"
set cmdheight=2
"
" Display line numbers on the left
set number
"
" Quickly time out on keycodes, but never time out on mappings
" set notimeout ttimeout ttimeoutlen=200
"
" Use <F11> to toggle between 'paste' and 'nopaste'
" set pastetoggle=<F11>
"
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
"
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
"
" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
"nnoremap <C-L> :nohl<CR><C-L>

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

"Escape using escape
inoremap fd <ESC>
vnoremap fd <ESC>
"Toggle spell check on and off
nmap <silent> <leader>s :set spell!<CR>
"Spell check language is English(US)
set spelllang=en_us
"Mappings for easymotion to use fewer keystrokes
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
nnoremap <Space>u :GundoToggle<CR>

"Multiple-cursors THESE WILL NOT WORK UNTIL THE PACKAGE IS UPDATED
"let g:multi_cursor_quit_key='fd'
"let g:multi_cursor_insert_maps = {'f':1}
"------------------------------------------------------------
"Themes
let g:solarized_termcolors=256
"Solarized
"call togglebg#map("<F5>")
set background=light
colorscheme solarized
"colorscheme monokai
" change the default EasyMotion shading to something more readable with Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
"
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
