" Pretty syntax hi-lighting.
syntax enable
" force vim to use 256 colors.
set t_Co=256
set background=dark
" solarized settings.
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256
let g:solarized_contrast = "high"
let g:solarized_visibility = "high"
colorscheme solarized

" Turn on filetype plugin & indent
filetype plugin indent on

" Map leader key to , instead of the default \
let mapleader = ","
let maplocalleader = ","

" Press F5 to go to pasting mode & F5 again to go back.
nnoremap <f5> :set invpaste paste?<Enter>
inoremap <f5> <c-O><F5>
set pastetoggle=<F5>

" Tabs. See http://tedlogan.com/techblog3.html for an explanation of what
" these means. Alternatively read ":help options".
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" navigation mappings
noremap <s-j> <pagedown>
noremap <s-k> <pageup>
noremap <s-l> <s-a>
noremap <s-h> <s-i>
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j

" Remap Esc to kj.
inoremap <esc> <nop>
inoremap kj <esc>

" Arrow keys no more.
noremap <left>  <nop>
noremap <right> <nop>
noremap <up>    <nop>
noremap <down>  <nop>

" Shortcuts for navigating between header, source & tests for C++.
" TODO: Need to be able to go to source/header from test files.
" See http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file for
" more ways of doing this.
" Also see :help filename-modifiers.
noremap <leader>es :e %:p:s,_test.cc$,.h,:s,.h$,.cc,<cr>
noremap <leader>eh :e %:p:s,_test.cc$,.cc,:s,.cc$,.h,<cr>
noremap <leader>et :e %<_test.cc<cr>

" Shortcuts to edit vimrc & source them
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Show line numbers by default.
set number
" Show matching brackets.
set showmatch
" How many tenths of a second to blink matching brackets.
set mat=5
" Fix the backspace problem.
set backspace=2

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

augroup formatting
  " Clears all previous autocmds within this group. This is so that
  " consecutive sourcing of the vimrc within an existing vim session doesn't
  " create duplicate autocmds. Duplicate autocmds means that the commands are
  " executed multiple times and hence making vim slower.
  autocmd!

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
    " Create mark before we sort.
    normal mz
    " Match from beginning of #include to the line before empty newline.
    g/^#include.*/,/^$/-1 sort
    " Go back to where we were before sorting.
    normal `z
  endfunction
  " Need to escape the | operator as well as ( in vim :(
  autocmd FileWritePre    *.\(cc\|h\) :call SortIncludeBlocks()
  autocmd FileAppendPre   *.\(cc\|h\) :call SortIncludeBlocks()
  autocmd BufWritePre     *.\(cc\|h\) :call SortIncludeBlocks()

  " Maps <localleader>c to comment current line.
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>

  " Abbreviations.
  " TODO: These don't work as I intended.
  "autocmd Filetype javascript iabbrev <buffer> iff if ()<left>
  "autocmd Filetype cpp iabbrev <buffer> iff if ()<left>
augroup END

" Cursor changes depending on mode.
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Work specific configuration
if filereadable(glob("~/workdotfiles/vimrc"))
  source ~/workdotfiles/vimrc
endif
