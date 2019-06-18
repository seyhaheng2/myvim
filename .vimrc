"set guifont=Menlo\ Regular:h20
set guifont=PragmataPro:h23,Essential\ PragmataPro:h23,iosevka:h23
colorscheme one

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
set guioptions=e  " instead of clearing this, set it to only `e`
let g:airline_left_sep = '>'
let g:airline_left_sep = '|'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

nnoremap ;; :bn<cr>
nnoremap aa :bp<cr>
inoremap jj <esc>
nnoremap <space> za
nnoremap <C-]> c^
nnoremap gV `[v`]
nnoremap j gj
nnoremap k gk
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>
let g:autoclose_vim_commentmode = 1
nnoremap <C-s> :UndotreeToggle<cr>

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <C-e> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

nnoremap<Leader>c :CoffeeBuffer2JS<CR>
nnoremap<Leader>sc :CoffeeSelection2JS<CR>
nnoremap<Leader>j :JSBuffer2Coffee<CR>

nmap <leader>h :%!html2haml --erb 2> /dev/null<CR>:set ft=haml<CR>
vmap <leader>h :!html2haml --erb 2> /dev/null<CR>

autocmd BufWritePost * FixWhitespace

if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'slashmili/alchemist.vim'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-haml'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'ruby-matchit'

NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'matchit.zip'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'jasonmortonnz/bs3-sublime-plugin'

NeoBundle 'wincent/Command-T'
NeoBundle 'vim-scripts/IndentAnything'
NeoBundle 'vim-scripts/IndexedSearch'
NeoBundle 'vim-scripts/LustyJuggler'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'sjl/clam.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'junkblocker/patchreview-vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'godlygeek/tabular'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'int3/vim-extradite'
NeoBundle 'mbbill/undotree'


NeoBundle 'rizzatti/dash.vim'
NeoBundle 'elzr/vim-json'
    augroup json_autocmd
      autocmd!
      autocmd FileType json set autoindent
      autocmd FileType json set formatoptions=tcq2l
      autocmd FileType json set textwidth=78 shiftwidth=2
      autocmd FileType json set softtabstop=2 tabstop=8
      autocmd FileType json set expandtab
      autocmd FileType json set foldmethod=syntax
    augroup END

" css
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tomtom/checksyntax_vim'

" js
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'elzr/vim-json'
NeoBundle 'millermedeiros/vim-esformatter'
NeoBundle 'marijnh/tern_for_vim'

"flutter

NeoBundle 'dart-lang/dart-vim-plugin'
NeoBundle 'thosakwe/vim-flutter'

" snipmate
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'

" search
NeoBundle 'kien/ctrlp.vim'

"AG Search
NeoBundle 'rking/ag.vim'
let g:agprg="<custom-ag-path-goes-here> --vimgrep"
let g:ag_working_path_mode="r"
NeoBundle 'tpope/vim-abolish'

" vim ui
NeoBundle 'millermedeiros/vim-statline'
NeoBundle 'bling/vim-airline'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tmhedberg/indent-motion'
NeoBundle 'jordwalke/VimCleanColors'
NeoBundle 'jordwalke/vim-one'
NeoBundle 'majutsushi/tagbar'

if !exists('g:one_allow_italics')
  " Italics don't typically render well in terminals
  let g:one_allow_italics = has('gui_running')
endif


" =============================== Session = ====================================
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
" let g:session_autosave_periodic = 0  "Every three minutes + on close seems fine.
" But saving resets window dims!
let g:session_autosave = 'yes'       "Auto-save on close
let g:session_autoload = 'no'
" let g:session_menu=1
" We have our own sessions.vim file that does some interesting stuff.

" Make sure to save sessions outside of your dotfiles in case you publish your
" dotfiles to github etc.
" The Session Directory
let s:homeFolder = $HOME
if (exists('g:vimBoxSessionDir'))
  let g:session_directory=g:vimBoxSessionDir
else
  let g:session_directory=s:homeFolder . '/vim_sessions'
endif
" ==============================================================================

" My custom session management GUI tools (in menu bar) Based on one of the
" other session managers.
set runtimepath+=~/.vim/localBundle/sessions
set runtimepath+=~/.vim/localBundle/wowcamldebug



