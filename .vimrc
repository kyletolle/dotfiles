"
" Kyle Tolle's .vimrc
" TODO: See http://www.linode.com/wiki/index.php/Vim_Tutorial for more ideas
"    Mostly for the h and l across lines feature
"  Some settings borrowed from $VIMRUNTIME\vimrc_example.vim

" Configure Ruby version
" Using info from https://github.com/macvim-dev/macvim/issues/581#issuecomment-341876633
" Must have Ruby 2.5.3 installed using `brew install ruby`
set rubydll=/usr/local/Cellar/ruby/2.5.3_1/lib/libruby.2.5.dylib

"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting up Vundle - the vim plugin bundler
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"Add your bundles here

" To install new ones do: \s to source this update file and then :PluginInstall
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-obsession'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'sjl/gundo.vim'
Plugin 'jQuery'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'mattn/emmet-vim'
Plugin 'elzr/vim-json'
Plugin 'briancollins/vim-jst'
Plugin 'ngmy/vim-rubocop'
Plugin 'jgdavey/vim-blockle'
Plugin 'rorymckinley/vim-rubyhash'
Plugin 'kchmck/vim-coffee-script'
Plugin 'HerringtonDarkholme/yats'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'wavded/vim-stylus'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'easymotion/vim-easymotion'
Plugin 'mhinz/vim-startify'
Plugin 'gioele/vim-autoswap'
" Plugin 'Yggdroot/indentLine'
" Also need to do `gem install rufo`
" Use it through :Rufo
Plugin 'ruby-formatter/rufo-vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'powerman/vim-plugin-AnsiEsc' " Use via :AnsiEsc
Plugin 'mileszs/ack.vim' " https://github.com/mileszs/ack.vim#keyboard-shortcuts

" Tags
" Instal UniversalCtags from http://docs.ctags.io/en/latest/osx.html?highlight=install
" brew tap universal-ctags/universal-ctags
" brew install --HEAD universal-ctags
" https://vim.fandom.com/wiki/Browsing_programs_with_tags
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'

" Writing plugins
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/goyo.vim'
let g:instant_markdown_autostart = 0
" You can manually trigger markdown previewing with :InstantMarkdownPreview
Plugin 'suan/vim-instant-markdown'
Plugin 'vim-pandoc/vim-criticmarkup'
Plugin 'dbmrq/vim-ditto'
Plugin 'reedes/vim-wordy'

" All of your Plugins must be added before the following line
call vundle#end()            " required

nmap <leader>p :PluginInstall<CR>
nmap <leader>P :PluginInstall!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff from $VIMRUNTIME\vimrc_example.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
set guioptions+=t

" Remove scrollbars!
set guioptions-=L
set guioptions-=R
set guioptions-=l
set guioptions-=r

" Use system clipboard by default
set clipboard=unnamed

" Don't use Ex mode, use Q for formatting
map Q gq

" Make Y yank to end of line instead of yank entire line
map Y y$

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text,markdown,ruby,javascript setlocal textwidth=80
    set cc=80
    hi ColorColumn ctermbg=lightgrey guibg=lightgrey

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " git commits always start on the first line.
    " From http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    autocmd VimEnter Rbenv shell 2.4.1
  augroup END
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
     \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
set laststatus=2
" Install the fonts for the icons: https://powerline.readthedocs.org/en/latest/installation/osx.html#installation-osx

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>b :NERDTreeFromBookmark
let NERDTreeMinimalUI=1 " YAGNI

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup/Temp files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Store temporary files in a central spot
set backupdir=~/vimfiles/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/vimfiles/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight whitespace at the end of lines
" From: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
if has("autocmd")
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif " has("autocmd")

" Strip trailing whitespace from all lines in the file
map <Leader>w :%s/\s\+$//g<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font, colors, highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
" set background=dark
set background=light
colorscheme solarized
" colorscheme hemisukyle
" Set font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI
  elseif has("gui_macvim")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window size/layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set columns=100 lines=56
set ch=2 "Set command line 2 lines high
set scrolloff=2 " Keeps 2 lines of context around the cursor

"Auto resizes tabs when toggling between them!
set winwidth=86 " Enough width for two 80 char splits using gvim
set winheight=5
set winminheight=5

