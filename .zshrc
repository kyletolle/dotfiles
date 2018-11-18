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

if [ -z $ALREADY_SOURCED ]
then
  ALREADY_SOURCED="yep"

  export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"

  if [ -f ~/.env.sh ] ; then
    source ~/.env.sh
  fi

  # added by travis gem
  source /Users/kyle/.travis/travis.sh

  # For everything-wordpress
  export PATH=$PATH:/Users/kyle/Dropbox/code/kyletolle/everything-wordpress/bin
  alias ew="BUNDLE_GEMFILE=/Users/kyle/Dropbox/code/kyletolle/everything-wordpress/Gemfile bundle exec ew ${@:2}"

  # For everything-cli
  export PATH=$PATH:/Users/kyle/Dropbox/code/kyletolle/everything-cli/bin
  alias ev="BUNDLE_GEMFILE=/Users/kyle/Dropbox/code/kyletolle/everything-cli/Gemfile bundle exec ev ${@:2}"

  # For everything-myth-to_html
  export PATH=$PATH:/Users/kyle/Dropbox/code/kyletolle/everything-myth-to_html/bin
  alias em="BUNDLE_GEMFILE=/Users/kyle/Dropbox/code/kyletolle/everything-myth-to_html/Gemfile bundle exec em ${@:2}"

  # For anaconda
  export PATH=~/anaconda3/bin:$PATH
fi

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gp='git pull 2>&1 | tee >(grep "migrate" 1>/dev/null && echo "YOU GOT A MIGRATION, DAWG")'
alias gpu='git push'

alias src="source ~/.zshrc"
alias gvim='mvim'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias be="bundle exec"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias psql_start="postgres -D /usr/local/var/postgres"
alias kill_swap="rm /var/tmp/*.swp"
alias bf="bundle exec foreman start"
alias brc="bundle exec rails c"
alias bg="bundle exec guard"
alias ber="bundle exec rspec ."
alias sdo="ssh root@192.241.212.101"
# Using the idea from oh-my-zsh, I want to always exclude some directories
alias grep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,fulcrum.js}"
export GREP_COLORS='fn=1;32'
alias cgrep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,fulcrum.js} --color=always"
alias code="cd ~/Dropbox/code"
alias kyle="cd ~/Dropbox/code/kyletolle"
alias everything="cd ~/Dropbox/everything"

function http {
  port="${1:-8000}"
  ruby -run -e httpd . -p $port
}

export AUTOFEATURE=true
export PORT=3000 # For starting rails s like on Heroku
export EDITOR=gvim
export HISTSIZE=100000000
export SAVEHIST=100000000

eval "$(rbenv init -)"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