" ================================== Smooth-Scroll =================================
NeoBundle 'terryma/vim-smooth-scroll'
"Normal mode
noremap <silent> <c-u> :call smooth_scroll#up(40, 20, 6)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(40, 20, 6)<CR>

" smooth_scroll is broken in visual mode currently - unmap
vnoremap <silent> <c-u> <c-u>
vnoremap <silent> <c-d> <c-d>
" ==============================================================================


" =============================Javascript-Indent================================
" I suspect this is doing nothing since JavaScript-Indent overwrites the
" indentation hooks, but I cannot prove it.
NeoBundle 'pangloss/vim-javascript'
" ==============================================================================

" =============================Javascript-Indent================================
" nemtsov's fork which does *not* echo annoyingly for *every* HTML file you
" open.
NeoBundle 'nemtsov/JavaScript-Indent', { 'commit': 'f3e168e70a540678bae4929edf0b21c84c3ed3aa' }
" ==============================================================================

NeoBundle 'mxw/vim-jsx'


call neobundle#end()


"call FlutterMenu()
"flutter command
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>


" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"


try
  filetype on
  :set filetype=scss
  au BufRead,BufNewFile *.scss set filetype=scss.css
  au! BufRead,BufNewFile *.sass
  au BufRead,BufNewFile *.scss set filetype=sass

  autocmd FileType scss set iskeyword+=-

  set foldenable " Turn on folding
  set foldmethod=indent " Fold on the indent
  set foldlevelstart=10 " Open most folds by default
  set foldnestmax=10 " 10 nested folds max
  set nocompatible
  :set regexpengine=1
  :syntax enable
  "colorscheme Tomorrow-Night
  "colorscheme hybrid_reverse
  let g:enable_bold_font = 1
  filetype indent on
  set smartindent
  autocmd BufRead,BufWritePre *.sh normal gg=G
  set background=dark
  syntax on
  set guioptions-=r
  set ts=2 " Tabs are 2 spaces
  set bs=2 " Backspace over everything in insert mode
  set shiftwidth=2 " Tabs under smart indent
  set nocp incsearch
  set cinoptions=:0,p0,t0
  set cinwords=if,else,while,do,for,switch,case
  set formatoptions=tcqr
  set autoindent
  set autowrite
  set backspace=indent,eol,start
  set mouse=a
  set ruler
  set lcs=eol:¬
  set gdefault " Global as default
  set foldenable " Turn on folding
  set laststatus=2   " Always show the statusline
  set encoding=utf-8 " Necessary to show Unicode glyphs
  set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
  set cursorline          " highlight line where the cursor is
  set cursorcolumn        " highlight column where the cursor is
  set showmatch           " higlight matching parentheses and brackets
  set wildmenu            " enable visual wildmenu
  set noswapfile
  set nobackup
  set number
  set wildmode=longest:full,full
  set hidden
  autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
  set filetype=scss

catch
    " Vim UI {
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode
    colorscheme one
    set cursorline                  " highlight current line
    hi cursorline guibg=\#333333     " highlight bg color of current line
    hi CursorColumn guibg=\#333333   " highlight cursor

    if has('cmdline_info')
      set ruler                   " show the ruler
      set showcmd                 " show partial commands in status line and
    endif

    if has('statusline')
      set laststatus=2
    endif

    set backspace=indent,eol,start  " backspace for dummys
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set gdefault                    " the /g flag on :s substitutions by default
    set list
    set listchars=tab:>.,trail:.,extends:\#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
  set nowrap                      " wrap long lines
  set autoindent                  " indent at the same level of theprevious line
  filetype indent on
  set shiftwidth=2               " use indents of 4 spaces
  set expandtab                   " tabs are spaces, not tabs
  set tabstop=2                   " an indentation every fourcolumns
  set softtabstop=2               " let backspace delete indent
  set pastetoggle=<F12>           " pastetoggle (sane indentationon pastes)
  let g:enable_bold_font = 1
  set foldenable " Turn on folding
  set foldmethod=indent " Fold on the inden
" }

endtry

NeoBundleCheck