set colorcolumn=80 " Highlight the 80 char column
set cursorline   "  --- Cursor crosshair
set cursorcolumn " /
set mousehide " Hides the mouse when typing
set hidden " Switch to another buffer when current one has modifications
set nu " Display line numbers
set relativenumber

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ignorecase " Case insensitive search
set smartcase " Ignore's case of search only if all lowercase
set wildignore+=tmp,node_modules/**,vendor/assets/**,spec/reports/**

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setlocal spell spelllang=en_us

"http://jamescrisp.org/2007/03/01/_vimrc-for-ruby/
set autoindent " Auto indentation
set expandtab " All new tab characters will be turned to spaces.
set shiftround
set shiftwidth=2 " Set shift width to n characters
" Tab at start of line inserts shiftwidth spaces, elsewhere inserts tabstop spaces
set smarttab
set tabstop=2
" use :retab to convert all existing tab characters to match current tab
" settings.

"http://vim.wikia.com/wiki/Omni_completion
set ofu=syntaxcomplete#Complete

" http://oldwiki.rubyonrails.org/rails/pages/HowtoUseVimWithRails
"syntax on " Syntax highlighting, overrides color settings.
let g:rubycomplete_rails = 1
runtime! macros/matchit.vim " Load matchit (% to bounce from do to end, etc.)

set nojoinspaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au BufRead,BufNewFile *.less set filetype=css
  au BufRead,BufNewFile *.scss set filetype=css
  au BufRead,BufNewFile *.sass set filetype=css
  au BufRead,BufNewFile *.rabl set filetype=ruby
  au BufRead,BufNewFile Guardfile set filetype=ruby
  au BufRead,BufNewFile *.md set filetype=markdown
  au BufRead,BufNewFile *.json set filetype=json
  au BufNewFile,BufReadPost *.styl set filetype=stylus
endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map to open .vimrc easily
noremap <Leader>v :e ~/.vimrc<CR>
" Map to open .zshrc easily
noremap <Leader>z :e ~/.zshrc<CR>

"Map to clear highlights fast
noremap <Leader>h :noh<CR>

"Reload the vimrc
noremap <Leader>so :so ~/.vimrc<CR>

noremap <Leader>f :CommandTFlush<Enter>

" Reset the syntax highlighting for when it gets mixed up
noremap <Leader>i :syntax sync fromstart<CR>

" Make window splits easier to move between
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Things to do on file open/close
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"http://vim.wikia.com/wiki/Restore_screen_size_and_position
"RESTORE VIM POSITION
if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif

  if has("autocmd")
    au VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
    au VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
  endif " has("autocmd")
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pretty print json
" From: https://coderwall.com/p/tpfysw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To format file as JSON: gg=G
au FileType json setlocal equalprg=python\ -m\ json.tool

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby Hash to JSON
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>j :%s/:\(\w*\)=>/"\1":/g \| :%s/nil/null/g \| :set ft=json \| :execute "normal gqaj" \| :noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabularize
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>\| :Tab /\|<CR>
map <leader>= :Tab /=<CR>
map <leader>, :Tab /,\zs<CR>
map <leader>{ :Tab /{<CR>
map <leader>\: :Tab /:\zsl0r1<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gundo_prefer_python3 = 1
nnoremap <Leader>g :GundoToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-ruby-xmpfilter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Type ruby code, end the line with # => and then run <leader>r to have the
" comment populated with the output of running that line. Each time you run
" it, all commented lines are updated with new values. Great for seeing what
" is happening as you write a program, right from vim.

autocmd FileType ruby nmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <leader>m <Plug>(xmpfilter-mark)


autocmd FileType ruby nmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <leader>r <Plug>(xmpfilter-run)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pencil
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel=0
let g:markdown_syntax_conceal = 0
augroup pencil
  " Remove ALL autocommands for the current group.
  autocmd!
  " autocmd FileType markdown,mkd   call pencil#init({'wrap': 'soft'})
  autocmd BufRead,BufNewFile,BufWinEnter *.{md,yaml} call pencil#init({'wrap': 'soft'})
  " autocmd FileType text           call pencil#init()
  autocmd BufRead,BufNewFile,BufWinEnter *.{md,yaml} setlocal scrolloff=0 " Keeps 2 lines of context around the cursor
  autocmd BufRead,BufNewFile,BufWinEnter *.{md,yaml} GitGutterDisable
  autocmd BufRead,BufNewFile,BufWinEnter *.{md,yaml} setlocal nocursorcolumn " Remove vertical part of cursor crosshair.
  autocmd BufRead,BufNewFile,BufWinEnter *.{md,yaml} setlocal cc=0 " Turn off column 80 highlight

  " Replace HTML link with a markdown one
  map <Leader>mdl :%s/<a\_.\{-}href="\(.\{-}\)".*>\(.\{-}\)<\/a>/\[\2\]\(\1\)/gc<CR>
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-ditto
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
" Turning DittoOn for these files makes vim _really_ slow for large files.
" Let's turn it off by default and it's easily turned on later for when you
" want to figure out what words are reused a lot.
" au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-rubocop
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>ra :RuboCop -a<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Create parent directories on save
" http://stackoverflow.com/a/4294176/249218
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
