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

    Plugin 'tpope/vim-surround'
    
    Plugin 'tpope/vim-abolish'
    
    Plugin 'airblade/vim-gitgutter'

    Plugin 'reedes/vim-pencil'

    Plugin 'junegunn/goyo.vim'

    Plugin 'junegunn/limelight.vim'
    
    Plugin 'baeuml/summerfruit256.vim'

    Plugin 'junegunn/seoul256.vim'

    Plugin 'majutsushi/tagbar'

    Plugin 'tommcdo/vim-exchange'
    
    Plugin 'rhysd/vim-clang-format'

    Plugin 'alok/notational-fzf-vim'
    
    if has('nvim')
        Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plugin 'Shougo/deoplete.nvim'
        Plugin 'roxma/nvim-yarp'
        Plugin 'roxma/vim-hug-neovim-rpc'
    endif
    
    " Plugin 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

    Plugin 'JoshMcguigan/estream'

    Plugin 'skywind3000/asyncrun.vim'

    Plugin 'dbakker/vim-paragraph-motion'

    Plugin 'vim-scripts/argtextobj.vim'

    Plugin 'PeterRincker/vim-argumentative'

    Plugin 'vim-scripts/DoxygenToolkit.vim'

    Plugin 'dense-analysis/ale'

    Plugin 'iamcco/markdown-preview.nvim'

    Plugin 'justinmk/vim-sneak'
    
    Plugin 'godlygeek/tabular'
    
    Plugin 'ludovicchabant/vim-gutentags'

    Plugin 'fedorenchik/qt-support.vim'
    
    " Plugin 'inkarkat/vim-ConflictMotions'
    
    Plugin 'madox2/vim-ai'
     
    Plugin 'peterhoeg/vim-qml'   

    Plugin 'Shougo/neosnippet.vim'
    Plugin 'Shougo/neosnippet-snippets' 
    
    Plugin 'tpope/vim-repeat'   

    call vundle#end()            " required
    filetype plugin indent on    " required
endif

let g:vim_ai_roles_config_file = '~/.config/openai.roles'

" remap leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" deoplete configuration
let g:deoplete#enable_at_startup = 1        
" Use ALE and also some plugin 'foobar' as completion sources for all code.
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\}) 

" special chatGPT commands
command! -range -nargs=? AITranslate <line1>,<line2>call AIEditRun(<range>, "Translate to English: " . <q-args>)
command! -range -nargs=? AICode <line1>,<line2>call AIRun(<range>, "Programming syntax is " . &filetype . ", " . <q-args>)
command! -range -nargs=? AIImprove <line1>,<line2>call AIEditRun(<range>, "Please improve phrasing and word choices: " . <q-args>)
command! -range -nargs=? AIFix <line1>,<line2>call AIEditRun(<range>, "Fix grammar and spelling: " . <q-args>)


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
nnoremap <silent> <Leader>q :Rg <C-R><C-W><CR>
vnoremap <silent> <Leader>q y:Rg <C-R>=escape(@",'/\')<CR><CR>
" nmap <Leader>s :Filetypes<CR>

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --fixed-strings --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-q': 'fill_quickfix'}

command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%'))
    " \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))

" neccessary as snap ctags can't access /tmp 
let g:tagbar_use_cache = 0

let g:tmux_navigator_no_wrap = 0
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

let g:nv_search_paths = ['~/neoscan/notes', '~/notes', 'docs.md', './notes.md']
nnoremap <silent> <leader>s :NV<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

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

" Turn on syntax highlighting with doxygen on top
let g:load_doxygen_syntax=1
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

" need to remap ctrl-i as equivalent to <Tab> otherwise
noremap <C-n> <C-i>

" allow ctrl-z in insert mode
inoremap <c-z> <esc><c-z>

set whichwrap+=<,>,h,l,[,]

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%{fugitive#statusline()}

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
" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" format to hard line wraps
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" fzf-vim close quick when hitting ESC
set timeoutlen=1000 ttimeoutlen=0

" useful shortcuts
inoremap <C-u> <esc>gUiWEa 

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" gw to swap the current word with the next, keep cursor
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
" map <leader>l :set list!<CR> " Toggle tabs and EOL

" avoid random characters at startup
set t_TI= t_TE=
" Color scheme (terminal)
set t_Co=256
set background=light

" handling setting and unsetting BAT_THEME for fzf.vim
augroup update_bat_theme
    autocmd!
    autocmd colorscheme * call ToggleBatEnvVar()
augroup end
function ToggleBatEnvVar()
    if (&background == "light")
        let $BAT_THEME='Monokai Extended Light'
    else
        let $BAT_THEME=''
    endif
endfunction

" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" let g:seoul256_background = 256
" colorscheme seoul256-light
colorscheme summerfruit256
:hi Normal ctermbg=NONE guibg=NONE
:hi Comment ctermfg=lightgray
" :hi DiffAdd                   ctermfg=black cterm=bold guibg=green      guifg=black
" :hi DiffText   ctermbg=yellow ctermfg=red   cterm=bold guibg=yellow     guifg=red
" :hi DiffChange ctermbg=none   ctermfg=none  cterm=bold guibg=white      guifg=black
" :hi DiffDelete                                         guibg=lightblue  guifg=lightblue
" tmux knows the extended mouse mode
set ttymouse=xterm2
if &term =~ '^screen'
    "tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" change the direction of new splits
set splitbelow
set splitright

" map splits similar to tmux
nmap <Leader>\ :vsplit<CR>
nmap <Leader>- :split<CR>

:hi debugPC term=reverse ctermbg=lightblue guibg=lightblue

" don't hide symbols in markdown
set conceallevel=0
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

" no syntax highlighting in prot.md
autocmd BufNewFile,BufRead prot.md setlocal syntax=OFF
" no error highlighting for markdown at all 
hi link markdownError NONE
" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
" make sure .e files are highlighted properly
au BufNewFile,BufRead *.e set filetype=c
" make sure .qml files are highlighted properly
au BufNewFile,BufRead *.qml set filetype=qml

" Read-only pdf through pdftotext
autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

" Open word files with pandoc and not as a zip file
let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
autocmd BufReadPre *.doc,*.docx,*.rtf,*.odp,*.odt silent set ro
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent set modifiable
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent set filetype=markdown
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent set conceallevel=0 " don't hide symbols in markdown
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent  %!pandoc --columns=100 -t markdown "%" -o /dev/stdout

set mouse=a
if &term =~ '^screen'
        " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Display all matching file when we tab complete
set wildmenu

set clipboard=unnamedplus
" make sure pasted-over content doesn't go to clipboard
xnoremap <expr> p 'pgv"'.v:register.'y`>' 

set tags=tags,./tags
set path=.

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
autocmd FileType c,cpp,cs,java          set commentstring=//\ %s

set directory=$HOME/.vim/swapfiles//

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.lsd let &bin=1
  au BufReadPost *.lsd if &bin | %!xxd
  au BufReadPost *.lsd set ft=xxd | endif
  au BufWritePre *.lsd if &bin | %!xxd -r
  au BufWritePre *.lsd endif
  au BufWritePost *.lsd if &bin | %!xxd
  au BufWritePost *.lsd set nomod | endif
augroup END

" use vim for prose
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 0, 'conceallevel': 0})
  autocmd FileType text         call pencil#init({'wrap': 'hard', 'autoformat': 0, 'conceallevel': 0})
