" general settings
filetype plugin indent on
colo ron
set backspace=indent,eol,start
set nobackup		
set nowritebackup
set directory=~/.vim/swapfiles//
set undodir=~/.vim/undodir
set undofile
set textwidth=0
set wrapmargin=0
set wrap linebreak nolist
set history=1000		" keep 1000 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching
set number			" show line numbers
set showmode			" show current mode at the bottom
set autoread			" reload changed files
set hidden			" better buffer management
set browsedir=buffer		" in GUI, File->Open at current directory
set wildmenu			" show tab completions
set guicursor=a:blinkon0	" no blinking cursor in GUI
set visualbell			" no beeping
set guifont=Iosevka:h12
set foldmethod=syntax
set foldcolumn=2
set hlsearch
syntax on
let mapleader = ','		
inoremap <S-CR> <Esc>

" Meta key
if has("gui_macvim")
  set macmeta 
else
  let c='a'
  while c <= 'z'
    exec "set <M-".toupper(c).">=\e".c
    exec "imap \e".c." <M-".toupper(c).">"
    let c = nr2char(1+char2nr(c))
  endw
endif

" Leader key mappings
nnoremap <Leader>o :tabedit 
nnoremap <Leader>w :w<CR>
nnoremap <Leader>t :.! date<CR>
nnoremap <Leader>y "+y		
nnoremap <Leader>p "+p
nnoremap <Leader>d "+d
vnoremap <Leader>y "+y		
vnoremap <Leader>p "+p
vnoremap <Leader>d "+d
nnoremap <Leader>h :nohls<CR>

" Vis command to visually
" select a range of lines
command! -range Vis call setpos('.', [0,<line1>,0,0]) |
                    \ exe "normal V" |
                    \ call setpos('.', [0,<line2>,0,0])

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" W to save a file with sudo
command! W w !sudo tee % > /dev/null

" start Vundle
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

" airline install
Plugin 'vim-airline/vim-airline'

" wordy install
Plugin 'reedes/vim-wordy'

" sessionman install
Plugin 'vim-scripts/sessionman.vim'

" yankstack install
Plugin 'maxbrunsfeld/vim-yankstack'

call vundle#end()            " required
" end Vundle

" Don't color directories in nnn
let g:nnn#command = 'nnn -C'

" airline customizations
let g:airline_highlighting_cache = 1
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z' ]
      \ ]

