runtime! debian.vim
syntax on
syntax enable
set foldlevelstart=0
"set foldmethod=syntax
set encoding=utf-8
if !exists('g:vscode')
" Plugins calls {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/auto-pairs-gentle'
Plug 'elmcast/elm-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'herringtondarkholme/yats.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'tomasiser/vim-code-dark'
Plug 'mattn/emmet-vim'
Plug 'yggdroot/indentline'
Plug 'honza/vim-snippets'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
call plug#end()
" }}}
"Basic Settings {{{
set autoread
set background=dark
colorscheme palenight
filetype indent on
filetype plugin on
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
noremap <C-Z> <NOP>
set path+=**
set omnifunc=syntaxcomplete#Complete
set completeopt+=preview
set nohlsearch
set autowrite
set nowrap
set hlsearch
set incsearch
set tabstop=2 shiftwidth=2 expandtab
set autoindent
set smartindent
set showmatch
set number
set showcmd
set relativenumber
set inccommand=nosplit
let mapleader = ","
let maplocalleader = ";"
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :find $MYVIMRC<cr>
inoremap jk <esc>
set splitright
set splitbelow
" Close all hidden buffers
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
    let open_buffers = []

    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor

    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction
"}}}
" Vim-Airline settings {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark_minimal'
let g:airline#extensions#tabline#enabled = 1
" }}}
"Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd Filetype vim setlocal foldmethod=marker
augroup END
"}}}
"HTML file settings {{{
augroup filetype_html
    autocmd!
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType jsp set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html :nnoremap <buffer> <localleader>f Vatzf
    let g:user_emmet_install_global = 0
    autocmd FileType html,css,jsp,xml EmmetInstall
    let g:user_emmet_leader_key='<C-Z>'
    let g:closetag_filetypes = 'html,jsp,xml,reason,javascript'
augroup END
"}}}
" Tmux settings {{{
nnoremap <C-W>l :TmuxNavigateRight<CR>
nnoremap <C-W>h :TmuxNavigateLeft<CR>
nnoremap <C-W>k :TmuxNavigateUp<CR>
nnoremap <C-W>j :TmuxNavigateDown<CR>
" }}}
" NerdTREE setting {{{
noremap <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=20
" }}}
" Typescript settings {{{
augroup filetype_typescript
    autocmd BufRead,BufNewFile *.ts   setfiletype typescript
    let g:typescript_indent_disable = 1
augroup end
" }}}
" IndentLine settings {{{
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '|'
"}}}
" Coc.nvim settings {{{
autocmd FileType json syntax match Comment +\/\/.\+$+
" Use <TAB> to expand snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
" Show signature help on placeholder jump
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" use `:ORI` for organize import of current buffer
command! -nargs=0 ORI   :call     CocAction('runCommand', 'editor.action.organizeImport')
" }}}
" DevIcons Settings {{{
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['package.json'] = "\ue718"
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['package-lock.json'] = "\ue718"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = "\ue781"
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*module.*\.js$'] = "\ufbbd"
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*controller.*\.js$'] = "\ufbbd"
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*service.*\.js$'] = "\ufbbd"
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*directive.*\.js$'] = "\ufbbd"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = "\ue736"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = "\ue749"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['elm'] = "\ue62c"
" }}}
" NERDTree Syntax highlight settings {{{
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['js'] = "FFFF00" "sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['vue'] = "55AE3A" "sets the color of vue files to blue
let g:NERDTreeExtensionHighlightColor['elm'] = "00FFFF" "sets the color of elm files to blue
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*controller.*\.js$'] = "B52E31" "sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*module.*\.js$'] = "B52E31" "sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*service.*\.js$'] = "3C7DD8" "sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*directive.*\.js$'] = "B52E31" "sets the color for files ending with _spec.rb
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['package.json'] = "43A03B" 
let g:NERDTreeExactMatchHighlightColor['package-lock.json'] = "43A03B" 
" }}}
" Airline settings {{{
let g:airline_theme = 'palenight'
" }}}
" FZF settings {{{
nnoremap <C-p> :FZF<CR>
" }}}
" Prettier settings {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}
endif
