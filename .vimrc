" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Dominik.Drexl@bmw.de
"   Everything is free for you to copy, but make sure you want and understand
"   the parts you pick. If you just want to add or overwrite something, I
"   recommend putting it in ~/.vimrc.local
" }

" Environment {
set nocompatible                " Must be first line
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
    set shell=/bin/bash
else
    set shell=/bin/zsh
endif
" }

" Plugins {
" First Time Only Installs {
" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
    echo "Installing plug.vim..\n"
    silent !mkdir -p ~/.vim/autoload
    silent !mkdir -p ~/.vim/plugged
    execute 'silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Install powerline fonts if we don't already have it
if empty(glob("~/.fonts/ubuntu-mono-powerline-ttf"))
    echo "Installing powerline fonts..\n"
    silent !mkdir -p ~/.fonts/ubuntu-mono-powerline-ttf
    execute 'silent !wget -q -P ~/.fonts/ubuntu-mono-powerline-ttf/ "https://raw.githubusercontent.com/powerline/fonts/master/UbuntuMono/Ubuntu Mono derivative Powerline Bold Italic.ttf"'
    execute 'silent !wget -q -P ~/.fonts/ubuntu-mono-powerline-ttf/ "https://raw.githubusercontent.com/powerline/fonts/master/UbuntuMono/Ubuntu Mono derivative Powerline Bold.ttf"'
    execute 'silent !wget -q -P ~/.fonts/ubuntu-mono-powerline-ttf/ "https://raw.githubusercontent.com/powerline/fonts/master/UbuntuMono/Ubuntu Mono derivative Powerline Italic.ttf"'
    execute 'silent !wget -q -P ~/.fonts/ubuntu-mono-powerline-ttf/ "https://raw.githubusercontent.com/powerline/fonts/master/UbuntuMono/Ubuntu Mono derivative Powerline.ttf"'
    execute 'silent !fc-cache -vf'
endif
" }

if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    Plug 'altercation/vim-colors-solarized'                                  " Colorscheme
    Plug 'christoomey/vim-tmux-navigator'                                    " Seamless vim and tmux split navigation
"   Plug 'ctrlpvim/ctrlp.vim'                                                " Fuzzy file opener
"    Plug 'easymotion/vim-easymotion'                                         " Speed of light motion
    Plug 'majutsushi/tagbar'                                                 " Tags in sidebar
"    Plug 'mbbill/undotree'                                                   " Undo sidebar
"    Plug 'michaeljsmith/vim-indent-object'                                   " Indent object
    Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }                          " c++ formatting
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }                   " File browser sidebar
    Plug 'sirver/ultisnips'                                                  " Code snippets
    Plug 'FaBrand/vim-snippets'                                                " Code snippets
    Plug 'tpope/vim-commentary'                                              " Code commenting
    Plug 'tpope/vim-fugitive'                                                " Git in Vim!!
"    Plug 'tpope/vim-repeat'                                                  " Repeatable tpope commands
"    Plug 'tpope/vim-surround'                                                " Parenthesis commands
"    Plug 'tpope/vim-unimpaired'                                              " Pairs of handy bracket mappings
    Plug 'valloric/youcompleteme', {'do' : './install.py --clang-completer'} " Code completion engine!!
    Plug 'vim-airline/vim-airline'                                           " Statusline
    Plug 'vim-airline/vim-airline-themes'                                    " Solarized theme for airline
"    Plug 'vim-scripts/argtextobj.vim'                                        " Argument object
"    Plug 'vim-scripts/matchit.zip'                                           " Improve % operation
"    Plug 'godlygeek/tabular'                                                 " Text alignment
    Plug 'chenzhiwo/ycm-extra-conf-ros'                                      " Ros Config for ycm
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
    Plug 'vim-syntastic/syntastic'                                           " Clang Tidy etc
    Plug 'tikhomirov/vim-glsl'                                               " Syntax highlighting for glsl
    call plug#end()
endif
" }

" General {
filetype plugin indent on       " Automatically detect file types.
syntax enable                   " Syntax highlighting
scriptencoding utf-8

" Always switch to the current file directory
augroup switchWD
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
augroup END

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Undo and Backup directories
set backup                      " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" Centralize backups, swapfiles and undo history
set backupdir=~/.vimcache/backups
set directory=~/.vimcache/swaps
set undodir=~/.vimcache/undo
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*


highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode

set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set background=dark
set clipboard=unnamed,unnamedplus   " Use + register for clipboard if possible

set shortmess+=filmnrxoOtTI     " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore         " Allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set nospell                     " Spell checking off
set hidden                      " Allow buffer switching without saving
set iskeyword-=.                " '.' is an end of word designator
set iskeyword-=#                " '#' is an end of word designator
set iskeyword-=-                " '-' is an end of word designator

set title                       " Show the filename in the window titlebar
set autoread                    " Refresh buffers automatically
set mouse=a                     " Enable mouse in all modes
set noerrorbells                " Disable error bells
set modeline                    " Respect modeline in files
set modelines=4
set tabpagemax=15               " Only show 15 tabs
set cursorline                  " Highlight current line
set laststatus=2                " Last window always has a statusline
set backspace=indent,eol,start  " Allow backspace in insert mode
set linespace=0                 " No extra spaces between rows
set number                      " Show line numbers
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set gdefault                    " Add the g flag to search/replace by default
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=1                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list                        " Show “invisible” characters
set listchars=tab:▸\ ,trail:•,extends:>,precedes:<,nbsp:.
set ttyfast                     " Optimize for fast terminal connections
set encoding=utf-8              " Use UTF-8
set complete-=i
set smarttab
set nrformats-=octal            " Dont increment octals
set sessionoptions-=options     " Dont save everything of the session
set display+=lastline           " No legacy vi display

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j          " Delete comment character when joining commented lines
endif

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if !empty(&viminfo)
    set viminfo^=!
endif
" }

" Solarized Colorscheme {
if filereadable(expand("~/.vim/plugged/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=16       " must have solarized palette in
    " terminal emulator to work
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    colorscheme solarized
    set t_Co=16
endif

" colors for vimdiff
highlight DiffText cterm=none ctermfg=White ctermbg=Red gui=none guifg=White guibg=Red
" }

" Formatting {
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" Remove trailing whitespaces and ^M chars
augroup stripWHITESPACE
    autocmd FileType c,cpp,python,xml,yml,cmake,sh,bash,py,gitcommit,yaml,glsl autocmd BufWritePre <buffer> call StripTrailingWhitespace()
augroup END
let python_highlight_all = 1
" }

" Key Mappings {
let mapleader = ','
let maplocalleader = '_'

" Move lines with up/down arrowkeys
" nmap <Up> :m .-2<CR>
" nmap <Down> :m .+1<CR>

" Disable left right arrow keys
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>

" F keys
noremap <F2> :w<CR>
noremap <F3> :close<CR>
noremap <F4> :bd<CR>
noremap <F5> :bp<CR>
noremap <F6> :bn<CR>
noremap <S-F5> :cp<CR>
noremap <S-F6> :cn<CR>

" tags
noremap <F7> <C-T>
noremap <F8> <C-]>
noremap <C-F8> <C-W><C-]>

" window movement
noremap <C-H> <C-W><C-H>
noremap <C-L> <C-W><C-L>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" tab movement
noremap <S-H> gT
noremap <S-L> gt

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" When pasting over, keep original contents in register
vnoremap p "_dP

" Folding with the spacebar
nnoremap <space> za

" toggle search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

" Find merge conflict markers
" map <leader>fc /\v^[<\|=>] 7 ( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
nnoremap <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
"nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
nnoremap zl zL
nnoremap zh zH

" Easier formatting
"nnoremap <silent> <leader>q gwip

" Open  quickfix window
nnoremap <silent> <leader>q :copen<CR>
" Clear  quickfix window
nnoremap <silent> <leader>cq :cexpr []<CR>
" }

" Plugin Settings/Mappings {
" Commentary {
if isdirectory(expand("~/.vim/plugged/vim-commentary"))
    augroup commentSTRING
        autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
        autocmd FileType yaml,cmake setlocal commentstring=#\ %s
    augroup END
endif
" }

" NerdTree {
if isdirectory(expand("~/.vim/plugged/nerdtree"))
    nmap <C-n> :NERDTreeToggle<CR>
    nmap <leader>n :NERDTreeFind<CR>

    let g:NERDShutUp=1
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif
" }

" Tabularize {
if isdirectory(expand("~/.vim/plugged/tabular"))
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=> :Tabularize /=><CR>
    vmap <Leader>a=> :Tabularize /=><CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a" :Tabularize /"<CR>
    vmap <Leader>a" :Tabularize /"<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" }

" Easy Motion {
if isdirectory(expand("~/.vim/plugged/vim-easymotion"))
    map s <Plug>(easymotion-prefix)
endif
" }

" CtrlP {
if isdirectory(expand("~/.vim/plugged/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <leader>f :CtrlP<CR>
    nnoremap <leader>b :CtrlPBuffer<CR>
    nnoremap <leader>t :CtrlPTag<CR>
    nnoremap <leader>r :CtrlPMRU<CR>

    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.(git|hg|svn|repo|catkin)$',
                \ 'file': '\.(exe|so|dll|py(d|c))$' }

    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif

    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
                \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
                \ }
endif
"}

" TagBar {
if isdirectory(expand("~/.vim/plugged/tagbar/"))
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
endif
"}

" Fugitive {
if isdirectory(expand("~/.vim/plugged/vim-fugitive/"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gvdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    "nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    "nnoremap <silent> <leader>gg :SignifyToggle<CR> todo
endif
"}

" UltiSnips {
" Remap Editing of snippets to a shortcut
nnoremap <silent> <leader>ue :UltiSnipsEdit<CR>
" Open Snippet edit as split
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/plugged/ultisnips/UltiSnips', 'UltiSnips']
" }

" YouCompleteMe {
if isdirectory(expand("~/.vim/plugged/youcompleteme/"))
    "let g:acp_enableAtStartup = 0

    " self explanatory af
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_autoclose_preview_window_after_completion = 1

    " remap Ultisnips for compatibility for YCM
    let g:ycm_use_ultisnips_completer = 1
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

    let g:ycm_register_as_syntastic_checker = 1 "default 1
    let g:ycm_show_diagnostics_ui = 0

    " Enable omni completion.
    augroup omniCOMPLETE
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    " python semantic completion
    let g:ycm_python_binary_path = '/usr/bin/python3'

    " c lang family completion
    let g:ycm_confirm_extra_conf = 0

    " The extra configuration is handled by the extra extra
    " ycm-extra-conf-ros plugin (ycm_global_extra_conf is set there
    " accordingly)

    " YcmCompleter subcommand mappings
    noremap <leader>.g :YcmCompleter GoTo<CR>
    noremap <leader>.f :YcmCompleter FixIt<CR>
    noremap <leader>.r :YcmCompleter GoToReferences<CR>
    nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>

    " Ycm Integration for the vim-ros plugin

    let g:ycm_semantic_triggers = {
                \   'roslaunch' : ['="', '$(', '/'],
                \   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
                \ }
endif
" }

" UndoTree {
if isdirectory(expand("~/.vim/plugged/undotree/"))
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif
" }

" Airline {
" Set configuration options for the statusline plugin vim-airline.
" Use the symbols , , , , , , and .in the statusline
" If the previous symbols do not render for you then install a
" powerline enabled font.

" See `:echo g:airline_theme_map` for some more choices
if isdirectory(expand("~/.vim/plugged/vim-airline-themes/"))
    let g:airline_theme = 'solarized'
    let g:airline_powerline_fonts = 1
endif
" }

" Clang Format {
if isdirectory(expand("~/.vim/plugged/vim-clang-format/"))
    let g:clang_format#detect_style_file = 1
    let g:clang_format#command = 'clang-format-5.0'

    augroup clangFMT
        autocmd FileType cpp let g:clang_format#auto_format = 1
    augroup END
endif
" }

" { Syntastic
if isdirectory(expand("~/.vim/plugged/syntastic/"))
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_cpp_checkers = ['clang_tidy']
    let g:syntastic_cpp_clang_tidy_args = "-checks=readability-*,cppcoreguidelines-* -std=c++14"
    let g:syntastic_python_checkers = ['pylint']
endif
" }

" { Glsl
if isdirectory(expand("~/.vim/plugged/vim-glsl/"))
    autocmd! BufNewFile,BufRead *.vs,*.fs,*.*shader set ft=glsl
endif
" }
" }

" GVim Settings {
if has('gui_running')
    " Use the Solarized Dark theme
    set background=dark
    colorscheme solarized
    set linespace=8             " Better line-height
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
endif
" }

" Functions {

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" Shell command {
function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
" }

" Search visual selection {
" Search visual selection with * and #
" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>
" }
" }

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }
