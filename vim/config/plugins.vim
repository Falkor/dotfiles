
" Plugin Settings -- Keybindings are defined separatel
"---------------------------------------------------------

if neobundle#tap('nerdtree') "{{{
	nnoremap <leader>n :NERDTreeFocus<CR>
  nnoremap <leader>t :NERDTreeToggle<CR>
  " nnoremap <C-f> :NERDTreeFind<CR>
	" nice arrow
	let g:NERDTreeDirArrows = 1
	" not so much cruft
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeShowBookmarks = 1
	let NERDTreeShowHidden=1
	hi def link NERDTreeRO Normal
	hi def link NERDTreePart StatusLine
	hi def link NERDTreeDirSlash Directory
	hi def link NERDTreeCurrentNode Search
	hi def link NERDTreeCWD Normal
	" Not so much color
	let g:NERDChristmasTree = 0

	let g:nerdtree_tabs_focus_on_files = 1
	let g:nerdtree_tabs_open_on_gui_startup = 0

	let g:NERDTreeChDirMode=2
	let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.md\.tex$', '\.elc$']
	let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
	let g:NERDTreeShowBookmarks=1
	let g:nerdtree_tabs_focus_on_files=1
	let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
	let g:NERDTreeWinSize = 50
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
	" nnoremap <silent> <F2> :NERDTreeFind %<CR>
	call neobundle#untap()
endif

"}}}


if neobundle#tap('neocomplete') && has('lua') "{{{
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#data_directory = $VARPATH.'/complete'
	let neobundle#hooks.on_source    = $VIMPATH.'/config/plugins/neocomplete.vim'

	call neobundle#untap()
endif

"}}}

if neobundle#tap('grep.vim') "{{{
	let Grep_Default_Options = '-IR'
	let Grep_Skip_Files = '*.log *.db'
	let Grep_Skip_Dirs = '.git node_modules'
	call neobundle#untap()
endif
"}}}



if neobundle#tap('vimshell.vim') "{{{
	let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
	let g:vimshell_prompt =  '$ '
endif
"}}}


if neobundle#tap('neosnippet') "{{{
	let g:neosnippet#enable_snipmate_compatibility = 0
	let g:neosnippet#enable_preview = 1
	let g:neosnippet#disable_runtime_snippets = { '_': 1 }
	let g:neosnippet#data_directory  = $VARPATH.'/snippet'
	let g:neosnippet#snippets_directory =
				\$VIMPATH.'/snippet,'
				\.$VARPATH.'/plugins/neosnippet-snippets/neosnippets,'
				\.$VARPATH.'/plugins/mpvim/snippets,'
				\.$VARPATH.'/plugins/vim-ansible-yaml/snippets,'
				\.$VARPATH.'/plugins/vim-go/gosnippets/snippets'

	imap <expr><C-o> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<ESC>o"

	call neobundle#untap()
endif

"}}}

if neobundle#tap('vim-signature') "{{{
	let g:SignatureMarkTextHLDynamic = 1
	let g:SignatureMarkerTextHLDynamic = 1
	let g:SignaturePurgeConfirmation = 1
	let g:signature_set_location_list_convenience_maps = 0
	let g:SignatureMap = {
		\ 'ListLocalMarks':    'm/',
		\ 'ListLocalMarkers':  'm?',
		\ 'Leader':            'm',
		\ 'PlaceNextMark':     'm,',
		\ 'ToggleMarkAtLine':  'm.',
		\ 'PurgeMarksAtLine':  'm-',
		\ 'DeleteMark':        'dm',
		\ 'PurgeMarks':        'm<Space>',
		\ 'PurgeMarkers':      'm<BS>',
		\ 'GotoNextSpotAlpha': 'mj',
		\ 'GotoPrevSpotAlpha': 'mk',
		\ 'GotoNextMarkerAny': 'mJ',
		\ 'GotoPrevMarkerAny': 'mK',
		\ 'GotoNextMarker': '',
		\ 'GotoPrevMarker': '',
		\ 'GotoNextLineAlpha': '',
		\ 'GotoPrevLineAlpha': '',
		\ 'GotoNextSpotByPos': '',
		\ 'GotoPrevSpotByPos': '',
		\ 'GotoNextLineByPos': '',
		\ 'GotoPrevLineByPos': ''
		\ }

	call neobundle#untap()
endif

"}}}

if neobundle#tap('vim-session') "{{{
	nmap <Leader>se :<C-u>SaveSession<CR>
	nmap <Leader>os :<C-u>OpenSession last<CR>

	let g:session_directory = $VARPATH.'/session'
	let g:session_default_name = 'last'
	let g:session_default_overwrite = 1
	let g:session_verbose_messages = 0
	let g:session_autosave = 'no'
	let g:session_autoload = 'no'
	let g:session_persist_colors = 0
	let g:session_command_aliases = 1
	let g:session_menu = 0
	call neobundle#untap()
endif

"}}}
if neobundle#tap('jedi-vim') "{{{
	setlocal completeopt=menuone,longest
	" let g:jedi#force_py_version = 3
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	let g:jedi#smart_auto_mappings = 0
	let g:jedi#use_tag_stack = 0
	let g:jedi#popup_select_first = 1
	let g:jedi#use_splits_not_buffers = 'right'
	let g:jedi#completions_command = ''
	let g:jedi#popup_on_dot = 0
	let g:jedi#max_doc_height = 40
	let g:jedi#show_call_signatures = 0
	let g:jedi#show_call_signatures_delay = 1000

	call neobundle#untap()
