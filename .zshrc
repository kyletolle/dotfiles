# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Trying to profile ZSH startup as mentioned at https://stevenvanbael.com/profiling-zsh-startup
# Pair this with the command at the end of the file
# zmodload zsh/zprof

eval "$(brew shellenv)"
# Make Homebrew completions available in zsh, before oh-my-szh is loaded.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi
# These ruby configs are for Apple Silicon now!
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
DEFAULT_USER="kyle"
# ZSH_THEME="amuse" # Light mode
# Install steps at https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(
  brew # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
  docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
  docker-compose # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
  dotenv # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dotenv
  encode64 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/encode64
  git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
  git-lfs # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-lfs
  macos # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
  npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
  nvm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
  vi-mode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
  vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
  zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
  zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
)

# 2025.06 Autoload nvm
# See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
NVM_HOMEBREW=$(brew --prefix nvm)
zstyle ':omz:plugins:nvm' autoload yes

# 2025.06 Autoload ssh-agent
# See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

# 2025.06 Autoupdate oh-my-zsh
zstyle ':omz:update' mode auto

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Load ssh agent and add ssh automatically at boot. As of 2025.06, trying the zsh plugin...
# eval "$(ssh-agent -s)" > /dev/null 2>&1
# ssh-add --apple-use-keychain ~/.ssh/id_ed25519 > /dev/null 2>&1

if [ -z $ALREADY_SOURCED ]
then
  ALREADY_SOURCED="yep"

  export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$HOME/.rd/bin:$PATH"

  if [ -f ~/.env.sh ] ; then
    source ~/.env.sh
  fi

  # For everything-wordpress
  export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-wordpress/bin"
  alias ew="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-wordpress/Gemfile bundle exec ew ${@:2}"

  # For everything-cli
  export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-cli/bin"
  alias ev="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-cli/Gemfile bundle exec ev ${@:2}"

  # For everything-myth-to_html
  export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-myth-to_html/bin"
  alias em="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-myth-to_html/Gemfile bundle exec em ${@:2}"

  # For anaconda
  # export PATH=~/anaconda3/bin:$PATH

  export PATH="/usr/local/opt/icu4c/bin:$PATH"
  export PATH="/usr/local/opt/icu4c/sbin:$PATH"

  # For ngrok in my home folder
  # https://ngrok.com/
  export PATH=$PATH:~
  if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi

  # For AWS CLI installed from
  # https://docs.aws.amazon.com/cli/latest/userguide/install-bundle.html#install-bundle-user
  export PATH=~/bin:$PATH
  # Can also install AWS CLI from
  # https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html

  # For PHP 7.4
  export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
  export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
fi

# These are old git aliases
# For newer git alias, see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# alias gs='git status '
# alias ga='git add '
# alias gb='git branch '
# alias gc='git commit'
# alias gd='git diff'
# alias gco='git checkout'
# alias gk='gitk --all&'
# alias gx='gitx --all'
# alias gp='git pull 2>&1 | tee >(grep "migrate" 1>/dev/null && echo "YOU GOT A MIGRATION, DAWG")'
# alias gpu='git push '
# alias gnb='git co -b '
# alias gpnb='git push -u origin HEAD'

alias src="source ~/.zshrc"
alias gvim='mvim'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias be="bundle exec"

# Postgres Commands
# alias psql_start="postgres -D /usr/local/var/postgres"
# Can we try using this one as recommended by postgres installer?
# alias psql_start="pg_ctl -D /usr/local/var/postgres -l logfile start"
# alias psql_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
# alias kill_swap="rm /var/tmp/*.swp"
# alias bf="bundle exec foreman start"
alias brc="bundle exec rails c"
alias bg="bundle exec guard"
alias ber="bundle exec rspec ."

# Using the idea from oh-my-zsh, I want to always exclude some directories
alias grep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack}"
export GREP_COLORS='fn=1;32'
alias cgrep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack} --color=always"
alias ack="ack --ignore-dir={log,tmp,.bundle,vendor,.git,s3,webpack,coverage} --ignore-file=is:{tags,failures.txt} --color"
# alias coded="cd ~/Dropbox/code"
alias kyle="cd ~/Dropbox/code/$USERNAME"
alias everything="cd ~/git/everything"

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
export LC_NUMERIC=en_US.UTF_8 # Set locale

