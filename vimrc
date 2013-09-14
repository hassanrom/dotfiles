" Pretty syntax hi-lighting.
syntax enable
" force vim to use 256 colors.
set t_Co=256
set background=dark
" solarized settings.
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" Turn on filetype plugin & indent
filetype plugin indent on

" Press F5 to go to pasting mode & F5 again to go back.
nnoremap <F5> :set invpaste paste?<Enter>
inoremap <F5> <C-O><F5>
set pastetoggle=<F5>

" Tabs. See http://tedlogan.com/techblog3.html for an explanation of what
" these means. Alternatively read ":help options".
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" navigation mappings
noremap <S-j> <PageDown>
noremap <S-k> <PageUp>
noremap <S-l> <S-a>
noremap <S-h> <S-i>
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j

" Remap Esc to kj.
inoremap <Esc> <NOP>
inoremap kj <Esc>

" Arrow keys no more.
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

" Disable shift-v so that I just use v instead.
nnoremap <S-v>  <NOP>

" Show line numbers by default.
set number
" Show matching brackets.
set showmatch
" How many tenths of a second to blink matching brackets.
set mat=5
" Fix the backspace problem.
set backspace=2

" Highlight searches & press space to turn off highlighting and clear any
" message already displayed.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Disable beep and flash.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Mouse support within tmux.
if has("mouse")
  " Enable mouse mode except in insert mode. Clicking in insert mode gives us
  " garbage!
  set mouse=nvch
  set mousehide
  if &term =~ '^screen'
    "tmux knows the extended mouse mode
    set ttymouse=xterm2
  endif
endif

" Statusline. Copied shamelessly from
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Trim trailing whitespace.
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Sort #include blocks.
function! SortIncludeBlocks()
  g/^#include.*/,/^#include.*$\n^$/ sort
endfunction

" Cursor changes depending on mode.
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Map leader key to , instead of the default \
let mapleader = ","

" Work specific configuration
if filereadable(glob("~/workdotfiles/vimrc"))
  source ~/workdotfiles/vimrc
endif
