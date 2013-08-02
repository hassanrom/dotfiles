" Pretty syntax hi-lighting.
syntax enable
set background=dark
colorscheme solarized

" Press F5 to go to pasting mode & F5 again to go back.
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

set softtabstop=2
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
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

set number " we want line numbers by default.
set showmatch " show matching brackets.
set mat=5 " how many tenths of a second to blink matching brackets.
" fix the backspace problem
set backspace=2

" Trim Trailing Whitespace
" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Cursor changes depending on mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