augroup END

" open quickfix window automatically when AsyncRun is executed
" set the quickfix window 12 lines height.
let g:asyncrun_open = 12
" open quickfix window always at the bottom 
" :autocmd FileType qf wincmd J
" Set global error format to match estream output
" set errorformat=%f\|%l\|%c,%f\|%l\|,%f\|\|
" Use global error format with asyncrun
" let g:asyncrun_local = 0

" Pipe any async command through estream to format it as expected
" by the errorformat setting above
" example: `:Async cargo test`
" command -nargs=1 Async execute "AsyncRun <args> |& $VIM_HOME/bundle/estream/bin/estream"

" Go to the previous/next quickfix item 
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" ignore warnings when jumping with :cn
set errorformat^=%-G%f:%l:\ warning:%m
set errorformat^=%-G%f:%l:\ note:%m
" F4 to toggle quickfix window
nnoremap <F4> :call asyncrun#quickfix_toggle(12)<cr>

" logic to find the root directory
let g:asyncrun_rootmarks = ['.git', '.root']

autocmd FileType sh             nnoremap <buffer> <silent> <F9> :AsyncStop! \| sleep 100m \| AsyncRun %:p<cr>

let g:clang_format#style_options = {
            \ "UseTab": "Never",
            \ "IndentWidth": "4",
            \ "AllowShortIfStatementsOnASingleLine": "false",
            \ "AllowShortFunctionsOnASingleLine": "false",
            \ "ColumnLimit": "0",
            \ "ConstructorInitializerAllOnOneLineOrOnePerLine": "false",
            \ "ConstructorInitializerIndentWidth": "0",
            \ "AccessModifierOffset": "-4",
            \ "BreakBeforeBraces": "Linux",
            \ "BreakConstructorInitializers": "BeforeComma",
            \ "AllowShortCaseLabelsOnASingleLine": "true",
            \ "IndentCaseLabels": "true",
            \ "DerivePointerAlignment": "false",
            \ "PointerAlignment": "Left"}
" use this to close multiple buffers with fzf
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" setlocal spell
set spelllang=en_us
" fix latest error directly
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Do not lint or fix python files.
let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
\ '*.py': {'ale_linters': [], 'ale_fixers': []},
\}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_fixers = {'cpp': ['clangtidy']}
let g:ale_linters = {'cpp': ['clangd']}

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1
let g:ale_virtualtext_cursor = 0
let g:ale_cursor_detail = 0
let g:ale_set_balloons = 0

