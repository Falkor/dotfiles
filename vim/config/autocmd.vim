
" File Types {{{
"-------------------------------------------------
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" authorize change of line using left/right arrow
set whichwrap=<,>,[,]


"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"" always delete trailing whitespace UNLESS it's a markdown file
"" The function :FixWhitespace comes from NeoBundle bronson/vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = [ 'md' ]
autocmd BufWritePre * :FixWhitespace


augroup MyAutoCmd

	" Update filetype on save if empty
	autocmd BufWritePost *
				\ if &l:filetype ==# '' || exists('b:ftdetect')
				\ |   unlet! b:ftdetect
				\ |   filetype detect
				\ | endif

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType gitcommit setlocal spell

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	" Improved include pattern
	autocmd FileType html
				\ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
				\ setlocal path+=./;/

	autocmd FileType markdown
				\ setlocal spell expandtab autoindent
					\ formatoptions=tcroqn2 comments=n:>

	autocmd FileType apache setlocal path+=./;/

	autocmd FileType cam setlocal nonumber synmaxcol=10000

	autocmd FileType go highlight default link goErr WarningMsg |
				\ match goErr /\<err\>/

	autocmd FileType python
		\ if has('python') || has('python3') |
		\   setlocal omnifunc=jedi#completions |
		\ else |
		\   setlocal omnifunc= |
		\ endif
	autocmd BufWritePost ~/.vim/doc/* :helptags ~/.vim/doc

augroup END

" vim-python
augroup vimrc-python
	autocmd!
	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
	\ formatoptions+=croq softtabstop=4 smartindent
	\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" }}}
" Internal Plugin Settings " {{{
" ------------------------

" PHP "{{{
let g:PHP_removeCRwhenUnix = 0

" }}}
" Python "{{{
let g:python_highlight_all = 1

" }}}
" Vim "{{{
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0

" }}}
" Bash "{{{
let g:is_bash = 1

" }}}
" Java "{{{
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1

" }}}
" JavaScript "{{{
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" }}}

" Ruby "{{{
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END
let g:tagbar_type_ruby = {
  \ 'kinds' : [
  \ 'm:modules',
  \ 'c:classes',
  \ 'd:describes',
  \ 'C:contexts',
  \ 'f:methods',
  \ 'F:singleton methods'
  \ ]
\ }

" }}}

" Markdown "{{{
let g:markdown_fenced_languages = [
	\  'coffee',
	\  'css',
	\  'erb=eruby',
	\  'javascript',
	\  'js=javascript',
	\  'json=javascript',
	\  'ruby',
	\  'sass',
	\  'xml',
	\  'vim'
	\]

" }}}
" }}}
" vim: set ts=2 sw=2 tw=80 noet :
