set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/LanguageTool'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'morhetz/gruvbox'
" Install texlive-texcount for VimtexCountWords to work
Plugin 'lervag/vimtex'
Plugin 'ervandew/supertab'
Plugin 'kshenoy/vim-signature'
Plugin 'scrooloose/nerdcommenter'
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'terryma/vim-multiple-cursors'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Indent automatically depending on filetype
let g:tex_flavor='latex'
set autoindent
set cindent

" Turn on line numbering
set number

" Set syntax on
syntax on

" Case insensitive search
set ic

" Match search results while typing
set incsearch

" Ignore case insensitive search if upper case characters exist
set smartcase

" Higlhight search
set hls

" Completion
set wildmenu

" Wrap text instead of being on one line
set lbr

" Scroll when 8 lines from the bottom
set scrolloff=8

" Spell check + underline in tex files
" z= for suggestions
" [s and ]s for prev and next
autocmd BufNewFile,BufRead *.tex set spell spelllang=en_gb
autocmd BufNewFile,BufRead *.tex hi clear SpellBad
autocmd BufNewFile,BufRead *.tex hi SpellBad cterm=underline,bold ctermfg=red

" Latex autocomplete (with YouCompleteMe)
" https://github.com/Valloric/YouCompleteMe
" For Fedora:
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py
" NOTE: needs python-devel and cmake
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
			\ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
			\ ]

" Offline Thesaurus in LaTeX
" Ctrl x + Ctrl t (in insert mode)
autocmd BufNewFile,BufRead *.tex set thesaurus+=/usr/share/mythes/th_en_US_v2.dat
" For online Thesaurus hit \ + K

" Correct treatment of .tex files
let g:tex_flavor='latex'

" languagetool
" need to fetch languagetool-commandline and put it in a local dir
let g:languagetool_jar='$HOME/.languagetool-cmd/languagetool-commandline.jar'

" vim-airline
" also run: pip install --user powerline-status
" download powerline fonts, install them and use one of them in the terminal
" good option: Inconsolata-g for Powerline g 10
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" Make it always visible
set laststatus=2

let g:airline_theme = 'tomorrow'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" LaTeX syntax check
" texlive-chktex or texlive-lacheck is required
" lacheck seems to be better/less annoying
let g:syntastic_tex_checkers=['lacheck']

" Disable spell checking in LaTeX comments (makes text more readable)
let g:tex_comment_nospell= 1

" gruvbox theme
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox
hi Visual ctermbg=White ctermfg=DarkGray

" Correct colours
set t_Co=256

" Be able to switch beffers without saving
set hidden

" Mouse
set mouse=a

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL=~'bin/fish'
	set shell=/bin/zsh
endif

" Autosave if file exists
ino <C-C> <Esc>

if @% != "" && filereadable(@%) != 0
	au FocusLost,InsertLeave,TextChanged * :call AutoSave()
endif

" Highlight current line
set cursorline

" Smaller tab size
set tabstop=4
set shiftwidth=4

" \q redraws the screen and removes any search highlighting
nnoremap <silent> <leader>q :call ClearSearch()<cr>

" Allow per-file settings
set modeline

" Show tabs
set list
set listchars=tab:▸\ 

"""""""""""""
" Shortcuts "
"""""""""""""

" Easy buffer switching
nnoremap <silent> <C-l> :bnext<CR><C-l>
nnoremap <silent> <C-h> :bprevious<CR><C-h>

"""""""""""""
" Functions "
"""""""""""""

" Autosave
function! AutoSave()
	wa
	redraw
	SyntasticCheck
endfunc

" Indent file
function! Reindent()
	let cursor_position = getpos('.')
	normal! H
	let window_position = getpos('.')
	normal gg=G
	call setpos('.', window_position)
	normal! zt
	call setpos('.', cursor_position)
endfunc

nnoremap <silent> <leader>f :call Reindent()<cr>

" Clears the search and un-highlights the search results
function! ClearSearch()
	nohl
	let @/ = ""
endfunc

" Toggle between absolute and relative line numbering
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <C-a> :call NumberToggle()<cr>
