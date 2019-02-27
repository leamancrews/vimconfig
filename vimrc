" general settings
filetype plugin indent on
colo ron
set backspace=indent,eol,start
set nobackup		
set nowritebackup
set noswapfile  
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
" set macmeta			" alt=meta in MacVim
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
vnoremap <Leader>y "+y		
nnoremap <Leader>p "+p
nnoremap <Leader>h :nohls<CR>
nnoremap <Leader>d :MacDictWord<CR>
nnoremap <Leader>q :MacDictQuery<CR>
nnoremap <Leader>f :set wrap linebreak nolist<CR>

" Vis command to visually
" select a range of lines
" Usage: :1,42Vis
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

" macDictionary install
Plugin 'johngrib/vim-mac-dictionary'

" wordy install
Plugin 'reedes/vim-wordy'

" sessionman install
Plugin 'vim-scripts/sessionman.vim'

" yankstack install
Plugin 'maxbrunsfeld/vim-yankstack'

call vundle#end()            " required
" end Vundle

" vimrcEx augroup
augroup vimrcEx
   au!

   " For all text files set textwidth to 74 characters.
   autocmd FileType text setlocal textwidth=74
  
" Don't color directories in nnn
let g:nnn#command = 'nnn -C'

" airline customizations
let g:airline_highlighting_cache = 1
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z' ]
      \ ]

