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
set macmeta			" alt=meta in MacVim
set foldmethod=syntax
set foldcolumn=2
set hlsearch
syntax on
let mapleader = ','		
inoremap <S-CR> <Esc>

" Leader key mappings
nnoremap <Leader>o :tabedit 
nnoremap <Leader>w :w<CR>
nnoremap <Leader>t :.! date<CR>
vnoremap <Leader>y "+y		
nnoremap <Leader>p "+p
nnoremap <Leader>h :nohls<CR>
nnoremap <Leader>d :MacDictWord<CR>
nnoremap <Leader>q :MacDictQuery<CR>
nnoremap <Leader>f :TogglePencil<CR>

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

" pencil install
Plugin 'reedes/vim-pencil'

" airline install
Plugin 'vim-airline/vim-airline'

" macDictionary install
Plugin 'johngrib/vim-mac-dictionary'

" lexical install
Plugin 'reedes/vim-lexical'

" wordy install
Plugin 'reedes/vim-wordy'

" vim-misc install
Plugin 'xolox/vim-misc'

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

" lexical augroup
" Initialize lexical for defined filetypes
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

" Don't color directories in nnn
let g:nnn#command = 'nnn -C'

" airline customizations
let g:airline_highlighting_cache = 1
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z' ]
      \ ]

