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

### dotfiles

- Go to your $HOME

```
cd $HOME
```

- Clone the dotfiles into a bare git repo.

```
git clone --bare git@github.com:kyletolle/dotfiles.git $HOME/.dotfiles
```

- Define the `config` alias in the current shell scope so that it uses the
  dotfiles repo

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

### MacVim

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

- Install the fonts and clean up the unneeded repo at the end

```
mkdir -p ~/code/github
cd $_
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

- Install ruby via rbenv
  - Follow the steps at https://github.com/rbenv/rbenv
  - Check for most recent ruby version with `rbenv install --list`
  - Install the latest version of Ruby with `rbenv install 3.1.1`
    - At the time of writing this was 3.1.1, but use a more recent version from the list command above
- Open a new shell and make sure you're using that latest Ruby version
  - `rbenv shell 3.1.1`
- Compile the Command-T compiling the C extensions

```
cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t/
ruby extconf.rb
make
```

Note: We used to use the system Ruby, but that didn't seem to work this most recent time, so we're now using a Ruby from rbenv.

### iTerm2

Install [iTerm2](https://www.iterm2.com/).

- Use the `zsh` shell by default

```
chsh -s `which zsh`
```

iTerm2 includes the [Solarized](http://ethanschoonover.com/solarized) Light
theme, so it's easy to select from the preferences.

Note: There's a default color scheme set in the `.zshrc`, but I don't actually
use that for the colors.

### Pyenv

The `.zshrc` assumes this is installed, so install it with

```
brew install pyenv
```

### oh-my-zsh

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) helps manage our zsh
config.

- Make sure submodules are set up from the dotfiles repo

```
cd ~
config submodule init
config submodule update
# Not sure if these two are necessary:
config pull --recurse-submodules
config submodule update --recursive
```

### Create file for secret env vars

If a file exists at `~/.env.sh` it'll be loaded by our `.zshrc`. Go ahead and create one
with `touch ~/.env.sh` and start adding your secret env vars there.

## Updating

### dotfiles

Follow the approach from the blog post, using git commands, but substitute `config` for `git`.

```
config status
config diff
config add README.md
# Be prompted to add each hunk
config add -p .
# Remove files/folders if you accidentally staged them
config restore --staged .vscode
config commit -m "Add updates to README"
config push
```

