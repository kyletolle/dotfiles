# Trying to profile ZSH startup as mentioned at https://stevenvanbael.com/profiling-zsh-startup
# Pair this with the command at the end of the file
# zmodload zsh/zprof

# Make Homebrew completions available in zsh, before oh-my-szh is loaded.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
# Make ruby-build use a homebrew'd OpenSSL
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# Use homebrew ruby as the default ruby
# Following advice from https://stackoverflow.com/a/54268289
# Then running `brew info ruby` to get commands to add here:
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

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
plugins=(
  git
  vscode
  node
  nvm
  postgres
  macos
  encode64
  dotenv
  docker
)


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
  # test -x ~/.travis/travis.sh && source $_

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
alias gpu='git push '
alias gnb='git co -b '
alias gpnb='git push -u origin HEAD'

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

# Load rbenv automatically
eval "$(rbenv init -)"

# A way to manage dotfiles more easily across machines.
# Based on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Load pyenv automatically
eval "$(pyenv init -)"

# Secret env vars in ~/.env.sh
alias nrs="npm run start"
alias nwd="npm run watch:docs"
alias los="./local start"
alias loba="./local build-all"
alias lobp="./local build-php-classes"
alias lobn="./local build-npm"
alias lobr="./local build-react"
alias lodb="./local db-deploy"
alias lowr="./local watch-react"
alias lot="./local test"
alias lotu="./local test tests/unit"
alias loti='docker exec -it local-app sh -c "/wamp/phpunit.phar -c /wamp/tests/phpunit-configuration-integration.xml /wamp/tests/integration"'
alias lotr="cd www/react && npm run test:watch"
alias lotw="npm run test:watch"

# Docker aliases
alias dc="docker compose"
alias dcu="docker compose up"
alias dcub="docker compose up --build"
alias dockerClean="docker image prune && docker volume prune"
alias dockerNuke="docker system prune"
alias dockerTop='docker stats --all --format "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

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

## kubernetes aliases
alias k="kubectl"
alias kp="kubectl get pods"
alias kpa="kubectl get pods --all-namespaces"
alias kpag="kubectl get pods --all-namespaces | grep"
alias kpg="kubectl get pods | grep"
alias kpw="kubectl get pods -o wide"
alias kpwg="kubectl get pods -o wide | grep"
alias kpaw="kubectl get pods -o wide --all-namespaces"
alias kpawg="kubectl get pods -o wide --all-namespaces | grep"
alias kpo="kubectl get pod -o yaml"
alias kpbad="kubectl get pods -o wide --all-namespaces | grep -vE 'Running|Completed'"
alias keg="kubectl get events | grep"
alias ks="kubectl get services"
alias ksg="kubectl get services | grep"
alias kso="kubectl get services -o yaml"
alias ki="kubectl get ingress"
alias kio="kubectl get ingress -o yaml"
alias kig="kubectl get ingress | grep"
alias kcc="kubectl config current-context"
alias kuc="kubectl config use-context"
alias kcurl="kubectl run -i --tty --rm --image=radial/busyboxplus:curl --restart=Never curl -- sh"
alias kredis="kubectl run -i --tty --rm --image=goodsmileduck/redis-cli:latest --restart=Never rediscli -- sh"
alias kl="kubectl logs"
alias mk="minikube"
alias msu="minikube service --url"
alias kdecode="k get secrets -o go-template='{{range \$k,\$v := .data}}{{\$k}}{{\": \\\"\"}}{{\$v | base64decode }}{{\"\\\"\\n\"}}{{end}}'"
alias kimg="kubectl get pod -o=jsonpath='{.spec.containers[*].image}'"

## k8s functions
kn() {
    kubectl config set-context --current --namespace="$1"
}
kcurlname() {
    kubectl run -i --tty --rm --image=radial/busyboxplus:curl --restart=Never $1 -- sh
}
klf() {
    if [[ $2 -eq 0 ]]
    then
        kubectl logs -f $1
    else
        kubectl logs -n $1 -f $2
    fi
}
klfg() {
    if [[ $3 -eq 0 ]]
    then
        kubectl logs -f $1 | grep $2
    else
        kubectl logs -n $1 -f $2 | grep $3
    fi
}
klg() {
    if [[ $3 -eq 0 ]]
    then
        kubectl logs $1 | grep $2
    else
        kubectl logs -n $1 $2 | grep $3
    fi
}
kld() {
    kubectl logs --all-containers=true --follow deployment/$1
}
kflapp() {
    kubectl logs -f --all-containers=true --max-log-requests=30 -l app=$1
}
kegtop() {
    kubectl get events --sort-by=".lastTimestamp" | grep $1 | tail -n 20 -r
}
ketop() {
    kubectl get events --sort-by=".lastTimestamp" | tail -n 20 -r
}
kca() {
    kubectl logs -n kube-system $(kpawg cluster-autoscaler | awk '{print$2}') | tail -n 50
}
kcaf() {
    kubectl logs -f -n kube-system $(kpawg cluster-autoscaler | awk '{print$2}')
}
# Use like
#     poll curl https://yourservice.com/health-check
poll() {
     while true; do $@ ; echo ""; sleep 0.1; done
}
pollpods() {
    while true; do kubectl get pods --all-namespaces -o wide | grep $1 ; echo ""; sleep 0.5; done
}
pollbad() {
    while true; do kubectl get pods --all-namespaces -o wide | grep -vE 'cattle|Running|Completed' ; echo ""; sleep 0.5; done
}

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

# Copied from https://github.com/nvm-sh/nvm#install--update-script
# NOTE: This takes a decent chunk of time when opening a new shell
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
