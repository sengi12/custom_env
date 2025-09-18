" content of this file is loaded BEFORE all the plugins
source ~/.vim/bundles.vim  " vundle plugins list
source ~/.vim/global.vim   " general global configuration
source ~/.vim/plugins.vim  " configuration for plugins that needs to be set BEFORE plugins are loaded
source ~/.vim/macros.vim   " some macros
"if has('gui_running')
  "source ~/.vim/gvimrc     " gui specific settings
"end

"source ~/.vim/before.vim   " local BEFORE configs

" after.vim is loaded from ./after/plugin/after.vim
" which should place it AFTER all the other plugins in the loading order
" bindings.vim and local.vim are loaded from after.vim

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

