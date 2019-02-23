" vimrc
" Author: Zaiste! <oh@zaiste.net>
" Source: https://github.com/zaiste/vimified
"
" Have fun!
"
"
set nocompatible
filetype on
filetype off

let s:dotvim = fnamemodify(globpath(&rtp, 'vimified.dir'), ':p:h')

" Utils {{{
exec ':so '.s:dotvim.'/functions/util.vim'
" }}}

" Load external configuration before anything else {{{
let s:beforerc = expand(s:dotvim . '/before.vimrc')
if filereadable(s:beforerc)
    exec ':so ' . s:beforerc
endif
" }}}

let mapleader = ","
let maplocalleader = "\\"

" Local vimrc configuration {{{
let s:localrc = expand(s:dotvim . '/local.vimrc')
if filereadable(s:localrc)
    exec ':so ' . s:localrc
endif
" }}}

" PACKAGE LIST {{{
" Use this variable inside your local configuration to declare
" which package you would like to include
if ! exists('g:vimified_packages')
    let g:vimified_packages = ['general', 'fancy', 'os', 'coding', 'python', 'ruby', 'html', 'css', 'js', 'clojure', 'haskell', 'color']
endif
" }}}

" VUNDLE {{{
let s:bundle_path=s:dotvim."/plugged/"
call plug#begin(s:bundle_path)

" }}}

" PACKAGES {{{

" Install user-supplied Plugs {{{
let s:extrarc = expand(s:dotvim . '/extra.vimrc')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif
" }}}

" _. General {{{
if count(g:vimified_packages, 'general')
    Plug 'mbbill/undotree'
    map <leader>u :UndotreeToggle<cr>

	Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}

"function! BuildYCM(info)
	"if a:info.status == 'installed' || a:info.force
		"!./install.py
	"endif
"endfunction
	Plug 'Valloric/YouCompleteMe'

	let g:ycm_confirm_extra_conf = 0

	Plug 'rstacruz/vim-closer'
	"Plug 'WolfgangMehner/c-support'
    "Plug 'vim-scripts/c.vim'
    "Plug 'mileszs/ack.vim'
    "nnoremap <leader>a :Ack!<space>
    Plug 'editorconfig/editorconfig-vim'

    Plug 'rking/ag.vim'
    nnoremap <leader>a :Ag -i<space>

    "Plug 'matthias-guenther/hammer.vim'
    "nmap <leader>p :Hammer<cr>

    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-surround'
    let g:surround_{char2nr("c")} = "/* \r */"
    Plug 'tpope/vim-unimpaired'
    Plug 'maxbrunsfeld/vim-yankstack'
    Plug 'tpope/vim-eunuch'

    Plug 'scrooloose/nerdtree'
    " Disable the scrollbars (NERDTree)
    set guioptions-=r
    set guioptions-=L
    " Keep NERDTree window fixed between multiple toggles
    set winfixwidth


    Plug 'kana/vim-textobj-user'
    Plug 'vim-scripts/YankRing.vim'
    let g:yankring_replace_n_pkey = '<leader>['
    let g:yankring_replace_n_nkey = '<leader>]'
    let g:yankring_history_dir = s:dotvim.'/tmp/'
    nmap <leader>y :YRShow<cr>

    Plug 'michaeljsmith/vim-indent-object'
    let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

    Plug 'Spaceghost/vim-matchit'
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_working_path_mode = ''

    Plug 'vim-scripts/scratch.vim'

    Plug 'troydm/easybuffer.vim'
    nmap <leader>be :EasyBufferToggle<cr>

    Plug 'terryma/vim-multiple-cursors'

    "Plug 'vim-scripts/minibufexpl.vim'

    """"""""""""""""""""""""""""""
    " => Minibuffer plugin
    """"""""""""""""""""""""""""""
    "let g:miniBufExplModSelTarget = 1
    "let g:miniBufExplorerMoreThanOne = 2
    "let g:miniBufExplModSelTarget = 1
    "let g:miniBufExplUseSingleClick = 1
    "let g:miniBufExplMapWindowNavVim = 0
    "let g:miniBufExplHSplit = 10
    "let g:miniBufExplSplitAbove=1

    "autocmd BufRead,BufNew :call UMiniBufExplorer

    "map <leader>u :TMiniBufExplorer<cr>

    nnoremap <leader>it m'A<C-R>=" ".strftime('%Y-%m-%d %H:%M:%S')<CR><Esc>``

    "nnoremap <F8> :call GetDate('')<CR>
    "function! GetDate(format)
      "let format = empty(a:format) ? '+%F %T' : a:format
      "let cmd = '/bin/date ' . shellescape(format)
      "let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
       "Append space + result to current line without moving cursor.
      "call setline(line('.'), getline('.') . ' ' . result)
    "endfunction

	Plug 'myusuf3/numbers.vim'
	let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'minibufexpl', 'nerdtree']
	nnoremap <F3> :NumbersToggle<CR>

