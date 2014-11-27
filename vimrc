"""""""""
" Plugins {{{
"""""""""

" Necessary for lots of cool vim things
set nocompatible

" Call vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Manage plugins (github repos)
Plugin 'gmarik/vundle'

" UI Components
  """""""""""""

" File explorer (,e)
Plugin 'scrooloose/nerdtree'

" Make NERDTree more awesome
Plugin 'jistr/vim-nerdtree-tabs'

" Show undo tree (,u)
Plugin 'sjl/gundo.vim'

" Show tags list (vars, funcs, etc) (,t)
Plugin 'majutsushi/tagbar'

" Fuzzy file finder (,o)
Plugin 'kien/ctrlp.vim'

" Fuzzy function/method finder (,m)
Plugin 'tacahiroy/ctrlp-funky'

" Vim recipe finder (,r)
Plugin 'esneider/vim-recipes'

" Commands
  """"""""

" Add surround modifier to vim (s noun)
Plugin 'tpope/vim-surround'

" Support repeating surround actions
Plugin 'tpope/vim-repeat'

" Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
Plugin 'tpope/vim-abolish'

" Toggle comments (,/)
Plugin 'tomtom/tcomment_vim'

" Automatic completion (select with tab)
Plugin 'Valloric/YouCompleteMe'

" Select regions in visual mode (+ and _)
Plugin 'terryma/vim-expand-region'

" Multiple cursors (next: Ctrl-N, prev: Ctrl-P, skip: Ctrl-X)
Plugin 'terryma/vim-multiple-cursors'

" Window resizing (,w)
Plugin 'jimsei/winresizer'

" Location and quickfix window toggle (,l and ,q)
Plugin 'milkypostman/vim-togglelist'

" Show N out of M in searches
Plugin 'vim-scripts/IndexedSearch'

" Incrementally highlight all pattern matches (/ and ?)
Plugin 'haya14busa/incsearch.vim'

" Cycle through the clipboard history after pasting (]p and [p)
Plugin 'maxbrunsfeld/vim-yankstack'

" Smart automatic removal of trailing whitespaces
Plugin 'esneider/vim-trailing'

" External tools
  """"""""""""""

" Syntax checker (,c)
Plugin 'scrooloose/syntastic'

" Ack search (,f and ,F)
Plugin 'mileszs/ack.vim'

" Git utils (,g + [c]ommit [d]iff git[h]ub [l]og [m]ove [p]ush [r]emove [s]tatus)
Plugin 'tpope/vim-fugitive'

" Show repo diff signs (,d)
Plugin 'mhinz/vim-signify'

" Show documentation (mac only) (,k)
Plugin 'rizzatti/dash.vim'

" Warn after 20 writes without commiting
Plugin 'esneider/YUNOcommit.vim'

" Language specific
  """""""""""""""""

" Switch between source and header file (,h)
Plugin 'derekwyatt/vim-fswitch'

" HTML5 syntax
Plugin 'othree/html5.vim'

" Better indentation and highlighting for JavaScript
Plugin 'pangloss/vim-javascript'

" Automatic completion for JavaScript
Plugin 'marijnh/tern_for_vim'

" Latex compilation (,x)
Plugin 'TeX-PDF'

" Markdown compilation
Plugin 'suan/vim-instant-markdown'

" Look and feel
  """""""""""""

" Pretty status bar
Plugin 'bling/vim-airline'

" Lots of colorschemes
Plugin 'flazz/vim-colorschemes'

" Function and namespace highlighting
Plugin 'esneider/vim-simlight'

" Plugin initialization
  """""""""""""""""""""

" Yankstack plugin configuration: must be before initialization
let g:yankstack_map_keys = 0

" Yankstack plugin initialization: must be before any mapping using y or p
silent! call yankstack#setup()

" }}}

"""""""""""""""
" Auto commands {{{
"""""""""""""""

" Group all autocmds
augroup vimrc
autocmd!

" Highlight first word after column 80
autocmd BufWinEnter * let w:m2 = matchadd('CursorLine', '\%81v\s*\zs\S\+', -1)

" Restore cursor position to where it was before closing
autocmd BufReadPost * silent! execute 'normal! g`"'

" Check for file changes after 'updatetime' milliseconds of cursor hold
autocmd CursorHold * silent! checktime

" Automatically cd into the current file's directory
autocmd BufEnter * silent! cd %:p:h

" Show search index
autocmd User IncSearchLeave ShowSearchIndex

" }}}

"""""""""""""""""""
" Filetype commands {{{
"""""""""""""""""""

" Ruby filetype detection
autocmd BufRead,BufNewFile Gemfile,Capfile,config.ru,Vagrantfile setfiletype ruby

" Markdown filetype detection
autocmd BufRead,BufNewFile *.md setfiletype markdown

" Json filetype detection
autocmd BufRead,BufNewFile *.json setfiletype javascript

" Use NASM as the default assembly syntax
autocmd BufRead,BufNewFile *.asm setfiletype nasm

" Use 2 spaces for indentation in ruby, and allow ! and ? in keywords
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 iskeyword+=!,?

" Use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Enable spell checking in commit, markdown and text files
autocmd FileType gitcommit,svn,asciidoc,markdown setlocal spell

" Use vim help for K in vimscript
autocmd FileType vim setlocal keywordprg=:help

" Disable automatic label dedenting
autocmd FileType cpp setlocal cinoptions+=L0

" All autocmds should be before this
augroup END

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

" Search/replace globally (on a line) by default
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
set autoindent cindent copyindent

" Use spaces instead of tabs (and be smart on newlines)
set expandtab smarttab

" Tab equals 4 spaces
set shiftwidth=4 softtabstop=4 tabstop=4

" Make backspace work like it should
set backspace=2

" Enable mouse support in console
set mouse=a

" Don't reset cursor to start of line when moving around
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

""""""""""""""""
" Display config {{{
""""""""""""""""

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
set icon title

" Indent wrapped lines correctly
if v:version > 704 || (v:version == 704  && has('patch338'))
    set breakindent
endif

" Highlight the line that the cursor is on
set cursorline

" Force 256 colors in terminal
set t_Co=256

" Disable everything in gvim
set guioptions=

" Set font in MacVim
if has('gui_macvim')
    set guifont=Menlo:h14
end

" Use a dark background
set background=dark

" Don't try to highlight lines longer than 500 characters
set synmaxcol=500

" Enable text concealment (mainly for latex)
set conceallevel=2

" }}}

""""""""""""""
" Highlighting {{{
""""""""""""""

" Set color scheme
silent! colorscheme kellys

" Highlight functions and namespaces (simlight plugin)
highlight Function  guifg=#afdfdf ctermfg=152
highlight Namespace guifg=#a8a8a8 ctermfg=248

" Color notifications
highlight NotifyGreen  gui=bold guifg=#8dfa81 cterm=bold ctermfg=119
highlight NotifyRed    gui=bold guifg=#e47574 cterm=bold ctermfg=167
highlight NotifyYellow gui=bold guifg=#fffb87 cterm=bold ctermfg=227

" Hide tildes (~) in place of line numbers after EOF
silent! highlight NonText   guifg=bg   guibg=bg
silent! highlight NonText ctermfg=bg ctermbg=bg

" Highlight gutter diff signs (signify plugin)
highlight link SignifySignAdd    NotifyGreen
highlight link SignifySignDelete NotifyRed
highlight link SignifySignChange NotifyYellow

" Highlight gutter compilation errors (syntastic plugin)
highlight link SyntasticErrorSign        NotifyRed
highlight link SyntasticWarningSign      NotifyYellow
highlight link SyntasticStyleErrorSign   NotifyRed
highlight link SyntasticStyleWarningSign NotifyYellow

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" }}}

""""""""""""""
" Key mappings {{{
""""""""""""""

" Map backspace key to dismiss search highlighting
nnoremap <silent> <BS> :nohlsearch<CR>

" Map tab key to jump to matching entity: (), [], {}, etc
nmap <silent> <Tab> %

" Disable Ex mode and use Q for formatting the current paragraph (or selection)
vnoremap <silent> Q gq
nnoremap <silent> Q gqap

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <C-\><C-o>gk
inoremap <silent> <Down> <C-\><C-o>gj

" Toggle folds with space
nnoremap <silent> <Space> za

" Remap jj to escape in insert mode
inoremap jj <Esc>

" Usual Home and End shortcuts
inoremap <C-A> <Home>
inoremap <C-E> <End>

