set nocompatible               " be iMproved
filetype off

"------------------------
"Neobundleの設定
"------------------------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif
" originalrepos on github

NeoBundleFetch 'Shougo/neobundle.vim'

"編集中のディレクトリ、ファイル閲覧用
NeoBundle 'scrooloose/nerdtree'

"ちょっとだけ実行して確認する
NeoBundle 'thinca/vim-quickrun'

"endを入れてくれるやつ
NeoBundle 'tpope/vim-endwise'

"猫が出てくる。癒やし。
NeoBundle 'drillbits/nyan-modoki.vim'

"非同期処理するためのプラグイン
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \ },
\ }

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on

"未インストール確認用
NeoBundleCheck
"------------------------
"ここまでneobunlde
"ここからset
"------------------------

syntax enable
set background=dark
colorscheme solarized

" タブ/インデントの設定

set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
"set expandtab     " タブ入力を複数の空白入力に置き換える


set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
"不可視文字の表示記号指定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮


" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う


" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない


" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする


"ヤンクでクリップボードにコピー
set clipboard=unnamedplus


"ここからnyan-modoki用
set laststatus=2
set statusline=%F%m%r%h%w[%{&ff}]%=%{g:NyanModoki()}(%l,%c)[%P]
let g:nyan_modoki_select_cat_face_number = 2
let g:nayn_modoki_animation_enabled= 1

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" """"""""""""""""""""""""""""""
" " 挿入モード時、ステータスラインの色を変更
" """"""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=black ctermbg=green cterm=none'

if has('syntax')
augroup InsertHook
  autocmd!
  autocmd InsertEnter * call s:StatusLine('Enter')
  autocmd InsertLeave * call s:StatusLine('Leave')
augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
    exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"QuickRun用
" runner/vimproc/updatetime で出力バッファの更新間隔をミリ秒で設定できます
" updatetime が一時的に書き換えられてしまうので注意して下さい
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}"

"キーバインド切り替え
nnoremap ww :<C-u>vs<CR> "垂直分割
nnoremap wh :<C-u>sp<CR> "水平分割
nnoremap wn <C-w>w "次のウィンドウに移動
nnoremap tt :<C-u>tabnew<CR> "新規タブ
nnoremap tn gt "次のタブへ切り替え
nnoremap tp gT "前のタブへ切り替え
nnoremap qr :QuickRun<CR> "QuickRunのショートカット
