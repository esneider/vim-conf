" WARNING:
"   * The Tagbar plugin needs 'exuberant ctags' to work.
"   * The Powerline plugin needs to have a patched font to be pretty.
"     You can install one of the fonts in '~/.vim/bundle/powerline-fonts'
"     and set your terminal to use it


"""""""""""""""""
" Vundle commands {{{
"""""""""""""""""


" Necesary for lots of cool vim things
set nocompatible

" Required for vundle
filetype on
filetype off

" Avoid SSL certificate problems
let $GIT_SSL_NO_VERIFY = 'true'

" Call vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Manage plugins (github repos)
Bundle 'gmarik/vundle'

" Add surround modifier to vim (s)
Bundle 'tpope/vim-surround'

" Suport repeat of surround actions
Bundle 'tpope/vim-repeat'

" % matches complex opening/closing entities
Bundle 'tsaleh/vim-matchit'

" Toggle comments (//)
Bundle 'tomtom/tcomment_vim'

" File browser (,t)
Bundle 'scrooloose/nerdtree'

" Syntax checker (,s)
Bundle 'scrooloose/syntastic'

" Tab completion (tab)
Bundle 'ervandew/supertab'

" Show undo tree (,g)
Bundle 'sjl/gundo.vim'

" Run console commands (!command)
Bundle 'sjl/clam.vim'

" Show file tags list like variabes, etc (,l)
Bundle 'majutsushi/tagbar'

" Select noun movements with help (,,noun)
Bundle 'Lokaltog/vim-easymotion'

" Pretty status bar
Bundle 'Lokaltog/vim-powerline'

" Patched fonts for powerline
Bundle 'esneider/powerline-fonts'

" Colorscheme
Bundle 'tomasr/molokai'

" Colorscheme
Bundle 'Lokaltog/vim-distinguished'

" Colorscheme
Bundle 'nanotech/jellybeans.vim'

" Colorscheme
Bundle 'vim-scripts/kellys'

" Toggle window zoom (,z)
Bundle 'vim-scripts/ZoomWin'

" Fuzzy file finder (,o)
Bundle 'kien/ctrlp.vim'

" Rename a file (:rename)
Bundle 'danro/rename.vim'

" More interactive find (,f)
Bundle 'gcmt/psearch.vim'

" Switch between source and header file (,h)
Bundle 'derekwyatt/vim-fswitch'

" }}}

"""""""""""""""
" Auto commands {{{
"""""""""""""""


" Automatically cd into the file's directory
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Highlight characters after column 80
autocmd BufWinEnter * let w:m2=matchadd('CursorLine', '\%>80v.\+', -1)

" Restore cursor position to where it was before closing
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Open NERDTree plugin and unfocus it
autocmd VimEnter * silent! NERDTree | wincmd p

" Make Syntastic plugin passive
autocmd VimEnter * silent! SyntasticToggleMode

" Use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Setup syntax completion by highligh rules for unsupported filetypes
autocmd Filetype *
  \ if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

" Supertab plugin completion style
autocmd FileType * silent! call SuperTabChain(&omnifunc, '<c-p>')

" }}}

""""""""""""""""
" General config {{{
""""""""""""""""

" Enable file type specific behaviour
filetype plugin indent on

" Use utf8
set encoding=utf-8

" When I close a tab, remove the buffer
set nohidden

" Automatically read a file when it is changed from the outside
set autoread

" Automatic EOL type selection
" set fileformats='unix,dos,mac'

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Entries of the commands history
set history=1000

" Entries of the undo list
set undolevels=1000

" Keep a persistent undo backup file
if v:version >= 730
    set undofile
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif

" Directory for swap files (avoids adding them to your repo by mistake)
set directory=~/.vim/.tmp,~/tmp,/tmp

" Prevent some security exploits
set modelines=0

" Disable fucking bell
set vb t_vb=

" Faster commands
set ttimeout
set ttimeoutlen=50

