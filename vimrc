" general settings
filetype plugin indent on
colorscheme pablo
set backspace=indent,eol,start
set nobackup            
set nowritebackup
set directory=~/.vim/swapfiles//
set undodir=~/.vim/undodir//
set undofile
set textwidth=0
set wrapmargin=0
set wrap linebreak nolist
set history=1000                
set ruler                       
set showcmd                     
set incsearch   
set number
set showmode    
set autoread            
set hidden              
set browsedir=buffer    
set wildmenu            
set guicursor=a:blinkon0
set visualbell          
set foldmethod=syntax
set foldcolumn=2
set hlsearch
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
syntax on
let mapleader = ','             
inoremap <S-CR> <Esc>

" Meta key and
" MacVim font
if has("gui_macvim")
  set macmeta 
  set guifont=Iosevka:h12
else
  let c='a'
  while c <= 'z'
    exec "set <M-".toupper(c).">=\e".c
    exec "imap \e".c." <M-".toupper(c).">"
    let c = nr2char(1+char2nr(c))
  endw
endif

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 50

" Change default 'new line' behavior
nnoremap o o<Esc>
nnoremap O O<Esc>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" W to save a file with sudo
command! W w !sudo tee % > /dev/null

" Vis command to visually
" select a range of lines
command! -range Vis call setpos('.', [0,<line1>,0,0]) |
                    \ exe "normal V" |
                    \ call setpos('.', [0,<line2>,0,0])

" Remove tabs
command! -bar -range=% RemoveTabs call s:remove_tabs(<line1>,<line2>)
function! s:remove_tabs(line1, line2) abort
    let view = winsaveview()
    let mods = 'sil keepj keepp'
    let range = a:line1 . ',' . a:line2
    let pat = '^\t\|\(.\)\t'
    let l:Rep = {-> submatch(1) . repeat(' ', strdisplaywidth("\t", col('.') == 1 ? 0 : virtcol('.') ))}
    let g = 0
    while search("\t", 'n') && g < 999
        exe mods . ' ' . range .'s/' . pat . '/\=l:Rep()/ge'
        let g += 1
    endwhile
    call winrestview(view)
endfunction

" Double-space to do find and replace of current word
nnoremap <Space><Space> :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Swap or transpose lines
function! s:Swap(a, b)
  execute a:a.'m'.a:b
endfunction

function! Transpose(a,b)
  call s:Swap(a:a,a:b)
  call s:Swap(a:b-1,a:a-1)
endfunction

command! -nargs=* Swap :call Transpose(<f-args>)
command! -range T :call Transpose(<line1>, <line2>)

" Leader key mappings
nnoremap <Leader>t :.! date<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :tabedit 
nnoremap <Leader>y "+y          
nnoremap <Leader>p "+p
nnoremap <Leader>d "+d
vnoremap <Leader>y "+y          
vnoremap <Leader>p "+p
vnoremap <Leader>d "+d
nnoremap <Leader>h :nohls<CR>
nnoremap <Leader>f zA<CR>
nnoremap <Leader>b :Vexplore<CR>
nnoremap <Leader>c :g/^\s*$/d<CR>
nnoremap <Leader>m :%s/^M//g<CR>
nnoremap <Leader>u :setlocal fenc=utf8<CR>

" start Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vimwiki install
Plugin 'vimwiki/vimwiki'

" fugitive install
Plugin 'tpope/vim-fugitive'

" abolish install
Plugin 'tpope/vim-abolish'

" lightline install
Plugin 'itchyny/lightline.vim'

" vadelma colorscheme
Plugin 'severij/vadelma'

call vundle#end()            " required
" end Vundle

let g:lightline = {
    \ 'colorscheme': 'one',
      \ }
