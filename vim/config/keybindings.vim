
" Key Bindings and Abbreviations
"---------------------------------------------------------
" Documentation reminder for shortcuts:
" {cmd} {attr} {lhs} {rhs}
" where
"    {cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
"           ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
"    {attr} is optional and one or more of the following: <buffer>, <silent>,
"        <expr> <script>, <unique> and <special>.
"        More than one attribute can be specified to a map.
"    {lhs}  left hand side, is a sequence of one or more keys that you will use
"        in your new shortcut.
"    {rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
"        will execute when entered.
"
" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps
"
" Special Key notations -- see http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)
" <BS>           Backspace
" <Tab>          Tab
" <CR>           Enter
" <Enter>        Enter
" <Return>       Enter
" <Esc>          Escape
" <Space>        Space
" <Up>           Up arrow
" <Down>         Down arrow
" <Left>         Left arrow
" <Right>        Right arrow
" <F1> - <F12>   Function keys 1 to 12
" #1, #2..#9,#0  Function keys F1 to F9, F10
" <Insert>       Insert
" <Del>          Delete
" <Home>         Home
" <End>          End
" <PageUp>       Page-Up
" <PageDown>     Page-Down
" <bar>          the '|' character, which otherwise needs to be escaped '\|'

" _____________________________________________________
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"______________________________________________
" Fonctions Keys {{{
noremap  <F1> :NERDTreeToggle %<CR>
nnoremap <F2> :set nonumber!<CR>

if neobundle#tap('undotree') "{{{
  nnoremap <F7>  :UndotreeToggle<CR>

  call neobundle#untap()
endif
" }}}


nmap     <F8> :TagbarToggle<CR>    " displays tags in a window, ordered by scope

" }}}


"______________________________________________
" Opening Files/Buffers (with ctrlp plugin) {{{
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<c-t>'],
\ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ } " open in a new tab
nnoremap <Leader>o :CtrlP <CR>        " open new file
nnoremap <Leader>b :CtrlPBuffer<CR>   " open buffer
" }}}

" " Type <Space>w to save file (a lot faster than :w<Enter>):
" function! <SID>StripTrailingWhitespaces(command)
"     let l = line(".")
"     let c = col(".")
"     %s/\s\+$//e
"     call cursor(l, c)
" endfun
"

nnoremap <Leader>w :w<CR>

"___________________
" Bash/Emacs-like {{{
map <C-e> $
map <C-a> 0|
map <C-k> d$
map! <C-e> <esc>A
map! <C-a> <esc>0i
map! <C-k> <esc>d$
" }}}

"___________________
" Copy/Paste/Cut {{{
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
" see http://tilvim.com/2014/03/18/a-better-paste.html
" a better paste
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
noremap YY "+y<CR>
" noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif


" " Automatically jump to end of text you pasted:
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" Quickly select text you just pasted:
" noremap gV `[v`]
" }}}

"_________________
" Split Screen {{{
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <Tab><Tab> <c-w>w           " Go to next pane with Tab+Tab
" }}}

"_________
" Tabs {{{
nnoremap <C-t> :tabnew<CR>
nnoremap <Leader><Left>  gT
nnoremap <Leader><Right> gt
nnoremap te :tabe<Space>
" }}}

" " Mimic Emacs ??? {{{
autocmd FileType * setlocal indentkeys+=!<Tab>  " Use tab to indent

" }}}

" Buffer {{{
noremap <leader>q :bd<CR>
" }}}

"_______________________________________________
" Visual line stuff <Space><Space> {{{
nmap <Leader><Leader> V
vmap < <gv
vmap > >gv
if neobundle#tap('vim-expand-region') "{{{
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)
  call neobundle#untap()
endif
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" }}}


"_________________________________________________
if neobundle#tap('incsearch.vim') " Searching {{{
	let g:incsearch#auto_nohlsearch = 1
	map /  <Plug>(incsearch-forward)
	map ?  <Plug>(incsearch-backward)
"	map g/ <Plug>(incsearch-stay)
	map n  <Plug>(incsearch-nohl-n)
	map N  <Plug>(incsearch-nohl-N)
	call neobundle#untap()
endif
nnoremap <silent> <leader>f :Rgrep<CR>

"}}}

"_________
" Git {{{
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gpu :Gpush<CR>
noremap <Leader>gup :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
if neobundle#tap('vim-gitgutter')
  nmap <Leader>ggn <Plug>GitGutterNextHunk
	nmap <Leader>ggp <Plug>GitGutterPrevHunk
	nmap <Leader>ggp <Plug>GitGutterPreviewHunk
  call neobundle#untap()
endif
" }}}

"_________
" Python / Jedi {{{
if neobundle#tap('jedi-vim')
  let g:jedi#goto_command = "<leader>d"
  " let g:jedi#goto_assignments_command = "<leader>g"
  let g:jedi#goto_definitions_command = ""
  let g:jedi#documentation_command = "K"
  let g:jedi#usages_command = "<leader>n"
  let g:jedi#completions_command = "<C-Space>"
  let g:jedi#rename_command = "<leader>r"

  call neobundle#untap()
endif
" }}}

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"_________
" Misc {{{
map q: :q    " Stop that stupid window from popping up

map <silent> <C-n> :set invhlsearch<CR>

" easy .vimrc editing {{{1 "
" quickly edit and source vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" nmap <Leader>rc :source $XDG_CONFIG_HOME/vim/vimrc<CR>
" 1}}} "
