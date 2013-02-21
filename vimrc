" WARNING:
"   * The Tagbar plugin needs `exuberant ctags' to work.
"   * The Powerline plugin needs to have a patched font to be pretty.
"     You can install one of the fonts in '~/.vim/bundle/powerline-fonts'


"""""""""""""""""
" Vundle commands
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

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/powerline-fonts'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/kellys'

" Syntax highlighting and indentation on
filetype plugin indent on
syntax enable
set autoindent


"""""""""""""""
" Auto commands
"""""""""""""""


" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Highlight characters after column 80
autocmd BufWinEnter * let w:m2=matchadd('CursorLine', '\%>80v.\+', -1)

" Restore cursor position to where it was before closing it
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Open NERDTree plugin and unfocus it
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Make Syntastic plugin passive
autocmd VimEnter * silent! SyntasticToggleMode

" Use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Configure omni completion
" set omnifunc=syntaxcomplete#Complete
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby       set omnifunc=rubycomplete#Complete
autocmd FileType c          set omnifunc=ccomplete#Complete


""""""""""""""""
" General config
""""""""""""""""


" This shows what you are typing as a command
set showcmd

" Fold text when markers {{{ and }}} are found
set foldmethod=marker

" Change mapleader
let mapleader=","

" Use spaces instead of tabs (and be smart on newlines)
set expandtab
set smarttab

" Tab equals 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Make backspace work like it should
set backspace=2

" Show line numbers
set number

" Ignore case when searching
set ignorecase

" Unless upper case is used
set smartcase

" Remap jj to escape in insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Use incremental searching (search while typing)
set incsearch

" Highlight things that we find with the search
set hlsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" When I close a tab, remove the buffer
set nohidden

" Set to auto read when a file is changed from the outside
set autoread

" Highlight matching parent
highlight MatchParen ctermbg=4

" Highlight the line that the cursor is on
set cursorline

" Have 5 lines ahead of the cursor in screen whenever possible
set scrolloff=5

" Disable fucking bell
set vb t_vb=

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Shift plus movement keys changes selection
set keymodel=startsel,stopsel

" Allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,],h,l

" Tab completion features
"  longest: inserts the longest common text
"  menuone: shows the menu even when there's just one match
"  preview: shows extra information of the selected option
set completeopt=longest,menuone,preview

" Put new splits to the right of the current one
set splitright

" When at 3 spaces, and I hit > ... go to 4, not 7
set shiftround

" Allow for cursor beyond last character
set virtualedit=onemore

" Entries of the commands history
set history=1000

" Tex flavor
let g:tex_flavor='latex'

" Real men use gcc
compiler gcc

" Set flags for grep command
set grepprg=grep\ -nHE\ $*\ /dev/null

" Use javadoc-like highlighting for C, C++, C# and IDL files
let g:load_doxygen_syntax=1

" If doxygen_javadoc_autobrief is 0, it doesn't highlight the text
" section, else it highlights everything until doxygen_end_punctuation is
" matched
let doxygen_javadoc_autobrief=0
let doxygen_end_punctuation='^$'

if has("gui_running")
    " Set font (possibly only works in macvim)
    set guifont=Menlo:h16
else
    " Force the tty to use 256 colors
    set t_Co=256
endif

" Set color scheme
silent! colorscheme kellys

" Status line setup (not necessary with Powerline plugin)
set laststatus=2


""""""""""""""
" Kay mappings
""""""""""""""


" Map backspace key to dismiss search highlightedness
nnoremap <BS> :noh<CR>

" Type ; instead of : to begin a command faster
nnoremap ; :

" Disable Ex mode
noremap Q <Nop>

" Next tab (Ctrl-Shift-Right)
nnoremap <silent> <C-S-Right> :tabnext<CR>
inoremap <silent> <C-S-Right> :tabnext<CR>

" Previous tab (Ctrl-Shift-Left)
nnoremap <silent> <C-S-Left> :tabprevious<CR>
inoremap <silent> <C-S-Left> :tabprevious<CR>

" New tab (Ctrl-T)
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> :tabnew<CR>

" Move through splits with Alt-Shift-{Up,Right,Down,Left}
nnoremap <silent> <T-S-Up> :wincmd k<CR>
nnoremap <silent> <T-S-Down> :wincmd j<CR>
nnoremap <silent> <T-S-Left> :wincmd h<CR>
nnoremap <silent> <T-S-Right> :wincmd l<CR>
inoremap <silent> <T-S-Up> <Esc>:wincmd k<CR>
inoremap <silent> <T-S-Down> <Esc>:wincmd j<CR>
inoremap <silent> <T-S-Left> <Esc>:wincmd h<CR>
inoremap <silent> <T-S-Right> <Esc>:wincmd l<CR>

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <C-o>gk
inoremap <silent> <Down> <C-o>gj

" Space will toggle folds
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in
noremap N Nzz
noremap n nzz


""""""""""""""""""
" Command mappings
""""""""""""""""""


" Some typo corrections
command! WQ wq
command! Wq wq
command! W w
command! Q q


"""""""""""""""""
" Leader mappings
"""""""""""""""""


" Swap buffers
nnoremap <silent> <leader>mw :call MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call DoWindowSwap()<CR>

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

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" TODO: NERDCommenter plugin shortcuts


""""""""""""""""
" Plugins config
""""""""""""""""


" NERDTree plugin configuration
let NERDTreeDirArrows=1
let NERDTreeWinSize=25
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

" Taglist plugin configuration
let g:tagbar_compact = 1
let g:tagbar_width = 30

" Gundo plugin configuration
let g:gundo_width = 30
let g:gundo_preview_height = 10
let g:gundo_right = 1

" SuperTab plugin configuration
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Syntastic plugin configuration
let g:syntastic_loc_list_height=5

" Powerline plugin configuration
let g:Powerline_symbols = 'fancy'


"""""""""
" Helpers
"""""""""


"{{{ Swap open buffers
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction
"}}}

