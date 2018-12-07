# Kyle Tolle's dotfiles

When recently configuring a new machine for development, I searched for a way
to better handle dotfiles and came across an article on the Atlassian Developer
blog called [_The best way to store your dotfiles: A bare Git
repository_](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).
I set up my original machine based on the "Starting from scratch" section along
with a few modifications because my setup was different and I ran into
problems. What follows should be the steps needed to use these dotfiles on any
further new machines.

## Installation

- Go to your $HOME

```
cd $HOME
```

- Clone the dotfiles into a bare git repo.

```
git clone --bare git@github.com:kyletolle/dotfiles.git $HOME/.dotfiles
```

- Define the `config` alias in the current shell scope so that it uses the
  dotfiles repo.

```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

- Check out the actual content from the bare repo to your $HOME

```
config checkout
```

- Set the `showUntrackedFiles` flag to `no` on this local repo

```
config config --local status.showUntrackedFiles no
```

- Set up SSH

Outside the scope of this README for now, but follow the GitHub steps to
[generate a new SSH
key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/),
create your SSH config file, and copy the SSH key to GitHub.

- Set up the local repo to push changes to GitHub

```
config push --set-upstream origin master
```

## MacVim

- Install MacVim through homebrew

```
brew install macvim
```

- Install Vundle as well as all the vim plugins

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall! +qall
```

### Powerline Fonts

[Powerline fonts](https://github.com/powerline/fonts) are used in the terminal
and in vim's Airline plugin.

You'll need to [install the power
fonts](https://powerline.readthedocs.org/en/latest/installation/osx.html#installation-osx).
You can [download the fonts](https://github.com/Lokaltog/powerline-fonts) and
install them, or use the steps below:

- Install the fonts and delete the cloned repo since we don't need it anymore

```
mkdir ~/code
cd ~/code
# clone
git clone https://github.com/powerline/fonts.git --depth=1 powerline-fonts
# install
cd powerline-fonts
./install.sh
# clean-up a bit
cd ..
rm -rf powerline-fonts
```

### Command-T

Now that we've installed the Command-T plugin using Vundle, from up above, we
need to finish installing [Command-T](https://github.com/wincent/Command-T).

- Compile the Command-T compiling the C extensions

```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```

Note: This uses the system ruby, which, as of Mojave, is Ruby 2.3.7.

## iTerm2

Install [iTerm2](https://www.iterm2.com/).

- Use the `zsh` shell by default

```
chsh -s `which zsh`
```

## oh-my-zsh

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) helps manage our zsh
config.

- Make sure submodules are set up from the dotfiles repo

```
cd ~
config submodule update —init
# Not sure if these two are necessary:
config pull --recurse-submodules
config submodule update --recursive
```

- Install oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

iTerm2 includes the [Solarized](http://ethanschoonover.com/solarized) Light
theme, so it's easy to select from the preferences.

Note: There's a default color scheme set in the `.zshrc`, but I don't actually
use that for the colors.

