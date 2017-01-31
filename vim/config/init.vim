
" Vim Initialization
" ------------------

" Global Mappings "{{{
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader="\<Space>"
let g:maplocalleader=','

" Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>

" }}}

" XDG and Vim directory Settings "{{{
" mkdir -p "$(XDG_CACHE_HOME)/vim/"{backup,session,swap,tags,undo,view,notes}; "
for vimdir in ['swap', 'backup', 'undo', 'plugins', 'shada', 'viminfo']
  " swap: swp files, stored in directory
  " backup .bak files, stored in backupdir
  if !isdirectory($VARPATH . vimdir)
    call mkdir(   $VARPATH . vimdir, "p")
  endif
endfor
if has('nvim')
	set shada='30,/100,:50,<10,@10,s50,h,n$VARPATH/shada
else
	set viminfo='30,/100,:500,<10,@10,s10,h,n$VARPATH/viminfo
endif

set undofile swapfile nobackup
set directory=$VARPATH/swap//,$VARPATH,~/tmp,/var/tmp,/tmp
set undodir=$VARPATH/undo//,$VARPATH,~/tmp,/var/tmp,/tmp
set backupdir=$VARPATH/backup/,$VARPATH,~/tmp,/var/tmp,/tmp
set viewdir=$VARPATH/view/
set nospell spellfile=$VIMPATH/spell/en.utf-8.add


" Don't backup files in temp directories or shm
if exists('&backupskip')
	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
endif

" Don't keep swap files in temp directories or shm
augroup swapskip
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal noswapfile
augroup END

" Don't keep undo files in temp directories or shm
if has('persistent_undo')
	augroup undoskip
		autocmd!
		silent! autocmd BufWritePre
			\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
			\ setlocal noundofile
	augroup END
endif

" Don't keep viminfo for files in temp directories or shm
augroup viminfoskip
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal viminfo=
augroup END

set viminfo+=n$VARPATH/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
" }}}

" Set augroup "{{{
augroup MyAutoCmd
	autocmd!
augroup END

" }}}
" Load vault settings "{{{
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

" }}}
" Setup NeoBundle "{{{
let s:plugins_dir = expand('$VARPATH/plugins')
"let g:neobundle#types#git#default_protocol = 'https'

if has('vim_starting')
	if isdirectory($XDG_CONFIG_HOME.'/vim')
		" Respect XDG
		let $MYVIMRC=expand('$XDG_CONFIG_HOME/vim/vimrc')
		set runtimepath=$VIMPATH,$VIM/vimfiles,$VIMRUNTIME
	endif

	" Load NeoBundle for package management
	if &runtimepath !~? '/neobundle.vim'
		if ! isdirectory(s:plugins_dir.'/neobundle.vim')
        " Clone NeoBundle if not found
        echo "Installing NeoBundle..."
        echo " "
        execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
        \ (exists('$http_proxy') ? 'https' : 'git'))
        \ s:plugins_dir.'/neobundle.vim'
    endif

    execute 'set runtimepath^='.s:plugins_dir.'/neobundle.vim'
endif

" Load minimal version of vim while SSHing
if len($SSH_CLIENT)
    let $VIM_MINIMAL = 1
endif
endif

" }}}
" Disable default plugins "{{{

" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif

" Disable pre-bundled plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_gzip = 1
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
