
" Plugins with NeoBundle
"---------------------------------------------------------

" Always loaded {{{}
" -------------
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'jistr/vim-nerdtree-tabs.git'    " single panel
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'        " see https://github.com/vim-airline/vim-airline/wiki/Screenshots
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'itchyny/vim-cursorword'
NeoBundle 'itchyny/vim-gitbranch'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'vim-scripts/CSApprox'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' :  'make -f make_cygwin.mak',
\     'mac' :     'make -f make_mac.mak',
\     'unix' :    'make -f make_unix.mak',
\    },
\ }
if v:version > 702
  NeoBundle 'Shougo/vimshell.vim'
endif

NeoBundle 'rafi/vim-tinyline'
NeoBundle 'rafi/vim-tagabana'
NeoBundle 'lambdalisue/vim-gita'

"" Vim-Session
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'

"" Snippets
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

"" Color Themes
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scwood/vim-hybrid'
NeoBundle 'mhinz/vim-janah'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'NLKNguyen/papercolor-theme'

"" Vim-Bootstrap Updater
NeoBundle 'sherzberg/vim-bootstrap-updater'


" LAZY LOADING from here on!
" --------------------------------------------------------

" Fetch repositories, but don't add to runtimepath
NeoBundleFetch 'chriskempson/base16-shell'
NeoBundleFetch 'rafi/awesome-vim-colorschemes'

" }}}
" Language {{{
" --------
NeoBundleLazy 'othree/html5.vim', {'on_ft': 'html'}
NeoBundleLazy 'mustache/vim-mustache-handlebars', {'on_ft': 'html'}
NeoBundleLazy 'rcmdnk/vim-markdown', {'on_ft': 'markdown'}
NeoBundleLazy 'chase/vim-ansible-yaml', {'on_ft': ['yaml', 'ansible']}
NeoBundleLazy 'mitsuhiko/vim-jinja', {'on_ft': ['htmljinja', 'jinja']}
NeoBundleLazy 'groenewege/vim-less', {'on_ft': 'less'}
NeoBundleLazy 'hail2u/vim-css3-syntax', {'on_ft': 'css'}
NeoBundleLazy 'chrisbra/csv.vim', {'on_ft': 'csv'}
NeoBundleLazy 'hynek/vim-python-pep8-indent', {'on_ft': 'python'}
NeoBundleLazy 'elzr/vim-json', {'on_ft': 'json'}
NeoBundleLazy 'cespare/vim-toml', {'on_ft': 'toml'}
NeoBundleLazy 'PotatoesMaster/i3-vim-syntax', {'on_ft': 'i3'}
NeoBundleLazy 'ekalinin/Dockerfile.vim', {'on_ft': 'Dockerfile'}
NeoBundleLazy 'vim-ruby/vim-ruby', {'on_ft': 'ruby', 'on_map': '<Plug>'}
NeoBundleLazy 'jelera/vim-javascript-syntax', {'on_ft': 'javascript'}
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {'on_ft': 'javascript'}
NeoBundleLazy 'fatih/vim-go', {
	\ 'on_ft': 'go',
	\ 'on_cmd': ['GoInstallBinaries', 'GoUpdateBinaries']
	\ }

" }}}
" Commands {{{
" --------
NeoBundleLazy 'mbbill/undotree', {'on_cmd': 'UndotreeToggle'}

if $VIM_MINIMAL ==? ''
	NeoBundleLazy 'thinca/vim-guicolorscheme', {'on_cmd': 'GuiColorScheme'}
	NeoBundleLazy 'guns/xterm-color-table.vim', {'on_cmd': 'XtermColorTable'}
	NeoBundleLazy 'thinca/vim-quickrun', {'on_map': '<Plug>'}
	NeoBundleLazy 'thinca/vim-prettyprint', {'on_cmd': 'PP', 'on_func': 'PP'}
endif

" }}}

" vim: set ts=2 sw=2 tw=80 noet :
