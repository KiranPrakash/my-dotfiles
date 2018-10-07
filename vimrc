" Vim and Python match made in heaven
set nocompatible	"required
filetype off		"required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass path where Vundle should install plugins 
" call Vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()		"required
filetype plugin indent on	"required


" specifies different areas of the screen where the splits should occur
set splitbelow
set splitright

" split navigations move between splits without using the mouse
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

Plugin 'tmhedberg/SimpylFold'

" Get indentation to follow PEP 8 standards for all python files
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" For full stack development you can specify each file type
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 

" Auto indentation for Python scripts
Plugin 'vim-scripts/indentpython.vim'

" Define the highlight group
"highlight BadWhitespace ctermbg=red guibg=darkred

" Flaggs unnecessary whitespace
"au BufRead,BufNewFile *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/

" UTF-8 Support
set encoding=utf-8

" Auto-Complete
Bundle 'Valloric/YouCompleteMe'

" Autocomplete window goes away after done with it. Remapping shortcut for
" goto a space-g
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Check for sytax in python
Plugin 'vim-syntastic/syntastic'

" PEP 8 checking with this nifty little plugin
Plugin 'nvie/vim-flake8'

" Make code look pretty
let python_highlight_all=1
syntax on

" Basic color theme
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

set t_Co=256

" Decide which color scheme based upon the VIM mode
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Switching between the theme. Press F5
call togglebg#map("<F5>")

" Install NERDTree
Plugin 'scrooloose/nerdtree'

" Hide *.pyc files or ignore those files in the NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] 
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" Virtualenv
let g:ycm_python_binary_path = 'python'

" Search anything from VIM using ctrlP
Plugin 'kien/ctrlp.vim'

" turn on line numbers and change the widthof the gutter column used for
" numbering
set nu
set numberwidth=3

" Git Integration
Plugin 'tpope/vim-fugitive'

" Powerline status bar that displays current virualenv, gitbranch, files
" beign edited
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" System Clipboard
set clipboard=unnamedplus

" Switch size of the blinking cursor's size based on the vim mode
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif
