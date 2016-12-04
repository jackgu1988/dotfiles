set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/LanguageTool'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
"Plugin 'morhetz/gruvbox'
" Install texlive-texcount for VimtexCountWords to work
Plugin 'lervag/vimtex'
Plugin 'kshenoy/vim-signature'
Plugin 'scrooloose/nerdcommenter'
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'terryma/vim-multiple-cursors'
" Install ctags
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
" Snippet support (next two plugins)
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'Yggdroot/indentLine'
Plugin 'Raimondi/delimitMate'
"Plugin 'NLKNguyen/papercolor-theme'
Plugin 'flazz/vim-colorschemes'
Plugin 'easymotion/vim-easymotion'
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

" Fix for sequences causing delay after ESC is pressed
set timeoutlen=1000 ttimeoutlen=10

" Spell check in tex files by default
autocmd BufNewFile,BufRead *.tex :call SpellCheckToggle(0)

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
			\ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
			\ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
			\ 're!\\hyperref\[[^]]*',
			\ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
			\ 're!\\(include(only)?|input){[^}]*',
			\ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
			\ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
			\ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
			\ ]

" Offline Thesaurus in LaTeX
" Ctrl x + Ctrl t (in insert mode)
autocmd BufNewFile,BufRead *.tex set thesaurus+=/usr/share/mythes/th_en_GB_v2.dat
" For online Thesaurus hit \ + K

" Correct treatment of .tex files
let g:tex_flavor='latex'

" languagetool
" need to fetch languagetool-commandline and put it in a local dir
let g:languagetool_jar='$HOME/.languagetool-cmd/languagetool-commandline.jar'

" vim-airline
" download powerline fonts, install them and use one of them in the terminal
" good option: Inconsolata-g for Powerline g 10
set guifont=Roboto\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" Make it always visible
set laststatus=2

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
let g:syntastic_style_error_symbol = "☠"
let g:syntastic_style_warning_symbol = '☢'

" LaTeX syntax check
" texlive-chktex or texlive-lacheck is required
" lacheck seems to be better/less annoying
let g:syntastic_tex_checkers=['lacheck']

" Disable spell checking in LaTeX comments (makes text more readable)
let g:tex_comment_nospell= 1

" vimtex clientserver
let g:vimtex_latexmk_callback='clientserver'

" Solarized theme
set background=dark
colorscheme base16-atelierlakeside
if has("gui_running")
	let g:airline_theme = 'base16_atelierlakeside'
	hi Search guifg=wheat
else
	let g:airline_theme = 'base16_tomorrow'
	hi Search cterm=NONE ctermfg=black ctermbg=yellow
endif

" Correct colours
set t_Co=256

" Be able to switch buffers without saving
set hidden

" Mouse
set mouse=a

" Redraw less
set lazyredraw

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL=~'bin/fish'
	set shell=/bin/zsh
endif

" Autosave if file exists
ino <C-C> <Esc>

if @% != "" && filereadable(@%) != 0
	au FocusLost,InsertLeave,TextChanged * nested call AutoSave()
endif

" Highlight current line
set cursorline " Removed if scrolling becomes very slow sometimes

" Smaller tab size
set tabstop=4
set shiftwidth=4

" \q redraws the screen and removes any search highlighting
nnoremap <silent> <leader>q :nohlsearch<Bar>:echo<CR> 

" Allow per-file settings
set modeline

" Show tabs
"set list
"set listchars=tab:▸\ 
set list lcs=tab:\|\ 

" Snippet configuration
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Tagbar categories for .tex files (also .ctags needs to exist in home)
let g:tagbar_type_tex = {
			\ 'ctagstype' : 'latex',
			\ 'kinds'     : [
			\ 's:sections',
			\ 'g:graphics:0:0',
			\ 'l:labels',
			\ 'r:refs:1:0',
			\ 'p:pagerefs:1:0'
			\ ],
			\ 'sort'    : 0,
			\ }

" NERDTree git symbols
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }

" Close vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" gVim specific stuff
if has('gui_running')
	nmap <C-V> "+gP
	imap <C-V> <ESC><C-V>i
	vmap <C-C> "+y
	" Hide the menu
	set guioptions-=T
endif

" Conceal level
setlocal conceallevel=2

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"""""""""""""
" Shortcuts "
"""""""""""""

" Easy buffer switching
nnoremap <silent> <C-l> :bnext<CR><C-l>
nnoremap <silent> <C-h> :bprevious<CR><C-h>

" Toggle tagbar
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>

" Close buffer
map <leader>bd :Bclose<cr>

" Indent long XML
" requires xmlindent application
au FileType xml setlocal equalprg=xmlindent\ -t\ 2>/dev/null

"""""""""""""
" Functions "
"""""""""""""

" Autosave
function! AutoSave()
	wa
	redraw
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

" Toggle between absolute and relative line numbering
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <C-x> :call NumberToggle()<cr>

" Toggle spell checking
" z= for suggestions
" [s and ]s for prev and next
function! SpellCheckToggle(lang_switch)
	let sp_lang = "en_gb"

	if(a:lang_switch == 1 && $spell_on == 1)
		if($default_lang != 0)
			let $default_lang = 0
			echom "English spell check enabled"
		else
			let sp_lang = "en_gb,el"
			let $default_lang = 1
			echom "Greek/English spell check enabled"
		endif
	endif

	if(($spell_on == 0 && a:lang_switch == 0) || (a:lang_switch == 1 && $spell_on == 1))
		exe "set spell spelllang=" . sp_lang
		"hi clear SpellBad
		"hi SpellBad cterm=underline,bold ctermfg=red ctermbg=9
		let $spell_on = 1
	else
		set nospell
		let $spell_on = 0
	endif
endfunc

nnoremap <silent> <F6> :call SpellCheckToggle(0)<cr>
nnoremap <silent> <F5> :call SpellCheckToggle(1)<cr>

" Change writing language between English and Greek
" Useful because vim wants English for its key-bindings
function! LanguageSwitch()
	if($default_lang != 0)
		set keymap=""
		let $default_lang = 0
		echom "English keyboard enabled"
	else
		set keymap=greek_utf-8
		let $default_lang = 1
		echom "Greek keyboard enabled"
	endif
endfunc

nnoremap <silent> <F4> :call LanguageSwitch()<cr>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction
