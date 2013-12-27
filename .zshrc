# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
DEFAULT_USER="kyle"
ZSH_THEME="cloud" # I liked this one a lot. Minimal and the colors are nice.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Customize to your needs...
export PATH=/Users/kyle/.gem/bin:/usr/local/bin:/usr/local/sbin:$PATH

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.1

if [ -f ~/.env.sh ] ; then
  source ~/.env.sh
fi

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gp='git pull 2>&1 | tee >(grep migration 1>/dev/null && echo "YOU GOT A MIGRATION, DAWG")'

alias src="source ~/.zshrc"
function gvim { /usr/bin/gvim -f "$@" & true; }
alias vim='mvim -v'
alias gvim='mvim'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias be="bundle exec"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias psql_start="postgres -D /usr/local/var/postgres"
alias cs="cake start"
alias kill_swap="rm /var/tmp/*.swp"
alias bf="bundle exec foreman start"
alias brc="bundle exec rails c"
alias beg="bundle exec guard"
alias ber="bundle exec rspec ."
alias prc="pry -r ./config/environment.rb"
alias sdo="ssh root@192.241.212.101"

export GEM_HOME=~/.gem
export GEM_PATH=~/.gem
export AUTOFEATURE=true
export JRUBY_OPTS=--2.0
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
# For using git-cola
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PORT=3000 # For starting rails s like on Heroku

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
