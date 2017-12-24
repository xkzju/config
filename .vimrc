" Basic Settings ---------- {{{
set nocompatible
set number
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent
set cc=0
set noswapfile
set nobackup
set encoding=utf-8
set hlsearch
set incsearch
set splitbelow
set splitright
set autoindent
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=

syntax on
if exists('$TMUX')
      set term=screen-256color
endif

filetype plugin indent on
filetype plugin on

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" comment background color
hi Comment ctermfg = 15
hi LineNr ctermfg = 7

let mapleader=","
let maplocalleader=","

" edit and load .vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo 'refresh ~/.vimrc'<cr>
" }}}

" Key Mappings ---------- {{{

" go to the tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt

" remove highlight on search results
nnoremap <leader><space> :nohlsearch<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" escape to normal mode
inoremap jk <esc>
vnoremap jk <esc>
vnoremap <esc> <nop>
inoremap <esc> <nop>

" disable arrow keys
inoremap <Up> <nop>
nnoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Down> <nop>
inoremap <Left> <nop>
nnoremap <Left> <nop>
inoremap <Right> <nop>
nnoremap <Right> <nop>

" remap navigation in line
nnoremap H ^
nnoremap L $
" }}}

" Installed Plugins ---------- {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'

Plugin 'w0rp/ale'
Plugin 'python-mode/python-mode'
Plugin 'google/yapf'
Plugin 'maralla/completor.vim'
Plugin 'timothycrosley/isort'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on
" }}}

" Plugin Settings ---------- {{{
" completor
" let g:completor_auto_close_doc = 0

" nerdcommenter
let g:NERDSpaceDelims=1
" <leader>cc   加注释
" <leader>cu   解开注释
" <leader>c<space>  加上/解开注释, 智能判断

" ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" ale
let g:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_flake8_args="--ignore=E501"
let g:ale_python_flake8_options='--ignore=E501'
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_format = '[#%linter%#][%severity%] %s '
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']
let g:ale_echo_msg_error_str = '✹ Error'
let g:ale_echo_msg_warning_str = '⚠ Warning'
let g:ale_keep_list_window_open = 0
let g:ale_open_list = 0
nmap <Leader>en <Plug>(ale_next)
nmap <Leader>ep <Plug>(ale_previous)
nnoremap <Leader>ts :ALEToggle<CR>
" }}}

" Quick run via <F5> ---------- {{{
nnoremap <F5> :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction
" }}}

" FileType-specific settings ---------- {{{
" vim group
augroup vimgroup
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end

" python group
augroup pythongroup
    autocmd!
    autocmd FileType python setlocal cc=0
"    autocmd FileType python setlocal foldmethod=indent
"    autocmd FileType python setlocal foldlevel=99
    autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR>
    autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
augroup end 
" }}}

" Operator-Pending Mappings ---------- {{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>
" }}}
