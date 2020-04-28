" Don't try to be vi compatible
set nocompatible

if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'christoomey/vim-tmux-navigator'

    Plugin 'c.vim'

    Plugin 'klen/python-mode'
    " PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
    Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    let g:fzf_nvim_statusline = 0 " disable statusline overwriting
    nmap <Leader>f :GFiles<CR>
    nmap <Leader>F :Files<CR>
    nmap <Leader>d :Buffers<CR>
    nmap <Leader>h :History<CR>
    nmap <Leader>t :BTags<CR>
    nmap <Leader>T :Tags<CR>
    nmap <Leader>l :BLines<CR>
    nmap <Leader>L :Lines<CR>
    nmap <Leader>' :Marks<CR>
    nmap <Leader>/ :Ag<Space>
    nmap <Leader>H :Helptags!<CR>
    nmap <Leader>C :Commands<CR>
    nmap <Leader>: :History:<CR>
    nmap <Leader>M :Maps<CR>
    nmap <Leader>s :Filetypes<CR>
    Plugin 'junegunn/fzf.vim'

    Plugin 'vimwiki/vimwiki'

    Plugin 'michal-h21/vim-zettel'      
    
    Plugin 'tpope/vim-fugitive'      

    Plugin 'tpope/vim-commentary'

    Plugin 'airblade/vim-gitgutter'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    endif
" Put your non-Plugin stuff after this line
" Filename format. The filename is created using strftime() function
let g:zettel_format = "%y%m%d-%H%M"
" Disable default keymappings
let g:zettel_default_mappings = 0 
" This is basically the same as the default configuration
augroup filetype_vimwiki
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
augroup END

let g:ackprg = 'ag --nogroup --nocolor --column'

" Settings for Vimwiki
let g:vimwiki_list = [{'path':'~/scratchbox/vimwiki/markdown/','ext':'.md','syntax':'markdown', 'zettel_template': "~/mytemplate.tpl"}, {"path":"~/scratchbox/vimwiki/wiki/"}]
" Set template and custom header variable for the second Wiki
let g:zettel_options = [{},{"front_matter" : {"tags" : ""}, "template" :  "~/mytemplate.tpl"}]
" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=0
set wm=0
set formatoptions=tcq
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set fo+=t

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Naviation
" nmap <Up>    <Nop>
" nmap <Down>  <Nop>
" nmap <Left>  <Nop>
" nmap <Right> <Nop>
" map $ <Nop>
" map ^ <Nop>
" map { <Nop>
" map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $

" indentation
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" avoiding the ESC key
inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" consistent Y
nnoremap Y y$

" Move up/down editor lines
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
set whichwrap+=<,>,h,l,[,]
" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized
"
if &term =~ '^screen'
    "tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" fix syntax highlighting in markdown 
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

" make sure .e files are highlighted properly
au BufNewFile,BufRead *.e set filetype=c

set mouse=a
if &term =~ '^screen'
        " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Display all matching file when we tab complete
set wildmenu

set clipboard=unnamedplus

set tags=./tags,tags;
" set autochdir
" cursor shape depending on mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
