" WARNING:
"   * The Tagbar plugin needs `exhuberant ctags' to work.
"   * The Powerline plugin needs to have a patched font to be pretty.
"     For more info go to:
"       https://github.com/Lokaltog/vim-powerline
"       https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts


" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Highlight characters after column 80
autocmd BufWinEnter * let w:m2=matchadd('CursorLine', '\%>80v.\+', -1)

"Restore cursor position to where it was before closing it
"{{{
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END
"}}}

" Open NERDTree plugin and unfocus it
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Make Syntastic plugin passive
autocmd VimEnter * silent! SyntasticToggleMode

" Use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Configure omni completion
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
autocmd FileType c          set omnifunc=ccomplete#Complete

" Necesary for lots of cool vim things
set nocompatible

" This shows what you are typing as a command
set showcmd

" Fold text when markers {{{ and }}} are found
set foldmethod=marker

" Syntax highlighting and indentation on
filetype plugin indent on
syntax enable
set autoindent

" Set flags for grep command
set grepprg=grep\ -nHE\ $*\ /dev/null

" Use javadoc-like highlighting for C, C++, C# and IDL files
let g:load_doxygen_syntax=1

" If doxygen_javadoc_autobrief is 0, it doesn't highlight the text
" section, else it highlights everything until doxygen_end_punctuation is
" matched
let doxygen_javadoc_autobrief=0
let doxygen_end_punctuation='^$'

" Use spaces instead of tabs (and be smart on newlines)
set expandtab
set smarttab

" Tab equals 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Real men use gcc
compiler gcc

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

" When I close a tab, remove the buffer
set nohidden

" Highlight matching parent
highlight MatchParen ctermbg=4

" Highlight the line that the cursor is on
set cursorline

" Have 5 lines ahead of the cursor in screen whenever possible
set scrolloff=5

" Disable fucking bell
set vb t_vb=

" Shift plus movement keys changes selection
set keymodel=startsel,stopsel

" Allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,]

" Map key to dismiss search highlightedness
map <bs> :noh<CR>

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

if has("gui_running")
    " Set font (possibly only works in macvim)
    set guifont=Menlo:h16
else
    " Force the tty to use 256 colors
    set t_Co=256
endif

" Set color scheme
colorscheme kellys

" Status line setup (not necessary with Powerline plugin)
set laststatus=2
" set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v]\ [%p%%]

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

" Swap buffers
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Open the NERDTree Plugin
nnoremap <silent> <Leader>t :NERDTreeToggle<CR>

" Open the Tagbar Plugin
nnoremap <silent> <Leader>l :TagbarToggle<CR>

" Check syntax with Syntastic plugin
nnoremap <silent> <Leader>s :w<CR>:SyntasticCheck<CR>

" Open the Syntastic plugin errors list
nnoremap <silent> <Leader>e :Errors<CR>

" TODO: NERDCommenter plugin shortcuts

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <C-o>gk
inoremap <silent> <Down> <C-o>gj

" Space will toggle folds
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Move through splits with ctrl-shift instead of ctrl-w
nmap <silent> <C-S-Up> :wincmd k<CR>
nmap <silent> <C-S-Down> :wincmd j<CR>
nmap <silent> <C-S-Left> :wincmd h<CR>
nmap <silent> <C-S-Right> :wincmd l<CR>

imap <silent> <C-S-Up> <Esc>:wincmd k<CR>
imap <silent> <C-S-Down> <Esc>:wincmd j<CR>
imap <silent> <C-S-Left> <Esc>:wincmd h<CR>
imap <silent> <C-S-Right> <Esc>:wincmd l<CR>

" NERDTree plugin configuration
let NERDTreeDirArrows=1
let NERDTreeWinSize=25

" Taglist plugin configuration
let g:tagbar_compact = 1
let g:tagbar_width = 30

" SuperTab plugin configuration
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Syntastic plugin configuration
let g:syntastic_loc_list_height=5

" Powerline plugin configuration
let g:Powerline_symbols = 'fancy'

