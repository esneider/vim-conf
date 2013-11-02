"""""""""
" Plugins {{{
"""""""""

" Necessary for lots of cool vim things
set nocompatible

" Required for vundle
filetype on
filetype off

" Call vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Manage plugins (github repos)
Bundle 'gmarik/vundle'

" Components
  """"""""""

" File explorer (,e)
Bundle 'scrooloose/nerdtree'

" Make NERDTree more awesome
Bundle 'jistr/vim-nerdtree-tabs'

" Show undo tree (,u)
Bundle 'sjl/gundo.vim'

" Show file tags list like variables, etc. (,b)
Bundle 'majutsushi/tagbar'

" Pretty status bar
Bundle 'bling/vim-airline'

" Fuzzy file finder (,o)
Bundle 'kien/ctrlp.vim'

" Fuzzy function/method finder (,m ,M)
Bundle 'tacahiroy/ctrlp-funky'

" Vim recipe finder (,r)
Bundle 'esneider/ctrlp-recipes.vim'

" Find in file with preview (,f ,F)
Bundle 'gcmt/psearch.vim'

" Commands
  """"""""

" Add surround modifier to vim (s)
Bundle 'tpope/vim-surround'

" Support repeat of surround actions
Bundle 'tpope/vim-repeat'

" % matches complex opening/closing entities
Bundle 'tsaleh/vim-matchit'

" Toggle comments (//)
Bundle 'tomtom/tcomment_vim'

" Automatic completion (select with tab)
Bundle 'Shougo/neocomplcache'

" Select regions in visual mode (+ and _)
Bundle 'terryma/vim-expand-region'

" Multiple cursors (next: Ctrl-P, prev: Ctrl-N, skip: Ctrl-X)
Bundle 'terryma/vim-multiple-cursors'

" Window resizing (,w)
Bundle 'jimsei/winresizer'

" Enable Alt key mappings
Bundle 'esneider/waltz.vim'

" Location and quickfix toggle (,l ,q)
Bundle 'milkypostman/vim-togglelist'

" External tools
  """"""""""""""

" Syntax checker (,s)
Bundle 'scrooloose/syntastic'

" Ack search (,a ,A)
Bundle 'mileszs/ack.vim'

" Git utils (,g + [c]ommit git[h]ub [m]ove [r]emove [s]tatus)
Bundle 'tpope/vim-fugitive'

" Show repo diff signs (,d)
Bundle 'mhinz/vim-signify'

" Language specific
  """""""""""""""""

" Clang completion for C and C++
Bundle 'Rip-Rip/clang_complete'

" Switch between source and header file (,h)
Bundle 'derekwyatt/vim-fswitch'

" Python goodies
" Bundle 'klen/python-mode'

" HTML5 syntax
Bundle 'othree/html5.vim'

" Latex compilation (,x)
Bundle 'TeX-PDF'

" CoffeeScript stuff
Bundle 'kchmck/vim-coffee-script'

" Colors
  """"""

" Colorschemes
Bundle 'flazz/vim-colorschemes'

" Function and namespace highlighting
Bundle 'esneider/simlight.vim'

" }}}

"""""""""""""""
" Auto commands {{{
"""""""""""""""

" Remove any trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Highlight first word after column 79
autocmd BufWinEnter * let w:m2 = matchadd('CursorLine', '\%80v\s*\zs\S\+', -1)

" Restore cursor position to where it was before closing
autocmd BufReadPost * if line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Check for file changes after 'updatetime' milliseconds of cursor hold
autocmd CursorHold * silent! checktime

" Focus NERDTree when opening vim in a folder
autocmd VimEnter * if isdirectory(expand('<amatch>')) | NERDTreeFocus | endif

" }}}

"""""""""""""""""""
" Filetype commands {{{
"""""""""""""""""""

" Ruby filetype detection
autocmd BufRead,BufNewFile Gemfile,Capfile,config.ru setfiletype ruby

" Markdown filetype detection
autocmd BufRead,BufNewFile *.md setfiletype markdown

" Markdown filetype detection
autocmd BufRead,BufNewFile *.json setfiletype javascript

" Use 2 spaces for indent in ruby, and allow !, ? in keywords
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 iskeyword+=!,?

" Use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Spell check in commits, markdown and text files
autocmd FileType gitcommit,svn,asciidoc,markdown setlocal spell

" }}}

""""""""""""""""
" General config {{{
""""""""""""""""

" Enable file type specific behaviour
filetype plugin indent on

" Use utf8
set encoding=utf-8

" Automatically read a file when it is changed from the outside
set autoread

" Automatically cd into the file's directory
set autochdir

" Don't redraw while executing macros
set lazyredraw

" Entries of the commands history
set history=1000

" Entries of the undo list
set undolevels=1000

