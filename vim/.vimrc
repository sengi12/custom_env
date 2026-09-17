" ~/.vimrc -- self-contained; plugins via vim-plug (auto-bootstrapped below).
"
" History: this used to source vitaly/dotvim (a Rails-era NeoBundle distro
" vendored under vim/.vim). That is gone. Kept from its bundle list: the
" general-purpose plugins below. Dropped: everything Ruby/Rails (vim-rails,
" vim-bundler, vim-rake, vim-ruby, vim-rspec, vim-ruby-refactoring,
" textobj-rubyblock, blockle, apidock, vim-i18n, vim-endwise), the web
" front-end syntaxes (coffee-script, literate-coffeescript, cjsx, slim,
" stylus, jade, less, haml, cucumber, mustache), the Clojure set (fireplace,
" clojure-static, rainbow_parentheses), and the Shougo unite/vimproc stack,
" NeoBundle itself, AutoComplPop, taglist, YankRing, snipmate, vim-align,
" ag.vim, greplace, splice, calendar, utl, VimOrganizer, gundo, switch,
" dispatch, emmet, vim-space, gist/webapi, and the colour schemes.
" syntastic is replaced by ALE, nerdcommenter by vim-commentary.

set nocompatible

" ---------------------------------------------------------------------------
" vim-plug bootstrap (https://github.com/junegunn/vim-plug)
" ---------------------------------------------------------------------------
let s:plug_file = expand('~/.vim/autoload/plug.vim')
if !filereadable(s:plug_file) && executable('curl')
  silent execute '!curl -fLo ' . shellescape(s:plug_file) . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable(s:plug_file)
  call plug#begin('~/.vim/plugged')
  " file tree
  Plug 'preservim/nerdtree'
  " fuzzy file / buffer / tag open
  Plug 'ctrlpvim/ctrlp.vim'
  " surroundings (cs"' ds( ysiw]) and comments (gcc, gc{motion})
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  " git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  " statusline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " async linting (was syntastic)
  Plug 'dense-analysis/ale'
  " auto-close quotes / brackets, indent guides, editorconfig, tmux panes
  Plug 'Raimondi/delimitMate'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'christoomey/vim-tmux-navigator'
  call plug#end()
endif

" ---------------------------------------------------------------------------
" baseline that used to come from dotvim's global.vim
" ---------------------------------------------------------------------------
syntax on
filetype plugin indent on

if has('multi_byte')
  scriptencoding utf-8
  set encoding=utf-8
endif

set number              " with rnu below this gives hybrid line numbers
set showcmd
set showmatch
set ruler
set wildmenu
set laststatus=2
set hidden
set autoread
set backspace=indent,eol,start
set smartcase
set ttimeoutlen=50
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
if has('persistent_undo')
  silent! call mkdir(expand('~/.vim/undo'), 'p')
  set undofile
  set undodir=~/.vim/undo
endif
runtime macros/matchit.vim

let mapleader = ","

" plugin settings carried over from dotvim's plugins.vim
nmap <C-P> :NERDTreeToggle<CR>
nmap <leader>p :NERDTreeFind<CR>
let g:ctrlp_map = '<leader>,'
let g:ctrlp_cmd = 'CtrlP'
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>l :CtrlPLine<cr>
let g:ctrlp_switch_buffer = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --exclude-standard -cod']
nmap <leader>g :silent Ggrep<space>
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'light'
set noshowmode
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" ---------------------------------------------------------------------------
" my settings (verbatim from the old vimrc)
" ---------------------------------------------------------------------------
set ttymouse=xterm2
set mouse=a

set rnu
set history=1000
set noswapfile

set ai "Auto indent"
set si "Smart indent"
set wrap "Wrap lines"

set linebreak
set cursorline
set cursorcolumn
highlight CursorColumn ctermfg=White ctermbg=DarkGrey cterm=bold guifg=white guibg=darkgrey gui=bold

set hlsearch
set ignorecase
set incsearch

set expandtab ts=2 sw=2
set smarttab