" Make Y consistent with C and D
nnoremap <silent> Y y$

" Repeat the last substitution, using the same flags
nnoremap <silent> & :&&<CR>
xnoremap <silent> & :&&<CR>

" Remain in visual mode after '<' or '>'
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Don't yank when pasting in visual mode
vnoremap <silent> p "_dP
vnoremap <silent> P "_dP

" Make * and # work with visual selection
vnoremap <silent> * yq/i\V<Esc>p<CR>
vnoremap <silent> # yq?i\V<Esc>p<CR>

" Repeat last action for each line in the visual selection
vnoremap <silent> . :normal .<CR>

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open new tab with ctrl-t
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <C-\><C-o>:tabnew<CR>

" Move to next/previous tab with right/left arrows
nnoremap <silent> <Left> :tabprevious<CR>
nnoremap <silent> <Right> :tabnext<CR>

" Move to tag definition and back with down/up arrows
nnoremap <silent> <Up> <C-t>
nnoremap <silent> <Down> g<C-]>

" Move through splits with Ctrl-{hjkl}
nnoremap <silent> <C-h> :wincmd h<CR>
inoremap <silent> <C-h> <Esc>:wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
inoremap <silent> <C-j> <Esc>:wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
inoremap <silent> <C-k> <Esc>:wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
inoremap <silent> <C-l> <Esc>:wincmd l<CR>