" Prevent some security exploits
set modelines=0

" Disable fucking bell
set vb t_vb=

" Fold text when markers {{{ and }}} are found
set foldmethod=marker

" Update after 1 second of no activity (check for external file change, etc.)
set updatetime=1000

" Don't bother with swap files
set noswapfile

" Keep a persistent undo backup file
if has('persistent_undo')
    set undofile undodir=~/.vim/.undo//,~/tmp//,/tmp//
endif

" Ctags index directories
set tags=.git/tags;$HOME,.svn/tags;$HOME,tags;$HOME

" Ignore whitespace in diff mode
set diffopt+=iwhite

" }}}

""""""""""""""""""""""""""""
" Complete and search config {{{
""""""""""""""""""""""""""""

" Command line completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn,.git,*.o,*~,*.swp,*.pyc,*.class,*.dSYM

" Tab completion stuff
set completeopt=longest,menuone

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
set grepprg=grep\ -nH\ $*\ /dev/null

" Syntax completion by highlight rules for unsupported filetypes
set omnifunc=syntaxcomplete#Complete

" }}}

""""""""""""""
" Input config {{{
""""""""""""""

" Enable auto indenting on new lines (and be smart on newlines)
set autoindent smartindent copyindent

" Use spaces instead of tabs (and be smart on newlines)
set expandtab smarttab

" Tab equals 4 spaces
set shiftwidth=4 softtabstop=4 tabstop=4

" Make backspace work like it should
set backspace=2

" Enable mouse support in console
set mouse=a

" Don’t reset cursor to start of line when moving around
set nostartofline

" Shift plus movement keys changes selection
set keymodel=startsel,stopsel

" Allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,],h,l

" When at 3 spaces, and hit > ... go to 4, not 7
set shiftround

" Allow the cursor one beyond last character and everywhere in V-block mode
set virtualedit=onemore,block

" Faster commands
set ttimeout ttimeoutlen=50

" Don't resize all remaining splits when opening/closing a split
set noequalalways

" Put new vertical splits to the right/below of the current one
set splitright splitbelow

" Display as much as possible of a window's last line
set display+=lastline

" Use only one space after '.' when joining lines, instead of two
set nojoinspaces

" Handle comments when joining lines
if v:version > 703 || (v:version == 703 && has('patch541'))
    set formatoptions+=j
endif

" Use system clipboard as default register
set clipboard=unnamed,unnamedplus

" Instead of failing after a missing !, ask what to do
set confirm

" Ctrl-{A,X} work on dec, hex, and chars (not octal)
set nrformats=alpha,hex

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

" Show incomplete commands while you are typing them
set showcmd

" Have 5 lines ahead of the cursor in screen whenever possible
set scrolloff=5

" Try to change the terminal title
set title

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

" Use a dark background
set background=dark

" Set color scheme
silent! colorscheme kellys

" Don't try to highlight lines longer than 500 characters
set synmaxcol=500

" Enable text concealment (mainly for latex)
set conceallevel=2

" }}}

""""""""""""""
" Highlighting {{{
""""""""""""""

" Highlight functions and namespaces (simlight plugin)
highlight Function  guifg=#afdfdf ctermfg=152
highlight Namespace guifg=#a8a8a8 ctermfg=248

" Color notifications
highlight NotifyGreen  gui=bold guifg=#8dfa81 cterm=bold ctermfg=119
highlight NotifyRed    gui=bold guifg=#e47574 cterm=bold ctermfg=167
highlight NotifyYellow gui=bold guifg=#fffb87 cterm=bold ctermfg=227

" Hide tildes (~) in place of line numbers after EOF
silent! highlight NonText ctermfg=bg guifg=bg

" Highlight gutter diff signs (signify plugin)
highlight link SignifySignAdd    NotifyGreen
highlight link SignifySignDelete NotifyRed
highlight link SignifySignChange NotifyYellow

" Highlight gutter compilation errors (syntastic plugin)
highlight link SyntasticErrorSign        NotifyRed
highlight link SyntasticWarningSign      NotifyYellow
highlight link SyntasticStyleErrorSign   NotifyRed
highlight link SyntasticStyleWarningSign NotifyYellow

" Highlight diff conflict markers
match Todo '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

""""""""""""""
" Key mappings {{{
""""""""""""""

" Map backspace key to dismiss search highlighting
nnoremap <silent> <BS> :nohlsearch<CR>

" Turn off Vim’s regex characters and make searches use normal regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Disable Ex mode and use Q for formatting the current paragraph (or selection)
vnoremap Q gq
nnoremap Q gqap

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <C-\><C-o>gk
inoremap <silent> <Down> <C-\><C-o>gj

" Toggle folds with space
nnoremap <Space> za

