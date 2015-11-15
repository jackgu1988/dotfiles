set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'abap'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Pathogen
"" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
"" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()

" Indent automatically depending on filetype
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
set autoindent

" Turn on line numbering. Turn it off with "set nonu" 
set number

" Set syntax on
syntax on

" Case insensitive search
set ic

" Higlhight search
set hls

" Wrap text instead of being on one line
set lbr

" Change colorscheme from default to solarized
"" cd ~/.vim/bundle
"" git clone git://github.com/altercation/vim-colors-solarized.git
" set background=dark
" colorscheme solarized

" Spell check + underline in tex files
" z= for suggestions
" [s and ]s for prev and next
autocmd BufNewFile,BufRead *.tex set spell spelllang=en_gb
autocmd BufNewFile,BufRead *.tex hi clear SpellBad
autocmd BufNewFile,BufRead *.tex hi SpellBad cterm=underline,bold ctermfg=red

" Background colour
highlight Normal ctermfg=grey ctermbg=black
highlight Normal ctermfg=grey ctermbg=black

" Thesaurus in latex
" Ctrl x + Ctrl t (in insert mode)
autocmd BufNewFile,BufRead *.tex set thesaurus+=/usr/share/mythes/th_en_US_v2.dat
