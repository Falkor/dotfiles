
" Key Bindings
"---------------------------------------------------------

" Split {{{
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
" }}}

" Git {{{
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
" }}}


"" Tabs
nnoremap <C-t> :tabnew<Space>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


" pasting
set pastetoggle=<F5>

map <silent> <C-n> :set invhlsearch<CR>

" easy .vimrc editing {{{1 "
" nmap <Leader>rc :source $XDG_CONFIG_HOME/vim/vimrc<CR>
" 1}}} "


"
" vmap <Leader>y "+y
" nmap <Leader>p "+p
" nmap <Leader>P "+P
" vmap <Leader>p "+p
" vmap <Leader>P "+P
"
" " 13<enter> <enter> <backspace>
" nnoremap <CR> G
" nnoremap <BS> gg