endif
" }}}

" _. Fancy {{{
if count(g:vimified_packages, 'fancy')
    "call g:Check_defined('g:airline_left_sep', '')
    "call g:Check_defined('g:airline_right_sep', '')
    "call g:Check_defined('g:airline_branch_prefix', '')

    Plug 'bling/vim-airline'
	let g:airline#extensions#tabline#enabled = 1
endif
" }}}

" _. Indent {{{
if count(g:vimified_packages, 'indent')
  Plug 'Yggdroot/indentLine'
  set list lcs=tab:\|\
  let g:indentLine_color_term = 111
  let g:indentLine_color_gui = '#DADADA'
  let g:indentLine_char = 'c'
  "let g:indentLine_char = '∙▹¦'
  let g:indentLine_char = '∙'
endif
" }}}

" _. OS {{{
if count(g:vimified_packages, 'os')
    Plug 'zaiste/tmux.vim'
    Plug 'benmills/vimux'
    map <Leader>rp :VimuxPromptCommand<CR>
    map <Leader>rl :VimuxRunLastCommand<CR>

    map <LocalLeader>d :call VimuxRunCommand(@v, 0)<CR>
endif
" }}}

" _. Coding {{{

if count(g:vimified_packages, 'coding')
	Plug 'Yggdroot/LeaderF'
	nmap <leader>t :LeaderfBufTagAll<CR>

    Plug 'chazy/cscope_maps'
    Plug 'gregsexton/gitv'

    Plug 'scrooloose/nerdcommenter'
    nmap <leader># :call NERDComment(0, "invert")<cr>
    vmap <leader># :call NERDComment(0, "invert")<cr>

    " - Plug 'msanders/snipmate.vim'
    Plug 'sjl/splice.vim'

    Plug 'tpope/vim-fugitive'
    nmap <leader>gs :Gstatus<CR>
    nmap <leader>gc :Gcommit -v<CR>
    nmap <leader>gac :Gcommit --amen -v<CR>
    nmap <leader>g :Ggrep
    " ,f for global git search for word under the cursor (with highlight)
    nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
    " same in visual mode
    :vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

    Plug 'scrooloose/syntastic'
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby'], 'passive_filetypes': ['html', 'css', 'slim'] }
    let g:syntastic_cpp_compiler = executable('clang++') ? 'clang++' : 'g++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11'

    " --

    Plug 'vim-scripts/Reindent'

    autocmd FileType gitcommit set tw=68 spell
    autocmd FileType gitcommit setlocal foldmethod=manual

    " Check API docs for current word in Zeal: http://zealdocs.org/
    " nnoremap <leader>d :!zeal --query "<cword>"&<CR><CR>

endif
" }}}



" _. Python {{{
if count(g:vimified_packages, 'python')
    Plug 'klen/python-mode'
    Plug 'python.vim'
    Plug 'python_match.vim'
    Plug 'pythoncomplete'
    Plug 'jmcantrell/vim-virtualenv'
endif
" }}}

" _. Go {{{
if count(g:vimified_packages, 'go')
    Plug 'fatih/vim-go'
    let g:go_disable_autoinstall = 1
endif
" }}}

" _. Ruby {{{
if count(g:vimified_packages, 'ruby')
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-rails'
    Plug 'nelstrom/vim-textobj-rubyblock'
    Plug 'ecomba/vim-ruby-refactoring'

    autocmd FileType ruby,eruby,yaml set tw=80 ai sw=2 sts=2 et
    autocmd FileType ruby,eruby,yaml setlocal foldmethod=manual
    autocmd User Rails set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
endif
" }}}

" _. Clang {{{
if count(g:vimified_packages, 'clang')
    Plug 'Rip-Rip/clang_complete'
    Plug 'LucHermitte/clang_indexer'
    Plug 'newclear/lh-vim-lib'
    Plug 'LucHermitte/vim-clang'
endif
" }}}

" _. HTML {{{
if count(g:vimified_packages, 'html')
    Plug 'tpope/vim-haml'
    Plug 'juvenn/mustache.vim'
    Plug 'tpope/vim-markdown'
    Plug 'digitaltoad/vim-jade'
    Plug 'slim-template/vim-slim'

    au BufNewFile,BufReadPost *.jade setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.html setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.slim setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.md set filetype=markdown

    let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']
endif
" }}}

" _. CSS {{{
if count(g:vimified_packages, 'css')
    Plug 'wavded/vim-stylus'
    Plug 'lunaru/vim-less'
    nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>
endif
" }}}

" _. JS {{{
if count(g:vimified_packages, 'js')
    Plug 'kchmck/vim-coffee-script'
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab

    Plug 'alfredodeza/jacinto.vim'
    au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
    au BufNewFile,BufReadPost *.coffee setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
endif
" }}}

" _. Clojure {{{
if count(g:vimified_packages, 'clojure')
    Plug 'guns/vim-clojure-static'
    Plug 'tpope/vim-fireplace'
    Plug 'tpope/vim-classpath'
endif
" }}}

" _. Haskell {{{
if count(g:vimified_packages, 'haskell')
    Plug 'Twinside/vim-syntax-haskell-cabal'
    Plug 'lukerandall/haskellmode-vim'

    au BufEnter *.hs compiler ghc

    let g:ghc = "/usr/local/bin/ghc"
    let g:haddock_browser = "open"
endif
" }}}

" _. Elixir {{{
if count(g:vimified_packages, 'elixir')
    Plug 'elixir-lang/vim-elixir'
endif
" }}}

" _. Rust {{{
if count(g:vimified_packages, 'rust')
    Plug 'wting/rust.vim'
endif
" }}}

" _. Elm {{{
if count(g:vimified_packages, 'elm')
    Plug 'lambdatoast/elm.vim'
endif
" }}}

" _. Color {{{
if count(g:vimified_packages, 'color')
    Plug 'sjl/badwolf'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tomasr/molokai'
    Plug 'zaiste/Atom'
    Plug 'w0ng/vim-hybrid'
    Plug 'chriskempson/base16-vim'
    Plug 'Elive/vim-colorscheme-elive'
    Plug 'zeis/vim-kolor'

else
    colorscheme default
endif
" }}}

" }}}
call plug#end()

" During installation the molokai colorscheme might not be avalable
if filereadable(globpath(&rtp, 'colors/molokai.vim'))
  colorscheme molokai
else
  colorscheme default
endif

" General {{{
filetype plugin indent on

syntax on

" Set 5 lines to the cursor - when moving vertically
set scrolloff=0

" It defines where to look for the buffer user demanding (current window, all
" windows in other tabs, or nowhere, i.e. open file from scratch every time) and
" how to open the buffer (in the new split, tab, or in the current window).

" This orders Vim to open the buffer.
set switchbuf=useopen

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

autocmd FileType c set tabstop=4 shiftwidth=4 expandtab!
" }}}

" Mappings {{{

" You want to be part of the gurus? Time to get in serious stuff and stop using
" arrow keys.
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>

" Yank from current cursor position to end of line
map Y y$
" Yank content in OS's clipboard. `o` stands for "OS's Clipoard".
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" better ESC
inoremap <C-k> <Esc>