# Load rbenv automatically
# eval "$(rbenv init -)"

# A way to manage dotfiles more easily across machines.
# Based on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Load pyenv automatically
# eval "$(pyenv init -)"

# Secret env vars in ~/.env.sh
alias nrs="npm run start"
alias nwd="npm run watch:docs"
alias nr="npm run"
alias bbl="~/code/bombbomb/app.bombbomb.com/local"
alias los="bbl start"
alias lost="bbl stop"
alias loba="bbl build-all"
alias lobo="bbl bootstrap"
alias lobp="bbl build-php-classes"
alias lobapi="bbl build-api"
alias lobn="bbl build-npm"
alias lobr="bbl build-react"
alias lobj="bbl build-js"
alias lodb="bbl db-deploy"
alias lowr="bbl watch-react"
alias lot=".bbl test"
alias lotu="bbl test tests/unit"
alias lossh="bbl ssh-app"
alias loti='docker exec -it local-app sh -c "/wamp/phpunit.phar -c /wamp/tests/phpunit-configuration-integration.xml /wamp/tests/integration"'
alias lotr="cd www/react && npm run test:watch"
alias lotw="npm run test:watch"
alias aws-login="aws sso login --profile bbapps"

# Docker aliases
## These are older.
# alias dc="docker compose"
# alias dcu="docker compose up"
# alias dcub="docker compose up --build"
alias dockerClean="docker image prune && docker volume prune"
alias dockerNuke="docker system prune"
alias dockerTop='docker stats --all --format "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
## For newer shortcuts, see
#  - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
#  - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker

# From Brian Kopp
## file list aliases
alias l="ls"
alias ll="ls -alh"
alias lg="ls -alh | grep"

## git aliases
alias gl="git log --oneline"
alias gnb="git checkout -b "
alias gc="git commit -m "
alias gs="git status"
alias gf="git fetch"
alias pull="git pull"
alias push="git push"

## docker aliases
alias dimg="docker images"
alias dimgg="docker images | grep"
alias dps="docker ps"
alias db="docker build"
alias dk="docker kill"


## dns stuff
alias mondns="sudo tcpdump -l port 53 2>/dev/null | grep --line-buffered ' A? ' | cut -d' ' -f8"
alias ns="nslookup"
alias nsbust="dscacheutil -flushcache"
alias nsns="nslookup -query=ns"
alias nscname="nslookup -query=cname"
alias ttl="dig +noauthority +noquestion +nostats"

# From Rob Ballou
alias node_reinstall='rm -fr node_modules && nvm use && npm install'
alias yarn_reinstall='rm -fr node_modules && nvm use && yarn install'
alias node_re='rm -fr node_modules && nvm use && rm package-lock.json && npm install'
alias node_rec='rm -fr node_modules && nvm use && npm ci'

# Allows running a specific NPM command for a workspace like `bb2 install --save-dev NewDep` from any dir
function r18() {
    (cd ~/code/bombbomb/app.bombbomb.com && npm --workspace=javascript/react18 "$@")
}
function bb2() {
    (cd ~/code/bombbomb/app.bombbomb.com && npm --workspace=javascript/bb2 "$@")
}

# Lazily load nvm when needed
# From https://gist.github.com/lukeshiru/e239528fbcc4bba9ae2ef406f197df0c
# NOTE: Trying to see if this makes it faster to start up a shell but also be able to use nvm when needed
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
	declare -a __node_commands=(nvm `find -L $NVM_DIR/versions/*/*/bin -type f -exec basename {} \; | sort -u`)
	function __init_nvm() {
		for i in "${__node_commands[@]}"; do unalias $i; done
		. "$NVM_DIR"/nvm.sh
		unset __node_commands
		unset -f __init_nvm
	}
	for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# Calling nvm use automatically in a directory with a .nvmrc file
# From https://github.com/nvm-sh/nvm#zsh
# NOTE: This seems to make shell startup time even slower though.
# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# End ZSH Startup Profiling
# Pair this with the command at the start of the file
# zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
