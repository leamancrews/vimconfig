" general settings
filetype plugin indent on
colorscheme ron
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

call vundle#end()            " required
" end Vundle

" Statusline 
set laststatus=2
set statusline=
set statusline+=%1*
set statusline+=%{StatuslineMode()}
set statusline+=%2*
set statusline+=%9*
set statusline+=%=
set statusline+=%3*
set statusline+=%9*
set statusline+=%5*
set statusline+=%r
set statusline+=\ 
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=\ 
set statusline+=%c
set statusline+=\ 
set statusline+=%m
set statusline+=\ 
set statusline+=%F
set statusline+=\ 
set statusline+=%3*
set statusline+=\ 
set statusline+=%y
set statusline+=\ 
set statusline+=%2*
set statusline+=\ 
set statusline+=%{&ff}
set statusline+=\ 
set statusline+=%1*
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\ 
set statusline+=%9*
hi User1 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User2 ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
hi User9 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=lightcyan ctermfg=black guibg=lightcyan guifg=black
hi User5 ctermbg=lightyellow ctermfg=black guibg=lightyellow guifg=black

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

