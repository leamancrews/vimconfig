" general settings
filetype plugin indent on
colorscheme midnite
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
set wildmode=longest,list,full
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
  set guifont=Iosevka:h16
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

" Visual select line
nnoremap lv 0v$h

" W to save a file with sudo
command! W w !sudo tee % > /dev/null

" Vis command to visually
" select a range of lines
" Usage: :1,2Vis
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
" Usage: :1,2T
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
nnoremap <Leader>z zR<CR>
nnoremap <Leader>b :Vexplore<CR>
nnoremap <Leader>c :g/^\s*$/d<CR>
nnoremap <Leader>m :%s/^M//g<CR>
nnoremap <Leader>u :setlocal fenc=utf8<CR>
nnoremap <Leader>m g<C-G>

" start Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vimwiki install
Plugin 'vimwiki/vimwiki'

" tpope plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-surround'

" lightline install
Plugin 'itchyny/lightline.vim'

" Goyo plugin
Plugin 'junegunn/goyo.vim'

" Pencil plugin
Plugin 'reedes/vim-pencil'

" Raku syntax
Plugin 'Raku/vim-raku'

" colorschemes
Plugin 'severij/vadelma'
Plugin 'wojciechkepka/vim-github-dark'

call vundle#end()            " required
" end Vundle

" Lightline colorscheme
let g:lightline = {
    \ 'colorscheme': 'one',
      \ }

" Prose mode
let w:ProseModeOn = 0

function EnableProseMode()
    setlocal spell spelllang=en_us
    Goyo 66
    SoftPencil
    echo "Prose Mode On"
endfu

function DisableProseMode()
    Goyo!
    NoPencil
    setlocal nospell
    echo "Prose Mode Off"
endfu

function ToggleProseMode()
    if w:ProseModeOn == 0
        call EnableProseMode()
        let w:ProseModeOn = 1
    else
        call DisableProseMode()
    endif
endfu

command Prose call EnableProseMode()
command UnProse call DisableProseMode()
command ToggleProse call ToggleProseMode()

function ScratchBufferize()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfu

"Live word count
"Function from https://vim.fandom.com/wiki/Word_count
""Doesn't seem to work with Lightline; status line show word count only
"Need to include this in Prose mode only, where it would have the most use
let g:word_count=wordcount().words
function WordCount()
    if has_key(wordcount(),'visual_words')
        let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
    else
        let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
    endif
    return g:word_count
endfunction
"set statusline+=\ w:%{WordCount()},
"set laststatus=2 

nnoremap <Leader>D :new \| read ! sdcv <C-R><C-W> <CR>:call ScratchBufferize() <CR>:normal gg<CR>
nnoremap <Leader>T :new \| read ! moby <C-R><C-W> \| tr , '\n' <CR>:call ScratchBufferize() <CR>:normal gg2dd <CR>
