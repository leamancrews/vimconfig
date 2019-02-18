" general settings
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
set autoread		" reload changed files
set hidden		" better buffer management
set wildmenu
set guicursor=a:blinkon0
let mapleader = ','

" Leader key mappings
nnoremap <Leader>w :w<CR>
nnoremap <Leader>t :.! date<CR>
nnoremap <Leader>p "+p<CR>

" Vis function to visually
" select a range of lines
" Usage: :1,42Vis
command! -range Vis call setpos('.', [0,<line1>,0,0]) |
                    \ exe "normal V" |
                    \ call setpos('.', [0,<line2>,0,0])

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Syntax highlighting and highlight last search pattern
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" set fold method to syntax and foldcolumn
set foldmethod=syntax
set foldcolumn=2

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

	" abolish install
	Plugin 'tpope/vim-abolish'

	" pencil install
	Plugin 'reedes/vim-pencil'

	" airline install
	Plugin 'vim-airline/vim-airline'

	" macDictionary install
	Plugin 'johngrib/vim-mac-dictionary'

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

" airline customizations
let g:airline_highlighting_cache = 1
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z' ]
      \ ]

" MacDictionary mappings
nnoremap <C-p> :MacDictWord<CR>
nnoremap <C-S-p> :MacDictQuery<CR>