" Center on the matching line when moving through search results
noremap N Nzz
noremap n nzz

" Remap jj to escape in insert mode
inoremap jj <Esc>

" Make Y consistent with C and D
nnoremap Y y$

" Repeat the last substitution
nnoremap <silent> & :&&<CR>
xnoremap <silent> & :&&<CR>

" Toggle comments (tComment plugin)
nnoremap // :let w:tcommentPos = getpos(".")<CR>:set opfunc=tcomment#OperatorLine<CR>g@$
vnoremap // :TCommentMaybeInline<CR>

" Remain in visual mode after '<' or '>'
vnoremap < <gv
vnoremap > >gv

" Auto complete next/prev with <Tab>/<S-Tab>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> `       pumvisible() ? "\<C-e>" : "`"

" Don't yank (to the default register) when pasting in visual mode
vnoremap p "_dP
vnoremap P "_dP

" Make * and # work with visual selection
vnoremap <silent> * yq/p<CR>
vnoremap <silent> # yq?p<CR>

" New tab (Ctrl-T)
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <C-\><C-o>:tabnew<CR>

" Move to and from tag definition with Ctrl-Shift-{Right,Left}
nnoremap <silent> <C-S-Right> g<C-]>
nnoremap <silent> <C-S-Left> <C-T>

" Move through windows with Alt-{Up,Right,Down,Left}
nnoremap <silent> <Plug><A-Up> :wincmd k<CR>
inoremap <silent> <Plug><A-Up> <C-\><C-o>:wincmd k<CR>
nnoremap <silent> <Plug><A-Down> :wincmd j<CR>
inoremap <silent> <Plug><A-Down> <C-\><C-o>:wincmd j<CR>
nnoremap <silent> <Plug><A-Left> :wincmd h<CR>
inoremap <silent> <Plug><A-Left> <C-\><C-o>:wincmd h<CR>
nnoremap <silent> <Plug><A-Right> :wincmd l<CR>
inoremap <silent> <Plug><A-Right> <C-\><C-o>:wincmd l<CR>

" Move through tabs with Alt-Shift-{Right,Left}
nnoremap <silent> <Plug><A-S-Right> :tabnext<CR>
inoremap <silent> <Plug><A-S-Right> <C-\><C-o>:tabnext<CR>
nnoremap <silent> <Plug><A-S-Left> :tabprevious<CR>
inoremap <silent> <Plug><A-S-Left> <C-\><C-o>:tabprevious<CR>

" Make ' jump to saved line & column rather than just line
nnoremap ' `
nnoremap ` '

" disable the MiddleMouse button
nnoremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

" }}}

""""""""""""""""""
" Command mappings {{{
""""""""""""""""""

" Some typo corrections
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>

" Save file with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Ctrl-A to go to the start of line
cnoremap <C-A> <Home>

" }}}

"""""""""""""""""
" Leader mappings {{{
"""""""""""""""""

" Change mapleader
let mapleader=","

" Find in files, with the [A]ck plugin
nnoremap <Leader>a :Ack!<Space>""<Left>

" Find in files the word under the cursor, with the [A]ck plugin
nnoremap <Leader>A :Ack!<Space>"<C-R><C-W>"<CR>

" Open the Tag[b]ar Plugin
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" Jump to next diff [c]onflict marker
nnoremap <silent> <Leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" Toggle repo [d]iff signs
nnoremap <silent> <Leader>d :SignifyToggle<CR>

" Toggle the file [e]xplorer
nnoremap <silent> <Leader>e :NERDTreeTabsToggle<CR>

" [F]ind in current file
nnoremap <silent> <Leader>f :PSearch<CR>

" [F]ind in current file the word under the cursor
nnoremap <silent> <Leader>F :PSearchw<CR>

" [G]it [c]ommit
nnoremap <silent> <Leader>gc :Gcommit -a<CR>

" [G]it command
nnoremap <Leader>gg :Git<Space>

" Open file in [g]it[h]ub
nnoremap <silent> <Leader>gh :Gbrowse<CR>

" [G]it [m]ove
nnoremap <Leader>gm :Gmove<Space>

" [G]it [r]emove
nnoremap <silent> <Leader>gr :Gremove<CR>

" [G]it [s]tatus
nnoremap <silent> <Leader>gs :Gstatus<CR>

" Switch between source and [h]eader file
nnoremap <silent> <Leader>h :FSHere<CR>

" <Leader>l Toggles the [l]ocation-list

" Open the CtrlP-Funky extension ([m]ethod)
nnoremap <silent> <Leader>m :CtrlPFunky<CR>

" Open the CtrlP-Funky extension with the word under the cursor ([m]ethod)
nnoremap <silent> <Leader>M :CtrlPFunky <C-R><C-W><CR>

" <Leader>o [O]pens files

" Toggle s[p]ell checking
nnoremap <silent> <Leader>p :setlocal spell!<CR>

" <Leader>q Toggles the [q]uickfix-list

nnoremap <silent> <Leader>r :CtrlPRecipes<CR>

" Check [s]yntax
nnoremap <silent> <Leader>s :w<CR>:SyntasticCheck<CR>

" Open the CtrlP-[T]ag extension
nnoremap <silent> <Leader>t :CtrlPTag<CR>

" Open the G[u]ndo Plugin
nnoremap <silent> <Leader>u :GundoToggle<CR>

" Edit [v]imrc in a new tab
nnoremap <silent> <Leader>v :tabnew<CR>:edit $MYVIMRC<CR>

" <Leader>w Opens the [W]inResizer plugin

" Build and view a late[x] file
nnoremap <silent> <Leader>x :BuildAndViewTexPdf<CR>:redraw!<CR>

" }}}

"""""""""""""""
" Plugin config {{{
"""""""""""""""

" NERDTree plugin configuration
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.svn', '\.git', '\.o$', '\~$', '\.swp$', '\.pyc$', '\.class$', '\.dSYM$']
let NERDTreeHijackNetrw = 0

" NERDTreeTabs plugin configuration
let g:nerdtree_tabs_open_on_console_startup = 1

" Disable netrw plugin
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1

" Taglist plugin configuration
let g:tagbar_compact = 1
let g:tagbar_width = 30
let g:tagbar_usearrows = 1
let g:tagbar_sort = 0

" Gundo plugin configuration
let g:gundo_width = 30
let g:gundo_preview_height = 15
let g:gundo_right = 1

" Syntastic plugin configuration
let g:syntastic_loc_list_height = 5
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = {'mode': 'passive'}

" Airline plugin configuration
let g:airline_symbols = {}
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_theme = 'powerlineish'

" tComment plugin configuration
let g:tcommentMaps = 0

" CtrlP plugin configuration
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_max_height = 15
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'funky']

" Doxygen syntax configuration (javadoc highlighting for C, C++, C# files)
let g:load_doxygen_syntax = 1
let doxygen_javadoc_autobrief = 0

" Tex syntax configuration
let g:tex_flavor = 'latex'
let g:tex_conceal = 'adgm'

" TeX-PDF plugin configuration
let g:tex_pdf_map_keys = 0

" PSearch plugin configuration
let g:pse_max_height = 20

" SwapWindows function
let g:windowToSwap = -1

" Ack plugin configuration
let g:ackprg = "~/.vim/.extra/ack.pl -H --nocolor --nogroup --column"

" NeoComplCache plugin configuration
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_wildcard = 0
let g:neocomplcache_enable_insert_char_pre = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_max_list = 10
let g:neocomplcache_force_omni_patterns = {}
let g:neocomplcache_force_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.python = ''
let g:neocomplcache_force_overwrite_completefunc = 1

" Clang_complete plugin configuration
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
let g:clang_jumpto_back_key = '<Plug>'

" Signify plugin configuration
let g:signify_update_on_bufenter = 0
let g:signify_disable_by_default = 1
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_change = '~'

" WinResizer plugin configuration
let g:winresizer_start_key = '<Leader>w'
let g:winresizer_keycode_left  = "\<Left>"
let g:winresizer_keycode_down  = "\<Down>"
let g:winresizer_keycode_up    = "\<Up>"
let g:winresizer_keycode_right = "\<Right>"

" }}}

"""""""""""
" Temporary {{{
"""""""""""

let g:colorscheme_paths = [
\ 'busierbee', 'bvemu', 'candyman', 'devbox-dark-256', 'hornet', 'jellybeans',
\ 'kellys', 'kolor', 'molokai', 'mustang', 'obsidian', 'smyck', 'symfony',
\ 'up', 'wombat256', 'wombat256mod', 'xoria256'
\ ]

let g:colorscheme_name = match(g:colorscheme_paths, 'kellys')

function! Colors(num)
    let g:colorscheme_name = (g:colorscheme_name + a:num) % len(g:colorscheme_paths)
    set t_Co=256
    set background=dark
    execute 'silent! colorscheme ' . g:colorscheme_paths[g:colorscheme_name]
    silent! highlight NonText ctermfg=bg ctermbg=bg guifg=bg
    silent! highlight CursorLine term=NONE cterm=NONE ctermfg=NONE guifg=NONE
endf

nnoremap <silent> <Leader>, :call Colors(+1)<CR>
nnoremap <silent> <Leader>. :call Colors(-1)<CR>
nnoremap <silent> <Leader>/ :call remove(g:colorscheme_paths, g:colorscheme_name)<CR>:call Colors(0)<CR>

" }}}
