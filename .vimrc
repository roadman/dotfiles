set nu
set expandtab
set ts=4
set shiftwidth=2
set expandtab
set autoindent
set nocompatible
set list
set laststatus=2
set hlsearch
set virtualedit=block
syntax on

filetype off
" pathogen
"call pathogen#incubate()
call pathogen#incubate()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
"filetype on
filetype plugin indent on

au BufNewFile,BufRead *.go setf GO

vnoremap < <gv
vnoremap > >gv

nnoremap <ESC><ESC> :nohlsearch<CR>

" snippet
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" vim-shell
nnoremap <silent> <F9> :VimShellPop<CR>

" coffeescript compile
nnoremap <silent> <C-C> :CoffeeCompile watch vert<CR>

" vim-coffee-script
" autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

let g:treeExplHidden = 1

" vim-matchit
runtime macros/matchit.vim
let b:match_words = "if:endif"
let b:match_words = "<:>"

" vim-yankring
nnoremap <silent> <F7> :YRShow<CR>
let g:yankring_max_history = 10
let g:yankring_window_height = 13
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'

" buftabs
"バッファタブにパスを省略してファイル名のみ表示する(buftabs.vim)
let buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
"let buftabs_in_statusline=1
noremap <F2> :bprev<CR>
noremap <F3> :bnext<CR> 

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" bufexplorer
let bufExplorerDetailedHelp = 1
noremap <F8> :BufExplorerVerticalSplit<CR>

" vimfiler
"let vimfiler_as_default_explorer = 1

" vimdoc-ja
set helplang=ja

" statusline
set statusline=%F%m%r%h%w\ [%{&encoding}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
"行頭のスペースの連続をハイライトさせる
"Tab文字も区別されずにハイライトされるので、区別したいときはTab文字の表示を別に
"設定する必要がある。
function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf
"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call SOLSpaceHilight()
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif

" unite.vim setting
" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
"noremap <C-P> :Unite buffer file_mru file<CR>
" ファイル一覧
"noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <F5> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <F6> :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 初期設定関数を起動する
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
" Overwrite settings.
endfunction
" 様々なショートカット
call unite#custom#substitute('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#custom#substitute('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#custom#substitute('file', '^@', '\=getcwd()."/*"', 1)
call unite#custom#substitute('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#custom#substitute('file', '^\~', escape($HOME, '\'), -2)
call unite#custom#substitute('file', '\\\@<! ', '\\ ', -20)
call unite#custom#substitute('file', '\\ \@!', '/', -30)
if has('win32') || has('win64')
  call unite#custom#substitute('file', '^;p', 'C:/Program Files/')
  call unite#custom#substitute('file', '^;v', '~/vimfiles/')
else
  call unite#custom#substitute('file', '^;v', '~/.vim/')
endif

set rtp+=/usr/local/go/misc/vim
