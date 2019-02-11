set backspace=indent,eol,start
set nobackup		
set nowritebackup
set noswapfile  
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show line numbers
set showmode		" show current mode at the bottom
set autoread		" always reload changed files
set hidden		" better buffer management
set guicursor=a:blinkon0
let mapleader = ','
map Q gq

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv”

" Syntax highlighting and highlight last search pattern
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" set fold method to syntax 
set foldmethod=syntax

" autocmd group
if has("autocmd")

	filetype plugin indent on

	" start Vundle
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" nnn install
	Plugin 'mcchrish/nnn.vim'

	" vimwiki install
	Plugin 'vimwiki/vimwiki'

	" fugitive install
	Plugin 'tpope/vim-fugitive'

	" pencil install
	Plugin 'reedes/vim-pencil'

	" airline install
	Plugin 'vim-airline/vim-airline'

	call vundle#end()            " required
	" end Vundle

	" vimrcEx augroup
	  augroup vimrcEx
	  au!

	  " For all text files set textwidth to 80 characters.
	  autocmd FileType text setlocal textwidth=80

	  " When editing a file, always jump to the last known cursor position.
	  " Don't do it when the position is invalid or when inside an event handler
	  " (happens when dropping a file on gvim).
	  autocmd BufReadPost *
	    \ if line("'\"") > 0 && line("'\"") <= line("$") |
	    \   exe "normal g`\"" |
	    \ endif

	  augroup END

	" pencil augroup
	" Initialize pencil for defined filetypes
	augroup pencil
	  autocmd!
	  autocmd FileType markdown,mkd call pencil#init()
	  autocmd FileType text         call pencil#init()
	augroup END

else

  	set autoindent		" autoindenting without autocmd

endif 
" end autocmd group

" Use dark background and ron colorscheme
set bg=dark
colo ron

" Don't color directories in nnn
let g:nnn#command = 'nnn -C'

" Cache syntax highlighting groups
" For better airline performance
let g:airline_highlighting_cache = 1

