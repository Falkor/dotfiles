
" Key Bindings
"---------------------------------------------------------
" Documentation reminder:
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

" Open file through ctrlp in a new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" Type <Space>o to open a new file, <Space>b to open buffer
nnoremap <Leader>o :CtrlP <CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

" Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>

" Copy/Paste/Cut {{{
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" see http://tilvim.com/2014/03/18/a-better-paste.html
" a better paste
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
noremap YY "+y<CR>
" noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" Automatically jump to end of text you pasted:
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Quickly select text you just pasted:
noremap gV `[v`]
" }}}


" Split {{{
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <Tab><Tab> <c-w>w           " Go to next pane with Tab+Tab
" }}}

" " Mimic Emacs ??? {{{
autocmd FileType * setlocal indentkeys+=!<Tab>  " Use tab to indent

" }}}

" Buffer {{{
noremap <leader>q :bd<CR>
" }}}

" Enter visual line mode with <Space><Space> {{{
nmap <Leader><Leader> V
vmap < <gv
vmap > >gv
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}

if neobundle#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
  call neobundle#untap()
endif
"}}}

" Git {{{
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gpu :Gpush<CR>
noremap <Leader>gup :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
" }}}

" Tabs {{{
nnoremap <C-t> :tabnew<CR>
nnoremap <Leader><Left>  gT
nnoremap <Leader><Right> gt
nnoremap te :tabe<Space>
" }}}

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Stop that stupid window from popping up:
map q: :q

" pasting

map <silent> <C-n> :set invhlsearch<CR>

" easy .vimrc editing {{{1 "
" quickly edit and source vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" nmap <Leader>rc :source $XDG_CONFIG_HOME/vim/vimrc<CR>
" 1}}} "