" Fold text when markers {{{ and }}} are found
set foldmethod=marker

" }}}

""""""""""""""""""""""""""""
" Complete and search config {{{
""""""""""""""""""""""""""""


" Comand line completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore=*.swp,*.bak,*.pyc,*.class

" Tab completion stuff
set completeopt=longest,menuone,preview

" Ignore case when searching
set ignorecase

" Unless upper case is used
set smartcase

" Use incremental searching (search while typing)
set incsearch

" Highlight things that we find with the search
set hlsearch

" search/replace globally (on a line) by default
set gdefault

" Set flags for grep command
set grepprg=grep\ -nHE\ $*\ /dev/null

" }}}

""""""""""""""
" Input config {{{
""""""""""""""

" Enable autoindenting on new lines
set autoindent

" Copy the indent structure when autoindenting
set copyindent

" Use spaces instead of tabs (and be smart on newlines)
set expandtab
set smarttab

" Tab equals 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Make backspace work like it should
set backspace=2

" Enable mouse support in console
set mouse=a

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Shift plus movement keys changes selection
set keymodel=startsel,stopsel

" Allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,],h,l

" When at 3 spaces, and hit > ... go to 4, not 7
set shiftround

" Allowe the cursor one beyond last character and everywhere in V-block mode
set virtualedit=onemore,block

" Put new vertical splits to the right of the current one
set splitright

" Put new horizontal splits below the current one
set splitbelow

" }}}

""""""""""""""
" Style config {{{
""""""""""""""


" Enable syntax highlighting
syntax enable

" Show line numbers
set number

" Show status line
set laststatus=2

" This shows what you are typing as a command
set showcmd

" Have 5 lines ahead of the cursor in screen whenever possible
set scrolloff=5

" Highlight matching parent
highlight MatchParen ctermbg=4

" Highlight diff conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Highlight the line that the cursor is on
set cursorline

" Set font for MacVim
if has("gui_macvim")
  set guifont=Menlo:h15
end

" Force the tty to use 256 colors
if !has("gui_running")
  set t_Co=256
endif

" Dark background
set background=dark

" Set color scheme
silent! colorscheme kellys

" Don't try to highlight lines longer than 500 characters
set synmaxcol=500

" }}}

""""""""""""""
" Key mappings {{{
""""""""""""""


" Map backspace key to dismiss search highlightedness
nnoremap <BS> :noh<CR>

" Type ; instead of : to begin a command faster
" nnoremap ; :

" Turn off Vim’s regex characters and makes searches use normal regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Disable Ex mode
noremap Q <Nop>

" Next tab (Ctrl-Shift-Right)
nnoremap <silent> <C-S-Right> :tabnext<CR>
inoremap <silent> <C-S-Right> <Esc>:tabnext<CR>

" Previous tab (Ctrl-Shift-Left)
nnoremap <silent> <C-S-Left> :tabprevious<CR>
inoremap <silent> <C-S-Left> <Esc>:tabprevious<CR>

" New tab (Ctrl-T)
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <Esc>:tabnew<CR>

" Move through splits with Alt-Shift-{Up,Right,Down,Left}
" For Mac
nnoremap <silent> <T-S-Up> :wincmd k<CR>
nnoremap <silent> <T-S-Down> :wincmd j<CR>
nnoremap <silent> <T-S-Left> :wincmd h<CR>
nnoremap <silent> <T-S-Right> :wincmd l<CR>
inoremap <silent> <T-S-Up> <Esc>:wincmd k<CR>
inoremap <silent> <T-S-Down> <Esc>:wincmd j<CR>
inoremap <silent> <T-S-Left> <Esc>:wincmd h<CR>
inoremap <silent> <T-S-Right> <Esc>:wincmd l<CR>
" For Linux
nnoremap <silent> <M-S-Up> :wincmd k<CR>
nnoremap <silent> <M-S-Down> :wincmd j<CR>
nnoremap <silent> <M-S-Left> :wincmd h<CR>
nnoremap <silent> <M-S-Right> :wincmd l<CR>
inoremap <silent> <M-S-Up> <Esc>:wincmd k<CR>
inoremap <silent> <M-S-Down> <Esc>:wincmd j<CR>
inoremap <silent> <M-S-Left> <Esc>:wincmd h<CR>
inoremap <silent> <M-S-Right> <Esc>:wincmd l<CR>

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <C-o>gk
inoremap <silent> <Down> <C-o>gj

