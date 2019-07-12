# Make Homebrew completions available in zsh, before oh-my-szh is loaded.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

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
  # source ~/.travis/travis.sh
  # But lets test whether the file exists before running it...
  # Found this at: https://stackoverflow.com/questions/21926647/how-to-execute-a-script-only-if-it-is-present-in-bash
  test -x ~/.travis/travis.sh && source $_

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

  export PATH="/usr/local/opt/icu4c/bin:$PATH"
  export PATH="/usr/local/opt/icu4c/sbin:$PATH"

  # For Realvolve's imagemagick
  export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
  export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
  export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"
  # For Realvolve's Solr
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home"

  # For ngrok in my home folder
  # https://ngrok.com/
  export PATH=$PATH:~

  # For AWS CLI installed from
  # https://docs.aws.amazon.com/cli/latest/userguide/install-bundle.html#install-bundle-user
  export PATH=~/bin:$PATH
fi

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gp='git pull 2>&1 | tee >(grep "migrate" 1>/dev/null && echo "YOU GOT A MIGRATION, DAWG")'
alias gpu='git push'

alias src="source ~/.zshrc"
alias gvim='mvim'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias be="bundle exec"

# Postgres Commands
alias psql_start="postgres -D /usr/local/var/postgres"
# Can we try using this one as recommended by postgres installer?
# alias psql_start="pg_ctl -D /usr/local/var/postgres -l logfile start"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias kill_swap="rm /var/tmp/*.swp"
# alias bf="bundle exec foreman start"
alias brc="bundle exec rails c"
alias bg="bundle exec guard"
alias ber="bundle exec rspec ."
alias ssh_rv_solr_prod="ssh ubuntu@52.71.60.36"
# Using the idea from oh-my-zsh, I want to always exclude some directories
alias grep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack}"
export GREP_COLORS='fn=1;32'
alias cgrep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack} --color=always"
alias ack="ack --ignore-dir={log,tmp,.bundle,vendor,.git,s3,webpack,coverage} --ignore-file=is:{tags,failures.txt} --color"
alias code="cd ~/Dropbox/code"
alias kyle="cd ~/Dropbox/code/kyletolle"
alias everything="cd ~/Dropbox/everything"

# Realvolve aliases
alias fs="bundle exec foreman start -f Procfile.full.dev"
alias hpr="heroku run -a realvolve-production rails c"
alias hpl="heroku logs -a realvolve-production"
alias hplt="heroku logs --tail -a realvolve-production"
alias hqr="heroku run -a realvolve-qa-acceptance rails c"
alias hql="heroku logs -a realvolve-qa-acceptance"
alias hqlt="heroku logs --tail -a realvolve-qa-acceptance"

# To use the default port, run `http`. Then visit `localhost:8000`.
# To change the port, run `http 8001`. Then visit `localhost:8001`.
function http {
  port="${1:-8000}"
  ruby -run -e httpd . -p $port
}

export AUTOFEATURE=true
export PORT=3000 # For starting rails s like on Heroku
export EDITOR=gvim
export HISTSIZE=100000000
export SAVEHIST=100000000

# Load rbenv automatically
eval "$(rbenv init -)"

# A way to manage dotfiles more easily across machines.
# Based on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Load pyenv automatically
eval "$(pyenv init -)"