nmap <silent> <leader>hh :set invhlsearch<CR>
nmap <silent> <leader>ll :set invlist<CR>
nmap <silent> <leader>nn :set invnumber<CR>
nmap <silent> <leader>pp :set invpaste<CR>
nmap <silent> <leader>ii :set invrelativenumber<CR>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Source current line
vnoremap <leader>L y:execute @@<cr>
" Source visual selection
nnoremap <leader>L ^vg_y:execute @@<cr>

" Fast saving and closing current buffer without closing windows displaying the
" buffer
nmap <leader>wq :w!<cr>:Bclose<cr>

" }}}

" . abbrevs {{{
"

" . }}}


" Settings {{{
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set encoding=utf-8
set hidden
set history=1000
set incsearch
set laststatus=2
set list

" Don't redraw while executing macros
set nolazyredraw

" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
"set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" _ backups {{{
if has('persistent_undo')
  " undo files
  exec 'set undodir='.s:dotvim.'/tmp/undo//'
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
" backups
exec 'set backupdir='.s:dotvim.'/tmp/backup//'
" swap files
exec 'set directory='.s:dotvim.'/tmp/swap//'
set backup
set noswapfile
" _ }}}

set modelines=0
set noeol
"if exists('+relativenumber')
  "set relativenumber
"endif
set number
set numberwidth=3
set winwidth=83
set ruler
if executable('zsh')
  set shell=zsh\ -l
endif
set showcmd

set exrc
set secure

set matchtime=2

set completeopt=longest,menuone,preview

" White characters {{{
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
set expandtab
set wrap
set formatoptions=qrn1
if exists('+colorcolumn')
  set colorcolumn=+1
endif
set cpo+=J
" }}}

set visualbell

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu

set dictionary=/usr/share/dict/words
" }}}

" Triggers {{{

" Save when losing focus
au FocusLost    * :silent! wall
"
" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source $MYVIMRC

" }}}

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
" }}}

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
" If you want to remove trailing spaces when you want, so not automatically,
" see
" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Display_or_remove_unwanted_whitespace_with_a_script.
autocmd BufWritePre * :%s/\s\+$//e

" Removes trailing spaces
"function TrimWhiteSpace()
  "%s/\s*$//
  "''
":endfunction

"nnoremap <leader>w :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>


" }}}

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set incsearch
set smartcase
set showmatch
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight word {{{

nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" }}}

" }}}

" Navigation & UI {{{

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy buffer navigation
noremap <leader>j :bprevious<cr>
noremap <leader>k :bnext<cr>
"noremap <leader>bp :bprevious<cr>
"noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

nmap <tab> :NERDTreeToggle<cr>

" }}}

" . folding {{{

set foldlevelstart=20
set foldmethod=syntax

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

" }}}

" Quick editing {{{

nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
exec 'nnoremap <leader>es <C-w>s<C-w>j:e '.s:dotvim.'/snippets/<cr>'
nnoremap <leader>eg <C-w>s<C-w>j:e ~/.gitconfig<cr>
nnoremap <leader>ez <C-w>s<C-w>j:e ~/.zshrc<cr>
nnoremap <leader>et <C-w>s<C-w>j:e ~/.tmux.conf<cr>

" --------------------

set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

" showmarks
let g:showmarks_enable = 1
hi! link ShowMarksHLl LineNr
hi! link ShowMarksHLu LineNr
hi! link ShowMarksHLo LineNr
hi! link ShowMarksHLm LineNr

" }}}

" _ Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" EXTENSIONS {{{

" _. Scratch {{{
exec ':so '.s:dotvim.'/functions/scratch_toggle.vim'
" }}}

" _. Buffer Handling {{{
exec ':so '.s:dotvim.'/functions/buffer_handling.vim'
" }}}

" _. Tab {{{
exec ':so '.s:dotvim.'/functions/insert_tab_wrapper.vim'
" }}}

" _. Text Folding {{{
exec ':so '.s:dotvim.'/functions/my_fold_text.vim'
" }}}

" _. Gist {{{
" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
" }}}

" }}}

" Load addidional configuration (ie to overwrite shorcuts) {{{
let s:afterrc = expand(s:dotvim . '/after.vimrc')
if filereadable(s:afterrc)
    exec ':so ' . s:afterrc
endif
" }}}