endif

"}}}


if neobundle#tap('vim-ruby') "{{{
	let g:rubycomplete_buffer_loading    = 1
	let g:rubycomplete_classes_in_global = 1
	let g:rubycomplete_rails             = 1

	call neobundle#untap()
endif

"}}}



if neobundle#tap('vim-gitgutter') "{{{
	let g:gitgutter_highlight_lines = 1
	let g:gitgutter_realtime = 1
	let g:gitgutter_eager    = 0
	let g:gitgutter_map_keys = 0

	call neobundle#untap()
endif

"}}}

" See https://github.com/preservim/vim-markdown
if neobundle#tap('vim-markdown') "{{{
	let g:vim_markdown_initial_foldlevel = 5
	let g:vim_markdown_frontmatter = 1
	let g:vim_markdown_conceal = 0
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_conceal_code_blocks = 0

	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-jinja') "{{{
	let g:htmljinja_disable_detection = 0

	call neobundle#untap()
endif

"}}}


if neobundle#tap('undotree') "{{{
	nnoremap <Leader>gu  :UndotreeToggle<CR>

	call neobundle#untap()
endif

"}}}

if neobundle#tap('caw.vim') "{{{
	autocmd MyAutoCmd FileType * call s:init_caw()
	function! s:init_caw()
		if ! &l:modifiable
			silent! nunmap <buffer> gc
			silent! xunmap <buffer> gc
			silent! nunmap <buffer> gcc
			silent! xunmap <buffer> gcc
			silent! nunmap <buffer> gcv
			silent! xunmap <buffer> gcv
		else
			nmap <buffer> gc <Plug>(caw:prefix)
			xmap <buffer> gc <Plug>(caw:prefix)
			nmap <buffer> gcc <Plug>(caw:wrap:toggle)
			xmap <buffer> gcc <Plug>(caw:wrap:toggle)
			nmap <buffer> gcv <Plug>(caw:I:toggle)
			xmap <buffer> gcv <Plug>(caw:I:toggle)
		endif
	endfunction

	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-indent-guides') "{{{
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_exclude_filetypes = ['help', 'unite', 'vimfiler']
	let g:indent_guides_default_mapping = 0
	let g:indent_guides_indent_levels = 10
	" nmap <silent><Leader>i :<C-u>IndentGuidesToggle<CR>

	if !has('nvim')
		function! neobundle#hooks.on_post_source(bundle)
			autocmd MyAutoCmd BufEnter *.py,*.js,*.rb if &expandtab
				\ |   IndentGuidesEnable
				\ | else
				\ |   IndentGuidesDisable
				\ | endif
		endfunction
	endif
	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-asterisk') "{{{
	map *   <Plug>(asterisk-*)
	map #   <Plug>(asterisk-#)
	map g*  <Plug>(asterisk-g*)
	map g#  <Plug>(asterisk-g#)
	map z*  <Plug>(asterisk-z*)
	map gz* <Plug>(asterisk-gz*)
	map z#  <Plug>(asterisk-z#)
	map gz# <Plug>(asterisk-gz#)
	call neobundle#untap()
endif

"}}}


if neobundle#tap('vim-quickrun') "{{{
  nmap <silent> <Leader>r <Plug>(quickrun)
  call neobundle#untap()
endif

"}}}
if neobundle#tap('dictionary.vim') "{{{
	nnoremap <silent> <Leader>? :<C-u>Dictionary -no-duplicate<CR>
	call neobundle#untap()
endif

"}}}

if neobundle#tap('vim-cursorword') "{{{
	augroup cursorword-filetype
		autocmd!
		autocmd FileType qf,vimfiler,vimshell,thumbnail,vimcalc,quickrun,github-dashboard
			\ let b:cursorword = 0
	augroup END

	call neobundle#untap()
endif

"}}}

if neobundle#tap('vimacs') "{{{
	let g:VM_Enabled=1
	call neobundle#untap()
endif

"}}}

if neobundle#tap('syntastic') "{{{
	let g:syntastic_always_populate_loc_list=1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_error_symbol='✗'
	let g:syntastic_warning_symbol='⚠'
	let g:syntastic_style_error_symbol = '✗'
	let g:syntastic_style_warning_symbol = '⚠'
	let g:syntastic_auto_loc_list=1
	let g:syntastic_aggregate_errors = 1
	let g:syntastic_python_checkers=['python', 'flake8']
	let g:syntastic_python_flake8_post_args='--ignore=W391'
	let g:syntastic_tex_chktex_showmsgs = 0
	let g:syntastic_auto_jump = 0
	let g:syntastic_check_on_wq = 0
	" let g:syntastic_disabled_filetypes=['tex']
	call neobundle#untap()
endif

"}}}

"  if neobundle#tap('UltiSnips') "{{{
"  	let g:UltiSnipsExpandTrigger="<tab>"
"  	let g:UltiSnipsJumpForwardTrigger="<tab>"
"  	let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"  	let g:UltiSnipsEditSplit="vertical"
"
"  	call neobundle#untap()
"  endif
"
" "}}}

if neobundle#tap('tagbar') "{{{
	let g:tagbar_autofocus = 1

	call neobundle#untap()
endif

"}}}



" vim: set ts=2 sw=2 tw=80 noet :
