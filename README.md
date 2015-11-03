# Kyle Tolle's dotfiles

## Installation

Clone the repo and then move the files into your root path.
Warning: This will clobber any existing files already in your root path.

```
cd ~
git clone https://github.com/kyletolle/dotfiles.git
mv dotfiles/* . && mv dotfiles/.* .
rmdir dotfiles
```

A more gentle way to do things is to copy specific files over that you know
you want, like `.zshrc`, and `.vimrc`. These are likely the two most important
files.

## VIM

Install macvim through homebrew.

```
brew install macvim
```

To install the Vim bundles
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall! +qall
```

### Powerline Fonts

You'll need to [install the power fonts](https://powerline.readthedocs.org/en/latest/installation/osx.html#installation-osx). You can [download the fonts](https://github.com/Lokaltog/powerline-fonts) and install them, or use the steps below:

```
cd /code
mkdir -p github/powerline
cd github/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```

And now the fonts should show up in vim's Airline plugin.

### Command-T

Now that we've installed the Command-T plugin using Vundle, from up above, we
need to finish installing [Command-T](https://github.com/wincent/Command-T).
This means compiling the C extensions.

```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```

Note: The documentation says to use Ruby 1.8.7, but I have compiled the
extension against Ruby 2.0.0 and it works just fine.

## iTerm2

Install [iTerm2](https://www.iterm2.com/), and then we want to change it to
use the `zsh` shell by default.

```
chsh -s `which zsh`
```

## oh-my-zsh

Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) using the
following:

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Then to use the Solarized theme, download the files from:
http://ethanschoonover.com/solarized

After downloading, you can import them into iTerm2 using
iTerm -> Preferences -> Profiles -> Colors -> Load Presets -> Import

Note: There's a default color scheme set in the `.zshrc`, but I don't actually
use that for the colors.

