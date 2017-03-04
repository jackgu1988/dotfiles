set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-scripts/LanguageTool'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
" Install texlive-texcount for VimtexCountWords to work
Plugin 'lervag/vimtex'
Plugin 'kshenoy/vim-signature'
Plugin 'scrooloose/nerdcommenter'
Plugin 'beloglazov/vim-online-thesaurus'
" Install ctags
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
" Snippet support (next two plugins)
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
Plugin 'flazz/vim-colorschemes'
Plugin 'python-mode/python-mode'
Plugin 'sheerun/vim-polyglot'
Plugin 'sjl/gundo.vim'
Plugin '907th/vim-auto-save'
" Notes + dependencies
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
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

let g:tex_flavor='latex'

set number       " Turn on line numbering
set ic           " Case insensitive search
set smartcase    " Ignore case insensitive search if upper case characters exist
set laststatus=2 " Make airline always visible
set hidden       " Be able to switch buffers without saving
set mouse=a      " Enable mouse
set lazyredraw   " Redraw less
set cursorline   " Highlight current line (may make vim slow)
set modeline     " Allow per-file settings
set tabstop=4    " Smaller tab size
set shiftwidth=4 " Smaller tab size
" Next few lines mostly stolen from sjl
set autoread     " Loads file automatically if changed elsewhere
" Visible elements
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set showbreak=↪
" History and undo
set history=1000
set undofile
set undoreload=10000
" Backups
set backup                        " enable backups
set noswapfile                    " it's 2017, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

""""""""""""""""""""""""
" Plugin Customisation "
""""""""""""""""""""""""

" vim-airline
" download powerline fonts, install them and use one of them in the terminal
" good option: Inconsolata-g for Powerline g 10
set guifont=Roboto\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

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

" Polyglot
" Disable for LaTeX since I am already using vimtex
let g:polyglot_disabled = ['latex']

" Get rid of bracket matching that slows scrolling down in tex files
let g:vimtex_motion_matchparen = 0

" Notes directory
let g:notes_directories = ['~/Documents/Notes', '~/Documents/Dropbox/Notes']

"""""""""""
" Theming "
"""""""""""

set background=dark
colorscheme PaperColor
let g:airline_theme = 'papercolor'
hi Search cterm=NONE ctermfg=black ctermbg=yellow guifg=wheat

""""""""""""
" My stuff "
""""""""""""

" Spell check in tex files by default
autocmd BufNewFile,BufRead *.tex :call SpellCheckToggle(0)

" Offline Thesaurus in LaTeX
" Ctrl x + Ctrl t (in insert mode)
autocmd BufNewFile,BufRead *.tex set thesaurus+=/usr/share/mythes/th_en_GB_v2.dat
" For online Thesaurus hit \ + K

" Correct treatment of .tex files
let g:tex_flavor='latex'

" languagetool
" need to fetch languagetool-commandline and put it in a local dir
let g:languagetool_jar='$HOME/.languagetool-cmd/languagetool-commandline.jar'

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL=~'bin/fish'
	set shell=/bin/zsh
endif

" Map Ctrl-C to Esc
ino <C-C> <Esc>

" AutoSave
let g:auto_save = 1 " enable AutoSave
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
let g:auto_save_write_all_buffers = 1  " write all open buffers

" Gundo
nnoremap <F3> :GundoToggle<CR>

" \q redraws the screen and removes any search highlighting
nnoremap <silent> <leader>q :nohlsearch<Bar>:echo<CR>

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

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Using rope makes Python extremely slow. Disabling.
let g:pymode_rope = 0

"****************** configure neocomplete **************************
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_close_preview = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Select the first suggestion automatically
let g:neocomplete#enable_auto_select = 1

function! s:close_popup_and_complete()
	return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>close_popup_and_complete()<CR>

let g:neocomplete#keyword_patterns = {}
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
	\ '\v\\%('
	\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
	\ . '|hyperref\s*\[[^]]*'
	\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|%(include%(only)?|input)\s*\{[^}]*'
	\ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . ')'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"****************** end configure neocomplete **********************

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
au FileType json setlocal equalprg=python\ -m\ json.tool

""""""""""""""""""
" VIM on console "
""""""""""""""""""

" XFCE
if has("autocmd")
	au InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"
	au InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
	au VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
endif

"""""""""""""
" Functions "
"""""""""""""

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

" Function to find long sentences in files. Very useful when writing papers.
function! FindLongSentences()
	let line = 1
	let longLines = "Long lines: "

	while (line <= line("$"))
		let thisLine = system("sed -n '" . line . "p' " . expand('%:p'))
		let thisLine = substitute(thisLine, "'", "''", "g")
		let words = system("echo '" . thisLine . "' | wc -w")
		let words = substitute(words, '\n\+$', '', 'g')

		" 25 is the maximum number of words that a sentence should have
		if words > 25
			let longLines = longLines . " l:" . line . "(" . words . "w)"
		endif

		let line = line + 1
	endwhile

	if len(longLines) == 12
		let longLines = "No long lines found!"
	endif

	echo longLines
endfunction
