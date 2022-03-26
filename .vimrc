set nocompatible

" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Chinese environment
set encoding=UTF-8
set fileencoding=UTF-8
set fileencodings=ucs-bom,UTF-8,cp936,gb18030,big5,latin1

" console code brek
language messages zh_CN.utf-8

set ambiwidth=double

colorscheme desert

set nu
"set cursorline
set autoread
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&ff}]\ [ft=%Y]\ [POS=%04l,%04v][%p%%]\ [%L]

"set ruler
" vimrc 文件修改自动生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

set noundofile
set nobackup
"set nowritebackup
"set noswapfile

set shiftwidth=4
set softtabstop=4
set expandtab

filetype plugin indent on

" 文件类型探测，然后根据文件类型进行自动缩进，制表符的设置
if has ("autocmd")
    au FileType sql    set shiftwidth=2 | set expandtab | set tabstop=2
    "au FileType sql    set shiftwidth=2 | set expandtab | set tabstop=2 | set fileencoding=cp936
    au FileType java   set shiftwidth=4 | set expandtab | set tabstop=4 | set autoindent | set smartindent
    au FileType python set shiftwidth=4 | set expandtab | set tabstop=4 | set autoindent | set smartindent
    au FileType js,htm,html,xml set shiftwidth=2 | set expandtab | set tabstop=2
    " bat文件的编码格式为cp936
    au FileType dosbatch set fileencoding=cp936 | set shiftwidth=4 | set expandtab | set fileencoding=cp936
endif

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

if has("win32")
    " menu code break
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " term
    set termencoding=cp936
endif