" Make ' jump to saved line & column rather than just line
nnoremap ' `
nnoremap ` '

" Disable the MiddleMouse button
nnoremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

" Jump to next/previous diff marker (signify plugin)
nmap <silent> ]d <plug>(signify-next-hunk)
nmap <silent> [d <plug>(signify-prev-hunk)

" Switch to next/previous colorscheme
nnoremap <silent> ]k :call Kolors(+1)<CR>
nnoremap <silent> [k :call Kolors(-1)<CR>

" After pasting, cycle forwards/backwards through the clipboard history
nmap <silent> ]p <Plug>yankstack_substitute_newer_paste
nmap <silent> [p <Plug>yankstack_substitute_older_paste

" Switch to next/previous tab
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>

" Move selection one line down/up
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Use S to split a line
nnoremap S i<CR><ESC>

" Plugin IncSearch redirects
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)zvzz:ShowSearchIndex<CR>
map N  <Plug>(incsearch-nohl-N)zvzz:ShowSearchIndex<CR>
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

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
cnoreabbrev w!! w !sudo tee % > /dev/null

" Ctrl-A to go to the start of line
cnoremap <C-A> <Home>

" }}}

"""""""""""""""""
" Leader mappings {{{
"""""""""""""""""

" Change mapleader
let mapleader=','

" Open last file
nnoremap <silent> <Leader><Leader> <C-^>

" Toggle comments of current line
nnoremap <silent> <Leader>/ :let w:tcommentPos=getpos('.')<CR>:set opfunc=tcomment#OperatorLine<CR>g@$

" Toggle comments of selection
vnoremap <silent> <Leader>/ :TCommentMaybeInline<CR>

" [C]heck syntax
nnoremap <silent> <Leader>c :w<CR>:SyntasticCheck<CR>

" Toggle repo [d]iff signs
nnoremap <silent> <Leader>d :SignifyToggle<CR>

" Toggle the file [e]xplorer
nnoremap <silent> <Leader>e :NERDTreeTabsToggle<CR>

" [F]ind in files the word under the cursor
nnoremap <silent> <Leader>f :Ack!<Space>"<C-R><C-W>"<CR>

" [F]ind in files
nnoremap <Leader>F :Ack!<Space>""<Left>

" [G]it [c]ommit
nnoremap <silent> <Leader>gc :Git add -p<CR>:Gcommit -v<CR>

" [G]it [d]iff
nnoremap <silent> <Leader>gd :Git diff --color<CR>

" [G]it [d]iff staged files
nnoremap <silent> <Leader>gD :Git diff --color --cached<CR>

" Open file in [g]it[h]ub
nnoremap <silent> <Leader>gh :Gbrowse<CR>

" [G]it [l]og
nnoremap <silent> <Leader>gl :Git log --oneline --decorate --graph --color<CR>

" [G]it [l]og with diffs
nnoremap <silent> <Leader>gL :Git log --oneline --decorate --graph --color -p<CR>

" [G]it [m]ove
nnoremap <Leader>gm :Gmove<Space>

" [G]it [p]ush
nnoremap <silent> <Leader>gp :Git push<CR>

" [G]it [p]ull
nnoremap <silent> <Leader>gP :Git pull --rebase<CR>

" [G]it [r]emove
nnoremap <silent> <Leader>gr :Gremove<CR>

" [G]it [s]tatus
nnoremap <silent> <Leader>gs :Gstatus<CR>

" [G]it c[t]ags
nnoremap <silent> <Leader>gt :Git ctags<CR>

" Switch between source and [h]eader file
nnoremap <silent> <Leader>h :FSHere<CR>

" Extend K with Dash.app
nmap <silent> <Leader>k <Plug>DashSearch

" <Leader>l Toggles the [l]ocation-list

" Open the CtrlP-Funky extension with the word under the cursor ([m]ethod)
nnoremap <silent> <Leader>m :CtrlPFunky <C-R><C-W><CR>

" <Leader>o [O]pens files

" <Leader>q Toggles the [q]uickfix-list

" Open the [r]ecipe browser
nnoremap <silent> <Leader>r :CtrlPRecipes<CR>

" Toggle [s]pell checking
nnoremap <silent> <Leader>s :setlocal spell!<CR>

" Open the [T]agbar Plugin
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" Open the G[u]ndo Plugin
nnoremap <silent> <Leader>u :GundoToggle<CR>

" Edit [v]imrc in a new tab
nnoremap <silent> <Leader>v :tabnew<CR>:edit $MYVIMRC<CR>

" <Leader>w Opens the [W]inResizer plugin

" Execute late[x] (TeX-PDF plugin)
nnoremap <silent> <Leader>x :BuildAndViewTexPdf<CR>:redraw!<CR>

" }}}

"""""""""""""""
" Plugin config {{{
"""""""""""""""

" NERDTree plugin configuration
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.svn$', '\.git$', '\.o$', '\~$', '\.swp$', '\.pyc$', '\.class$', '\.dSYM$']
let g:NERDTreeMapCWD = 'cc'

" NERDTreeTabs plugin configuration
let g:nerdtree_tabs_open_on_gui_startup = 0

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
let g:syntastic_javascript_jshint_args = '--config .jshintrc'

" YouCompleteMe plugin configuration
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_allow_changing_updatetime = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_key_list_select_completion = ['<Tab>']
let g:ycm_key_list_previous_completion = ['<S-Tab>']

" Airline plugin configuration
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" tComment plugin configuration
let g:tcommentMaps = 0

" CtrlP plugin configuration
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_max_height = 15
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_clear_cache_on_exit = 0

" Doxygen syntax configuration (javadoc highlighting for C, C++, C# files)
let g:load_doxygen_syntax = 1
let doxygen_javadoc_autobrief = 0

" Tex syntax configuration
let g:tex_flavor = 'latex'
let g:tex_conceal = 'adgm'

" TeX-PDF plugin configuration
let g:tex_pdf_map_keys = 0

" Ack plugin configuration
let g:ackprg = 'ag --nocolor --nogroup --column'

" Signify plugin configuration
let g:signify_update_on_bufenter = 0
let g:signify_disable_by_default = 1
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_change = '~'

" WinResizer plugin configuration
let g:winresizer_start_key = '<Leader>w'

" IndexedSearch plugin configuration
let g:indexed_search_mappings = 0

" IncSearch plugin configuration
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#magic = '\v'

" % matches complex opening/closing entities
runtime macros/matchit.vim

" }}}

"""""""""""
" Functions {{{
"""""""""""

function! Kolors(num)

    let opt = [
    \   'jellybeans', 'kellys', 'molokai', 'mustang', 'wombat256mod', 'xoria256'
    \ ]

    execute 'colorscheme ' . opt[(match(opt, g:colors_name) + a:num) % len(opt)]

    silent! highlight NonText guifg=bg guibg=bg
    silent! highlight NonText ctermfg=bg ctermbg=bg
    silent! highlight CursorLine term=NONE cterm=NONE

    if g:colors_name ==# 'kellys'
        highlight Function  guifg=#afdfdf ctermfg=152
        highlight Namespace guifg=#a8a8a8 ctermfg=248
    endif
endf

" }}}
