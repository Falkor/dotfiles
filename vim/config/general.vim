
" General Settings
"---------------------------------------------------------
" General {{{
set mouse=a                  " Enable mouse to scroll in command-line mode
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set noerrorbells             " Don't trigger bell on error
set visualbell t_vb=         " Don't make any faces
set lazyredraw               " don't redraw while in macros
set hidden                   " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
set history=1000             " Search and commands remembered
set synmaxcol=1000           " Don't syntax highlight long lines
syntax on
syntax sync minlines=256     " Update syntax highlighting for more lines
set ttyfast                  " Indicate a fast terminal connection
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text

if has('vim_starting')
	set encoding=utf-8         " The encoding displayed.
	set fileencoding=utf-8     " The encoding written to file.
	"setglobal bomb           "  put "byte order mark" (BOM) at the start of Unicode files.
  "set fileencodings=ucs-bom,utf-8,latin1
	set binary
endif

" What to save for views:
" set viewoptions-=options viewoptions+=slash,unix

" What not to save in sessions:
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions-=buffers

set clipboard=unnamed
" if has('clipboard') || has('gui_running')
" 	set clipboard=unnamed,unnamedplus
" endif
" General }}}

" Wildmenu {{{
" --------
if has('wildmenu')
	set nowildmenu
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.git,*.pyc,*.spl,*.o,*.out,*~,#*#,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
endif

" }}}

" Tabs and Indents {{{
" ----------------
set textwidth=80    " Text width maximum chars before wrapping
set expandtab       " Do expand tabs to spaces as default
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
set shiftwidth=2    " Number of spaces to use in auto(indent)

" }}}
" Folds {{{
" -----
if has('folding')
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
	set foldtext=FoldText()
endif

" }}}
" Time {{{
" --------
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set ttimeoutlen=250 " Time out on key codes
set updatetime=1000 " Idle time to write swap

if has('nvim')
	" https://github.com/neovim/neovim/issues/2017
	set ttimeoutlen=-1
endif

" }}}
" Searching {{{
" ---------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase
set incsearch       " Incremental search
set hlsearch        " Highlight search results
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed

" }}}
" Behavior {{{
" --------
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=usetab,split      " Switch buffer behavior
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore white
set showfulltag                 " Show tag and tidy search in completion
set completeopt=menuone         " Show menu even for one item
set complete=.                  " No wins, buffs, tags, include scanning
set nowrap                      " No wrap by default

" }}}

set shell=/bin/sh       " Use Bourne shell for command substitution

" Editor UI Appearance {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=3         " Keep at least 3 lines above/below
set sidescrolloff=3     " Keep at least 3 lines left/right
set pumheight=20        " Pop-up menu's line height
set number              " Show line numbers
"set relativenumber      " Use relative instead of absolute line numbers
set ruler               " Enable default status ruler
set nolist                " Show hidden characters

set showtabline=2       " Always show the tabs line
set tabpagemax=30       " Maximum number of tab pages
set winwidth=30         " Minimum width for current window
set winheight=1         " Minimum height for current window
set previewheight=8     " Completion preview height
set helpheight=12       " Minimum help window height

set display=lastline
set title               " No need for a title
" Title format: see https://coderwall.com/p/lznfyw/better-title-string-for-vim
" directory info (max 12 char)          | buff. no | filename | modified | Type | Row no.
set titlestring=...%{strpart(expand(\"%:p:h\"),stridx(expand(\"%:p:h\"),\"/\",strlen(expand(\"%:p:h\"))-12))}%=%n.\ \ %{expand(\"%:t:r\")}\ %m\ %Y\ \ \ \ %l\ of\ %L
set showcmd             " Show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set noequalalways       " Don't resize windows on split or close
set laststatus=2        " Always show a status line
set colorcolumn=80      " Highlight the 80th character limit

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
if has('patch-7.4.314')
	set shortmess+=c
endif

" For snippet_complete marker
if has('conceal') && v:version >= 703
	set conceallevel=2 concealcursor=niv
endif

" }}}
" vim: set ts=2 sw=2 tw=80 noet foldmethod=marker:
"
