" =====================================================================================================
" This is some simple gude of customization shortcut/combination in case you do not understand (like me)
"
" buffer: some files that you currently open
" C: ctrl button
" S: shift button
"
" :Array 1 10 { -> in normal mode type this command to automatically generate
" number in desire limit, separated by coma, and put it in desire brackets
" (can be square braces, curly braces, parenthesis, and <>)
"
" <S-L> -> shift + l button
" <S-H> -> shift + h button
" <C-[> -> ctrl + open square bracket button
" <C-t> -> ctrl + t button
" <C-_> -> ctrl + slash button 
" and so on: I'm tired explaning same things
" =====================================================================================================
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

highlight CursorLine ctermbg=NONE guibg=NONE cterm=underline gui=underline

syntax on
filetype plugin indent on
set encoding=UTF-8
set clipboard=unnamedplus
set exrc
set cursorcolumn
set guicursor=
set nu
set rnu
set ignorecase      " searches ignore case
set smartcase       " BUT: if you use uppercase in the search, it becomes case-sensitive
set hlsearch " or no hlsearch
set hidden
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set background=dark
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect,menu,longest
set signcolumn=yes
set colorcolumn=80,120
set cmdheight=2
set updatetime=50
set shortmess+=c
set t_Co=256
set whichwrap+=<,>,[,]
set autoindent
set cindent
set backspace=indent,eol,start
set autoread
set foldmethod=indent
set foldlevel=20
set mouse=a
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
set pastetoggle=<F2>
set cursorline
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/.fzf'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ghifarit53/tokyonight-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

" set theme
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" common utilities mapping
nnoremap <C-[> :nohlsearch<CR><Esc>
nnoremap <C-t> :terminal<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" config vim-airline.
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='default'
let g:airline#extensions#tabline#show_tabs=0

" config NERDTree
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "left"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
nnoremap <C-n> :NERDTreeToggle<CR><C-w>p
nnoremap <S-L> :bnext<cr>
nnoremap <S-H> :bprevious<cr>
autocmd BufEnter NERD_tree_* | execute 'normal R'

" Smart buffer delete
" when there is multiple buffer, if :bd being perform, move to prev buffer
" if only a single buffer, create new buffer
function! SmartBD()
  let l:listed = filter(range(1, bufnr('$')), 'buflisted(v:val)')

  if len(l:listed) > 1
    " More than one buffer: go to previous then delete current
    execute 'bprevious'
    execute 'bdelete #'
  else
    " Only one buffer left: create a new empty buffer
    enew
  endif
endfunction

" Map <C-x> in normal mode
nnoremap <silent> <C-x> :call SmartBD()<CR>


" :Array {start} {end} {bracket}
command! -nargs=+ Array call s:Array(<f-args>)

function! s:Array(...) abort
  if a:0 != 3
    echoerr "Usage: :Array {start} {end} { bracket: { [ < ( }"
    return
  endif

  let start   = str2nr(a:1)
  let end_    = str2nr(a:2)
  let open    = a:3
  if open ==# '{'
    let close = '}'
  elseif open ==# '['
    let close = ']'
  elseif open ==# '<'
    let close = '>'
  elseif open ==# '('
    let close = ')'
  else
    echoerr "Unsupported bracket type: " . open
    return
  endif

  " Support descending ranges too
  let seq = (start <= end_) ? range(start, end_) : range(start, end_, -1)
  let txt = open . join(seq, ', ') . close

  " Insert BELOW the current line
  call append(line('.'), txt)
endfunction

" Use ripgrep with fzf for live grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case ' .
  \ ' --glob "!node_modules/*" --glob "!.nuxt/*" ' .
  \ ' --glob "!embed-form/static/app.js" --glob "!embed-form/static/app.js.map" ' .
  \ ' --glob "!static/*" --glob "!embed-form/static/img/*" ' .
  \ ' --glob "!embed-form/static/svg/*" --glob "!assets/img/*" ' .
  \ ' --glob "!assets/scss/custom/plugins/*" '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)

nnoremap <C-_> :Rg<CR>

" coc insert map
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = [
  \ '@yaegassy/coc-volar',
  \ 'coc-sql',
  \ 'coc-docker',
  \ 'coc-yaml',
  \ 'coc-terraform',
  \ 'coc-rust-analyzer',
  \ 'coc-vetur',
  \ 'coc-sumneko-lua',
  \ 'coc-clangd',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-phpls',
  \ 'coc-go',
  \ 'coc-elixir',
  \ 'coc-html',
  \ 'coc-omnisharp'
  \ ]

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Format with clangd
command! -nargs=0 ClangFormat :CocCommand clangd.applyFix