" Toggle folds with space
nnoremap <space> za

" Center on the matching line when moving through search results
noremap N Nzz
noremap n nzz

" Remap jj to escape in insert mode
inoremap jj <Esc>

" Make Y consistent with C and D
nnoremap Y y$

" Repeat the last substitution
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Run console command (Clam plugin)
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Toggle comments (tComment plugin)
nmap // gcc<Esc>
vmap // gc<Esc>

" Remain in visual mode after '<' or '>'
vnoremap < <gv
vnoremap > >gv

" }}}

""""""""""""""""""
" Command mappings {{{
""""""""""""""""""


" Some typo corrections
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Save file with sudo
cnoremap w!! w !sudo tee % >/dev/null

" }}}

"""""""""""""""""
" Leader mappings {{{
"""""""""""""""""


" Change mapleader
let mapleader=","

" Mark window for swap
nnoremap <silent> <leader>mw :call MarkWindowSwap()<CR>

" Swap current window with the one previously marked
nnoremap <silent> <leader>sw :call DoWindowSwap()<CR>

" Open the NERDTree Plugin
nnoremap <silent> <Leader>t :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" Open the Tagbar Plugin
nnoremap <silent> <Leader>l :TagbarToggle<CR>

" Open the Gundo Plugin
nnoremap <silent> <Leader>g :GundoToggle<CR>

" Check syntax with Syntastic plugin
nnoremap <silent> <Leader>s :w<CR>:SyntasticCheck<CR>

" Open the Syntastic plugin errors list
nnoremap <silent> <Leader>e :Errors<CR>

" Toggle full screen with ZoomWin plugin
nnoremap <silent> <Leader>z :ZoomWin<CR>

" Edit vimrc in a new tab
nnoremap <silent> <Leader>v :tabnew<CR>:e ~/.vimrc<CR>

" Jump to next diff conflict marker
nnoremap <silent> <Leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" Open the PSearch plugin
nnoremap <silent> <Leader>f :PSearch<CR>

" Switch between source and header file with FSwitch plugin
nnoremap <silent> <Leader>h :FSHere<CR>

" }}}

""""""""""""""""
" Plugins config {{{
""""""""""""""""


" NERDTree plugin configuration
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

" Taglist plugin configuration
let g:tagbar_compact = 1
let g:tagbar_width = 30
let g:tagbar_usearrows = 1
let g:tagbar_sort = 0

" Gundo plugin configuration
let g:gundo_width = 30
let g:gundo_preview_height = 15
let g:gundo_right = 1

" SuperTab plugin configuration
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Syntastic plugin configuration
let g:syntastic_loc_list_height = 5
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Powerline plugin configuration
let g:Powerline_symbols = 'fancy'

" CtrlP plugin configuration
let g:ctrlp_map = '<leader>o'
let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 40
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_max_height = 20
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_switch_buffer = 'e'

" Doxygen syntax configuration (javadoc highlighting for C, C++, C# files)
let g:load_doxygen_syntax = 1
let doxygen_javadoc_autobrief = 0

" Tex syntax configuration
let g:tex_flavor = 'latex'

" PSearch plugin configuration
let g:pse_max_height = 20

" }}}

"""""""""
" Helpers {{{
"""""""""


function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    let markedBuf = bufnr( "%" )
    exe 'hide buf' curBuf
    exe curNum . "wincmd w"
    exe 'hide buf' markedBuf
endfunction

" }}}