" Set this in your vimrc file to disabling highlighting
:nnoremap <C-]> :ALEGoToDefinition<CR>
highlight ALEWarning ctermbg=lightyellow
highlight ALEError ctermbg=lightred

highlight clear SignColumn
" highlight! link SignColumn LineNr
let g:gitgutter_set_sign_backgrounds = 1

" make sure we can use aliases in command mode
let $BASH_ENV = "~/.bash_aliases"
  
"Goyo settings
let g:goyo_width = 81
let g:goyo_height = 999
let g:goyo_margin_top = 0
let g:goyo_margin_bottom = 0

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set textwidth=80
  set wrap
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=3
  set textwidth=0
  set nowrap
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

command! -range=% Openinbrowser <line1>,<line2> TOhtml | :AsyncRun open %

:command Q q

" This prompt instructs model to be consise in order to be used inline in editor
let s:initial_complete_prompt =<< trim END
>>> system

You are a general assistant.
Answer shortly, consisely and only what you are asked.
Do not provide any explanantion or comments if not requested.
If you answer in a code, do not wrap it in markdown code block.
END

" :AI
" - prompt: optional prepended prompt
" - engine: chat | complete - see how to configure complete engine in the section below
" - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
" - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.token_file_path: override global token configuration
" - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
" - ui.paste_mode: use paste mode (see more info in the Notes below)
let g:vim_ai_complete = {
\  "prompt": "",
\  "engine": "chat",
\  "options": {
\    "model": "cognitivecomputations/dolphin3.0-r1-mistral-24b:free",
\    "endpoint_url": "https://openrouter.ai/api/v1/chat/completions",
\    "max_tokens": 0,
\    "max_completion_tokens": 0,
\    "temperature": 0.1,
\    "request_timeout": 20,
\    "stream": 1,
\    "enable_auth": 1,
\    "token_file_path": "~/.config/openrouter.token",
\    "selection_boundary": "#####",
\    "initial_prompt": s:initial_complete_prompt,
\  },
\  "ui": {
\    "paste_mode": 1,
\  },
\}

" :AIEdit
" - prompt: optional prepended prompt
" - engine: chat | complete - see how to configure complete engine in the section below
" - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
" - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.token_file_path: override global token configuration
" - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
" - ui.paste_mode: use paste mode (see more info in the Notes below)
let g:vim_ai_edit = {
\  "prompt": "",
\  "engine": "chat",
\  "options": {
\    "model": "cognitivecomputations/dolphin3.0-r1-mistral-24b:free",
\    "endpoint_url": "https://openrouter.ai/api/v1/chat/completions",
\    "max_tokens": 0,
\    "max_completion_tokens": 0,
\    "temperature": 0.1,
\    "request_timeout": 20,
\    "stream": 1,
\    "enable_auth": 1,
\    "token_file_path": "~/.config/openrouter.token",
\    "selection_boundary": "#####",
\    "initial_prompt": s:initial_complete_prompt,
\  },
\  "ui": {
\    "paste_mode": 1,
\  },
\}

" This prompt instructs model to work with syntax highlighting
let s:initial_chat_prompt =<< trim END
>>> system

You are a general assistant.
If you attach a code block add syntax type after ``` to enable syntax highlighting.
END

" :AIChat
" - prompt: optional prepended prompt
" - options: openai config (see https://platform.openai.com/docs/api-reference/chat)
" - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.token_file_path: override global token configuration
" - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
" - ui.open_chat_command: preset (preset_below, preset_tab, preset_right) or a custom command
" - ui.populate_options: put [chat-options] to the chat header
" - ui.scratch_buffer_keep_open: re-use scratch buffer within the vim session
" - ui.force_new_chat: force new chat window (used in chat opening roles e.g. `/tab`)
" - ui.paste_mode: use paste mode (see more info in the Notes below)
let g:vim_ai_chat = {
\  "prompt": "",
\  "options": {
\    "model": "cognitivecomputations/dolphin3.0-r1-mistral-24b:free",
\    "endpoint_url": "https://openrouter.ai/api/v1/chat/completions",
\    "max_tokens": 0,
\    "max_completion_tokens": 0,
\    "temperature": 1,
\    "request_timeout": 20,
\    "stream": 1,
\    "enable_auth": 1,
\    "token_file_path": "~/.config/openrouter.token",
\    "selection_boundary": "",
\    "initial_prompt": s:initial_chat_prompt,
\  },
\  "ui": {
\    "open_chat_command": "preset_below",
\    "scratch_buffer_keep_open": 0,
\    "populate_options": 0,
\    "code_syntax_enabled": 1,
\    "force_new_chat": 0,
\    "paste_mode": 1,
\  },
\}
