" Maintainer:	Jesse Linthorst (jesse.linthorst@gmail.com)
" Last change:	2014 Feb 01
"

"{{{ Pathogen plugin manager

	execute pathogen#infect()

"}}}

"{{{ Default .vimrc by Bram Moolenaar

	" When started as "evim", evim.vim will already have done these settings.
	if v:progname =~? "evim"
	  finish
	endif

	" Use Vim settings, rather than Vi settings (much better!).
	" This must be first, because it changes other options as a side effect.
	set nocompatible

	" allow backspacing over everything in insert mode
	set backspace=indent,eol,start

	set history=1000		" keep 500 lines of command line history
	set ruler				" show the cursor position all the time
	set showcmd				" display incomplete commands
	set incsearch			" do incremental searching

	" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
	" let &guioptions = substitute(&guioptions, "t", "", "g")

	" Don't use Ex mode, use Q for formatting
	map Q gq

	" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
	" so that you can undo CTRL-U after inserting a line break.
	inoremap <C-U> <C-G>u<C-U>

	set mouse=a

	set hlsearch

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Enable autocompletion
	set ofu=syntaxcomplete#Complete

	" Set syntax higlighting on
	syntax on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

	augroup END

	"set autochdir
	set autoindent		" always set autoindenting on


	" Convenient command to see the difference between the current buffer and the
	" file it was loaded from, thus the changes you made.
	" Only define it when not defined already.
	if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
			\ | wincmd p | diffthis
	endif
	"}}}

"{{{ User settings

	" Map leader to , instead of \
	let mapleader = ","

	" Set encoding default to utf-8
	set encoding=utf-8

	" Use nicer font for Airline
	set guifont=Droid\ Sans\ Mono\ for\ Powerline
	let g:airline_powerline_fonts = 1

	" Use Ctrl + J instead of TAB (so it does not interfere with acm)
	:imap <C-J> <Plug>snipMateNextOrTrigger
	:smap <C-J> <Plug>snipMateNextOrTrigger

	" Show invisible chars
	set list
	set listchars=tab:▸\ ,eol:¬

	" Split windows in logical position
	set splitbelow
	set splitright

	" Backup settings
	set backup
	set backupdir=$HOME/.vim/backup
	set directory=$HOME/.vim/tmp
	set background=dark

	" Tab sizes
	set smarttab
	set tabstop=4
	set shiftwidth=4

	" Auto en Smart indenting enabled
	set smartindent
	set preserveindent

	" Don't expand tab to spaces
	set noexpandtab

	" Linewidth to Endless
	set textwidth=0
" Do not wrap lines automatically set nowrap

	" Show line numbers by default
	set number

	" Jump 5 lines when running out of the screen
	set scrolljump=5

	" Indicate jump out of the screen when 3 lines before the end of the screen
	set scrolloff=3

	" Map <CTRL>-B to run PHP parser check
	noremap <C-B> :!php -l %<CR>

	" Ignore cases in searches
	set ignorecase

	" And so is Artificial Intellegence!
	set smartcase

	" Show matching brackets
	set showmatch

	" Remove any trailing whitespace that is in the file
	autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

	" Show what commands you're executing
	set showcmd

	" Folding Stuffs
	set foldmethod=marker

	" Cool tab completion stuff
	set wildmenu
	set wildmode=list:longest,full

	" When I close a tab, remove the buffer
	set nohidden

	" Give the submenu a other color
	hi Pmenu guifg=#f6f3e8 guibg=#444444 gui=NONE ctermfg=white ctermbg=darkgray cterm=NONE
	hi PmenuSel guifg=#000000 guibg=#cae682 gui=NONE ctermfg=black ctermbg=lightgreen cterm=NONE

	"  Match tab
	syntax match Tab /\t/
	hi Tab gui=underline guifg=blue ctermbg=blue

	" Set colorscheme
	colorscheme wombat256mod

" }}}

"{{{ Autocmd

	"open a NERDTree automatically when vim starts up if no files were
	" autocmd vimenter * if !argc() | NERDTree | endif

	" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" SASS Syntax
	autocmd BufRead,BufNewFile *.scss set filetype=scss

	" NERDTree show me hidden files!
	" let NERDTreeShowHidden=1

	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow

	"}}}
"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}


"{{{ Mappings

	let mapleader = ","
	" Learn ViM my apprentice!
	nnoremap <up> <nop>
	nnoremap <down> <nop>
	nnoremap <left> <nop>
	nnoremap <right> <nop>
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>


	" Create a new line
	nmap <S-Enter> O<Esc>j
	nmap <CR> o<Esc>k

	" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
	inoremap jj <Esc>
	inoremap jk <Esc>
	nnoremap JJJJ <Nop>
	imap ` <Esc>

	" tab navigation like firefox
	nnoremap <C-h> :tabprevious<CR>
	nnoremap <C-l> :tabnext<CR>
	nnoremap <C-t> :tabnew<CR>
	inoremap <C-h> <Esc>:tabprevious<CR>i
	inoremap <C-l> <Esc>:tabnext<CR>i
	inoremap <C-t> <Esc>:tabnew<CR>

	" Space will toggle folds!
	nnoremap <space> za

	" Swap ; and :  Convenient.
	nnoremap ; :
	nnoremap : ;

	" Paste Mode!  Dang! <F10>
	nnoremap <silent> <F10> :call Paste_on_off()<CR>
	set pastetoggle=<F10>

	" NerdTreeToggler!
	" nnoremap <F2> :NERDTreeToggle<CR>
	" open Nerd Tree in folder of file in active buffer
	" nnoremap <Leader>nt :NERDTree %:p:h<CR>

" }}}
