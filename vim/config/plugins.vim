
" Plugin Settings
"---------------------------------------------------------

if neobundle#tap('neocomplete') && has('lua') "{{{
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#data_directory = $VARPATH.'/complete'
	let neobundle#hooks.on_source    = $VIMPATH.'/config/plugins/neocomplete.vim'

	call neobundle#untap()
endif

"}}}

if neobundle#tap('neosnippet.vim') "{{{
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
	let g:jedi#goto_command = '<leader>d'
	let g:jedi#goto_assignments_command = '<leader>a'
	let g:jedi#documentation_command = 'K'
	let g:jedi#rename_command = '<leader>r'
	let g:jedi#usages_command = '<leader>n'
	let g:jedi#popup_on_dot = 0
	let g:jedi#max_doc_height = 40
	let g:jedi#show_call_signatures = 0
	let g:jedi#show_call_signatures_delay = 1000
	call neobundle#untap()
endif

"}}}

if neobundle#tap('vim-gitgutter') "{{{
	let g:gitgutter_realtime = 1
	let g:gitgutter_eager    = 0
	let g:gitgutter_map_keys = 0

	nmap <Leader>hj <Plug>GitGutterNextHunk
	nmap <Leader>hk <Plug>GitGutterPrevHunk
	nmap <Leader>hs <Plug>GitGutterStageHunk
	nmap <Leader>hr <Plug>GitGutterRevertHunk
	nmap <Leader>hp <Plug>GitGutterPreviewHunk

	call neobundle#untap()
endif

"}}}

if neobundle#tap('vim-markdown') "{{{
	let g:vim_markdown_initial_foldlevel = 5
	let g:vim_markdown_frontmatter = 1
	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-jinja') "{{{
	let g:htmljinja_disable_detection = 0
	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-gita') "{{{
	nnoremap <silent> <leader>gs :<C-u>Gita status<CR>
	nnoremap <silent> <leader>gd :<C-u>Gita diff<CR>
	nnoremap <silent> <leader>gc :<C-u>Gita commit<CR>
	nnoremap <silent> <leader>gb :<C-u>Gita blame<CR>
	nnoremap <silent> <leader>gB :<C-u>Gita browse<CR>
	nnoremap <silent> <leader>gp :<C-u>Gita push<CR>
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
	let g:indent_guides_enable_on_vim_startup = 0
	let g:indent_guides_exclude_filetypes = ['help', 'unite', 'vimfiler']
	let g:indent_guides_default_mapping = 0
	let g:indent_guides_indent_levels = 10

	nmap <silent><Leader>i :<C-u>IndentGuidesToggle<CR>

	if !has('nvim')
		function! neobundle#hooks.on_post_source(bundle)
			autocmd MyAutoCmd BufEnter *.py,*.js if &expandtab
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
if neobundle#tap('incsearch.vim') "{{{
	let g:incsearch#auto_nohlsearch = 1

	map /  <Plug>(incsearch-forward)
	map ?  <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
	map n  <Plug>(incsearch-nohl-n)
	map N  <Plug>(incsearch-nohl-N)
	call neobundle#untap()
endif

"}}}
if neobundle#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
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





" vim: set ts=2 sw=2 tw=80 noet :
