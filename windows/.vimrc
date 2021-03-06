" TODO :
" vim plug
" syntastic setup
"
silent! call pathogen#infect()
silent! call pathogen#helptags()
syntax on
filetype plugin indent on

set number
set mouse=a
set linebreak
set ignorecase
set smartcase

set splitbelow
set splitright

set t_Co=256
colorscheme vividchalk

set laststatus=2
set statusline=%f "tail of the filename
set wildmenu

" Allow going to a the next 'virtual' line when the line is wrapped
noremap j gj
noremap k gk

" Use system clipboard
set clipboard=unnamed

" Use undo dir
set undofile
set undodir=~/.vim/undodir
"set undolevels=1000
"set undoreload=10000

" backspace works on auto-inserted tabs
set backspace=indent,eol,start

let mapleader = "\<Space>"

"" space to open new file DOESN'T WORK?
"nnoremap <Leader>o :CtrlP<CR>
" write
nnoremap <Leader>w :w<CR>
" quit
nnoremap <Leader>q :q<CR>
" enter visual
nmap <Leader><Leader> <C-v>

"" copy to system clipboard DOESN'T WORK?
"vmap <Leader>y "+y
"vmap <Leader>d "+d
"nmap <Leader>p "+p
"nmap <Leader>P "+P
"vmap <Leader>p "+p
"vmap <Leader>P "+P

set smartindent
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <F3> <N>
nnoremap <F4> :noh<return>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" relative numbers
set rnu
function ToggleNumbersOn()
	set rnu!
	set nu
endfunction
function ToggleRelativeOn()
	set nu!
	set rnu
endfunction
autocmd InsertEnter * call ToggleNumbersOn()
autocmd InsertLeave * call ToggleRelativeOn()

" format json files
function FormatJSON(...)
  let code="\"
        \ var i = process.stdin, d = '';
        \ i.resume();
        \ i.setEncoding('utf8');
        \ i.on('data', function(data) { d += data; });
        \ i.on('end', function() {
        \     console.log(JSON.stringify(JSON.parse(d), null,
        \ " . (a:0 ? a:1 ? a:1 : 4 : 4) . "));
        \ });\""
  execute "%! node -e " . code
endfunction
nmap fj :<C-U>call FormatJSON(v:count)<CR>

"" eslint
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_loc_list_height = 5
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
""let g:syntastic_javascript_eslint_exec = 'eslint_d'
""let g:syntastic_javascript_eslint_args = '--config ~/browse-web/.eslintrc'
"nmap fe :Error<CR>

" Nerd tree
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" webpack needs to catch vim writes
set backupcopy=yes

set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
autocmd filetype make setlocal noexpandtab

" for js templates
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces
