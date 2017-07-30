" -*- mode:vimrc; -*-
"===========================================================================
"  .vimrc -- my personal VIM configuration
"            see http://github.com/Falkor/dotfiles
"
"  Copyright (c) 2010-2017 Sebastien Varrette <Sebastien.Varrette@uni.lu>
"                                 _
"                          __   _(_)_ __ ___  _ __ ___
"                          \ \ / / | '_ ` _ \| '__/ __|
"                           \ V /| | | | | | | | | (__
"                          (_)_/ |_|_| |_| |_|_|  \___|
"
" Largely inspired: https://github.com/rafi/vim-config
"===========================================================================
" Note: Skip initialization for vim-tiny or vim-small.
if 1
	execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/vimrc'
endif
