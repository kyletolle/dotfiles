" Kyle Tolle's .vimrc
" TODO: See http://www.linode.com/wiki/index.php/Vim_Tutorial for more ideas
"    Mostly for the h and l across lines feature
"  Some settings borrowed from $VIMRUNTIME\vimrc_example.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff from $VIMRUNTIME\vimrc_example.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
 let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

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

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

" Map to open .vimrc easily
map <Leader>v :e ~/.vimrc<CR>

"Map to clear highlights fast
map <Leader>h :noh<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" From: http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    "Add your bundles here
    Bundle 'bling/vim-airline'
    Bundle 'wincent/Command-T'
    Bundle 'tpope/vim-bundler'
    Bundle 'tpope/vim-eunuch'
    Bundle 'tpope/vim-commentary'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-endwise'
    Bundle 'tpope/vim-haml'
    Bundle 'tpope/vim-markdown'
    Bundle 'tpope/vim-rails'
    Bundle 'tpope/vim-rake'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'pangloss/vim-javascript'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/syntastic'
    Bundle 'godlygeek/tabular'
    Bundle 'sjl/gundo.vim'
    Bundle 'jQuery'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'airblade/vim-gitgutter'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
set laststatus=2
" Install the fonts for the icons: https://powerline.readthedocs.org/en/latest/installation/osx.html#installation-osx

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>b :NERDTreeFromBookmark
let NERDTreeMinimalUI=1 " YAGNI

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use hjkl!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Up>     :echo "No"<cr>
noremap <Down>   :echo "No"<cr>
noremap <Left>   :echo "No"<cr>
noremap <Right>  :echo "No"<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup/Temp files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Store temporary files in a central spot
set backupdir=~/vimfiles/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/vimfiles/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight whitespace at the end of lines
" From: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Strip trailing whitespace from all lines in the file
map <Leader>w :%s/\s\+$//g<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font, colors, highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set background=dark
"set background=light
"colorscheme solarized
colorscheme hemisukyle
" Set font
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_win32")
		set guifont=Consolas:h11:cANSI
  elseif has("gui_macvim")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
	endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window size/layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set columns=100 lines=56
set ch=2 "Set command line 2 lines high
set scrolloff=2 " Keeps 2 lines of context around the cursor

"Auto resizes tabs when toggling between them!
set winwidth=84
set winheight=5
set winminheight=5

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ignorecase " Case insensitive search
set smartcase " Ignore's case of search only if all lowercase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.less set filetype=css
au BufRead,BufNewFile *.scss set filetype=css
au BufRead,BufNewFile *.sass set filetype=css
au BufRead,BufNewFile *.coffee set filetype=javascript

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>f :CommandTFlush<Enter>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Things to do on file open/close
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

