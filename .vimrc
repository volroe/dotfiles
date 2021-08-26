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

    " Plugin 'c.vim'

    Plugin 'christoomey/vim-tmux-navigator'

    " Plugin 'klen/python-mode'
    
    Plugin 'mjbrownie/swapit'

    " Plugin 'vim-airline/vim-airline'
    " let g:airline_theme='angr'

    " Plugin 'vim-airline/vim-airline-themes'
    
    Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    Plugin 'junegunn/fzf.vim'

    Plugin 'tpope/vim-fugitive'      

    Plugin 'tpope/vim-commentary'

    Plugin 'tpope/vim-obsession'

    Plugin 'airblade/vim-gitgutter'

    Plugin 'skywind3000/asyncrun.vim'

    " Plugin 'lifepillar/vim-mucomplete'

    Plugin 'zxqfl/tabnine-vim'

    " Plugin 'vim-syntastic/syntastic' 

    " Plugin 'justmao945/vim-clang'
    " let g:clang_compilation_database = './'

    " Plugin 'xavierd/clang_complete'
    " let g:clang_library_path='/usr/lib/llvm-8/lib/libclang.so.1'
    " let g:clang_auto_select=1
    " set completeopt+=menuone
    " set completeopt+=noselect

    Plugin 'reedes/vim-pencil'

    Plugin 'junegunn/goyo.vim'

    Plugin 'baeuml/summerfruit256.vim'

    Plugin 'junegunn/seoul256.vim'

    Plugin 'majutsushi/tagbar'

    Plugin 'tommcdo/vim-exchange'
    
    Plugin 'rhysd/vim-clang-format'

    Plugin 'alok/notational-fzf-vim'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
endif

" remap leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <silent> <F8> :TagbarToggle<CR>

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
nmap <Leader>/ :Rg<Space>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>M :Maps<CR>
" nmap <Leader>s :Filetypes<CR>
" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" neccessary as snap ctags can't access /tmp 
let g:tagbar_use_cache = 0

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

function s:AddTerminalNavigation()

    if &filetype ==# ''
        tnoremap <buffer> <silent> <c-h> <c-\><c-n>:TmuxNavigateLeft<cr>
        tnoremap <buffer> <silent> <c-j> <c-\><c-n>:TmuxNavigateDown<cr>
        tnoremap <buffer> <silent> <c-k> <c-\><c-n>:TmuxNavigateUp<cr>
        tnoremap <buffer> <silent> <c-l> <c-\><c-n>:TmuxNavigateRight<cr>
    endif

endfunction

augroup TerminalNavigation
    autocmd!
    autocmd TerminalOpen * call s:AddTerminalNavigation()
augroup END

let g:nv_search_paths = ['docs.md' , '~/neoscan/notes']
nnoremap <silent> <leader>s :NV<CR>

" Put your non-Plugin stuff after this line
"
let g:ackprg = 'ag --nogroup --nocolor --column'

" Source the termdebug plugin for vim 8.2
if v:version >= 802
    packadd termdebug
    noremap <silent> <leader>t :Termdebug<cr>
endif

" better termdebug layout
let g:termdebug_wide=1

" Turn on syntax highlighting
syntax on

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set vb t_vb=

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

" Navigation
noremap K     {
noremap J     }
noremap H     ^
noremap L     $
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" indentation
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" consistent Y
nnoremap Y y$

" allow ctrl-z in insert mode
inoremap <c-z> <esc><c-z>

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
" press enter to clear last search highlighting
nnoremap <silent> <cr> :noh<CR><CR>
" * just highlights but don't jump
map <silent> * :let @/="\\<<c-r><c-w>\\>"<CR>:set hls<CR>
" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" format to hard line wraps
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" useful shortcuts

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" gw to swap the current word with the next, keep cursor
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" avoid random characters at startup
set t_TI= t_TE=
" Color scheme (terminal)
set t_Co=256
set background=light
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" let g:seoul256_background = 256
" colorscheme seoul256-light
colorscheme summerfruit256
:hi Normal ctermbg=NONE guibg=NONE
:hi Comment ctermfg=lightgray
if &term =~ '^screen'
    "tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
:hi debugPC term=reverse ctermbg=lightblue guibg=lightblue
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

autocmd filetype c setlocal noexpandtab shiftwidth=4 softtabstop=4

set directory=$HOME/.vim/swapfiles//

" use vim for prose
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 1})
  autocmd FileType text         call pencil#init({'wrap': 'hard', 'autoformat': 0})
augroup END

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        bo copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F4> :call ToggleQuickFix()<cr>
