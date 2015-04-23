" Pretty syntax hi-lighting.
syntax enable
set background=dark

" solarized settings.
let g:solarized_termcolors = 16
let g:solarized_bold = 0
let g:solarized_termtrans = 1
"let g:solarized_contrast = "high"
"let g:solarized_visibility = "high"
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

" Show tabs, trailing whitespaces, wrap markers.
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" No swap & backup files. I save plenty.
set nobackup
set noswapfile

" navigation mappings
noremap <s-j> <pagedown>
noremap <s-k> <pageup>
noremap <s-l> <s-a>
noremap <s-h> <s-i>

" Seamlessly navigate between vim & tmux panes.
" Credit goes to https://github.com/aaronjensen & this post
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html for
" this wonderful tip.
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <c-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <c-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <c-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <c-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  nnoremap <c-l> <c-w>l
  nnoremap <c-h> <c-w>h
  nnoremap <c-k> <c-w>k
  nnoremap <c-j> <c-w>j
endif

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
nnoremap <leader>es :e %:p:s,_test.cc$,.h,:s,.h$,.cc,<cr>
nnoremap <leader>eh :e %:p:s,_test.cc$,.cc,:s,.cc$,.h,<cr>
nnoremap <leader>et :e %:p:s,_test.cc$,.cc,:s,.h$,.cc,:s,.cc$,_test.cc,<cr>

" Shortcuts to edit vimrc & source them
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ew :vsplit ~/workdotfiles/vimrc<cr>

" Shortcuts to list files in the current directory.
nnoremap <leader>ls :Ex<cr>

" Yank WORD to system clipboard in normal mode.
nnoremap <leader>y "+yE

" Yank selection to system clipboard in visual mode.
vnoremap <leader>y "+y

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
    " Save cursor & window view before we sort.
    let l:winview = winsaveview()
    " Match from beginning of #include to the line before empty newline.
    g/^#include.*/,/^$/-1 sort
    " Restore cursor position & window view
    call winrestview(l:winview)
  endfunction
  " Need to escape the | operator as well as ( in vim :(
  autocmd FileWritePre    *.\(cc\|h\) :call SortIncludeBlocks()
  autocmd FileAppendPre   *.\(cc\|h\) :call SortIncludeBlocks()
  autocmd BufWritePre     *.\(cc\|h\) :call SortIncludeBlocks()

  " Maps <localleader>c to comment current line.
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>

  " Maps <localleader>p to preview markdown file on chrome.
  " Assumes that your browser has an extension to view markdown file as HTML such
  " as this one:
  " https://chrome.google.com/webstore/detail/markdown-preview/jmchmkecamhbiokiopfpnfgbidieafmd
  " autocmd FileType markdown nnoremap <buffer> <localleader>p :!google-chrome-stable %:p<cr>

  " Enable auto formatting paragraph in markdowns. See :help auto-format for
  " more info.
  " TODO: Add 'c' to formatoptions to enable auto formatting of comments
  " in source codes.
  " autocmd FileType markdown setlocal formatoptions=aw2tq

  " Abbreviations.
  " TODO: These don't work as I intended.
  "autocmd Filetype javascript iabbrev <buffer> iff if ()<left>
  "autocmd Filetype cpp iabbrev <buffer> iff if ()<left>

  " Sometimes the screen screws up after saving.
  autocmd BufWritePost * :redraw!

  " 2 space tabs in go.
  autocmd FileType go set shiftwidth=2|set noexpandtab|set tabstop=2
augroup END

" Cursor changes depending on mode.
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" A trick by Steve Losh to use w!! to sudo & write a file with vim
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap w!! w !sudo tee % >/dev/null

" Bundle plugins.
if filereadable(glob("~/.vim/bundle.vim"))
  source ~/.vim/bundle.vim
endif

" Work specific configuration
if filereadable(glob("~/workdotfiles/vimrc"))
  source ~/workdotfiles/vimrc
endif

""""""""""""""""""""""""""
" GnuPG Extensions
" Copied from http://pig-monkey.com/2013/04/4/password-management-vim-gnupg/.
" TODO: Only run the following if a gpg file.
""""""""""""""""""""""""""

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
  " Set extra file options.
  autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
  " Automatically close unmodified files after inactivity.
  " autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
  " Set updatetime to 1 minute.
  set updatetime=60000
  " Fold at markers.
  set foldmethod=marker
  " Automatically close all folds.
  set foldclose=all
  " Only open folds with insert commands.
  set foldopen=insert
endfunction
