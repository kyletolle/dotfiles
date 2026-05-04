# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Trying to profile ZSH startup as mentioned at https://stevenvanbael.com/profiling-zsh-startup
# Pair this with the command at the end of the file
# zmodload zsh/zprof

# OS detection — used throughout this file to gate platform-specific config.
case "$OSTYPE" in
  darwin*) IS_MAC=1 ;;
  linux*)  IS_LINUX=1 ;;
esac

# --- Mac-only pre-OMZ setup ---
if [[ -n "$IS_MAC" ]]; then
  # Apple Silicon Homebrew Ruby
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
fi

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
  npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
  nvm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
  vi-mode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
  vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
  zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
  zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
)
# macos plugin is Mac-only
if [[ -n "$IS_MAC" ]]; then
  plugins+=(macos)
fi

# 2025.06 Autoload nvm
# See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
if command -v brew >/dev/null 2>&1; then
  NVM_HOMEBREW=$(brew --prefix nvm 2>/dev/null)
fi
zstyle ':omz:plugins:nvm' autoload yes

# 2025.06 Autoload ssh-agent
# See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
if [[ -n "$IS_MAC" ]]; then
  # --apple-load-keychain is macOS-specific (keychain integration)
  zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
fi

# 2025.06 Autoupdate oh-my-zsh
zstyle ':omz:update' mode auto

# Homebrew (Mac: /opt/homebrew, Intel Mac: /usr/local, Linux: /home/linuxbrew/.linuxbrew)
if [[ -n "$IS_MAC" ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
elif [[ -n "$IS_LINUX" ]]; then
  if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Make Homebrew completions available in zsh, before oh-my-zsh is loaded.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
# Set up zshcompletions too
# See https://github.com/zsh-users/zsh-completions?tab=readme-ov-file#oh-my-zsh
FPATH="${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src:$FPATH"
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Load ssh agent and add ssh automatically at boot. As of 2025.06, trying the zsh plugin...
# eval "$(ssh-agent -s)" > /dev/null 2>&1
# ssh-add --apple-use-keychain ~/.ssh/id_ed25519 > /dev/null 2>&1

if [ -z $ALREADY_SOURCED ]
then
  ALREADY_SOURCED="yep"

  # Common PATH additions (cross-platform)
  export PATH="$HOME/.local/bin:$PATH"

  if [ -f ~/.env.sh ] ; then
    source ~/.env.sh
  fi

  # --- Mac-only PATH additions ---
  if [[ -n "$IS_MAC" ]]; then
    export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$HOME/.rd/bin:$PATH"

    # For everything-wordpress
    export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-wordpress/bin"
    alias ew="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-wordpress/Gemfile bundle exec ew ${@:2}"

    # For everything-cli
    export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-cli/bin"
    alias ev="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-cli/Gemfile bundle exec ev ${@:2}"

    # For everything-myth-to_html
    export PATH="$PATH:/Users/$USERNAME/Dropbox/code/kyletolle/everything-myth-to_html/bin"
    alias em="BUNDLE_GEMFILE=/Users/$USERNAME/Dropbox/code/kyletolle/everything-myth-to_html/Gemfile bundle exec em ${@:2}"

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

    # For PHP 7.4
    export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
    export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
  fi

  # --- Linux-only PATH additions ---
  if [[ -n "$IS_LINUX" ]]; then
    export PATH="$HOME/.bun/bin:$HOME/.npm-global/bin:$PATH"
  fi
fi

# These are old git aliases
# For newer git alias, see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# alias gs='git status '
# ...

# --- Universal aliases ---
alias src="source ~/.zshrc"
alias be="bundle exec"
# Terminal multiplexer convenience (tmux + zellij are cross-platform)
alias t="tmux attach -t claude || tmux new -s claude"
alias z="zellij attach --create"

# --- Mac-only aliases ---
if [[ -n "$IS_MAC" ]]; then
  alias gvim='mvim'
  ## Launch Chrome with given URL from commandline
  alias url="open -a /Applications/Google\ Chrome.app"
  ## DNS cache flush (macOS)
  alias nsbust="dscacheutil -flushcache"
fi

# --- Linux-only aliases (Bruce workspace) ---
if [[ -n "$IS_LINUX" ]]; then
  alias p="pmux attach -t claude || pmux new-session -s claude"
  # Hermes / Claude agent launchers
  alias hs="cd ~/vault && hermes"
  alias hsr="cd ~/vault && hermes --resume"
  alias cheap='hermes chat -m "qwen/qwen3.5-flash-02-23" -Q -q'
  alias cs="claude-start"
  alias cst="claude-start --channels plugin:telegram@claude-plugins-official"
  alias csr="claude-start --resume"
  alias csrt="claude-start --channels plugin:telegram@claude-plugins-official --resume"
  alias cu="claude update"
  alias hu="hermes update"
  ## DNS cache flush (systemd-resolved)
  alias nsbust="sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches"

  alias m="moshi ~/vault"

  # Create or attach a named tmux session rooted at a directory
  moshi() {
    local dir="${1:-$PWD}"
    if [[ ! -d "$dir" ]]; then
      echo "Directory not found: $dir" >&2
      return 1
    fi
    local abs
    abs="$(cd "$dir" && pwd)"
    local session
    session="$(basename "$abs" | tr -cs '[:alnum:]_-' '-')"
    session="${session#-}"
    session="${session%-}"
    [[ -n "$session" ]] || session="main"
    if ! tmux has-session -t "$session" 2>/dev/null; then
      tmux new-session -d -s "$session" -c "$abs"
    fi
    tmux attach -t "$session"
  }
fi

# Postgres Commands (commented)
# alias psql_start="postgres -D /usr/local/var/postgres"
alias brc="bundle exec rails c"
alias bg="bundle exec guard"
alias ber="bundle exec rspec ."

# Using the idea from oh-my-zsh, I want to always exclude some directories
alias grep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack}"
export GREP_COLORS='fn=1;32'
alias cgrep="grep --exclude-dir={log,tmp,.bundle,vendor,.git,s3,webpack} --color=always"
alias ack="ack --ignore-dir={log,tmp,.bundle,vendor,.git,s3,webpack,coverage} --ignore-file=is:{tags,failures.txt} --color"

# Dropbox-based code navigation (Mac only)
if [[ -n "$IS_MAC" ]]; then
  alias kyle="cd ~/Dropbox/code/$USERNAME"
fi
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

# Add pyenv to path and init (only if installed)
if command -v pyenv >/dev/null 2>&1 || [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# Secret env vars in ~/.env.sh
alias nrs="npm run start"
alias nwd="npm run watch:docs"
alias nr="npm run"

# --- BombBomb local-dev shortcuts (Mac only) ---
if [[ -n "$IS_MAC" ]]; then
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

  ## Workspace NPM helpers
  function r18() {
      (cd ~/code/bombbomb/app.bombbomb.com && npm --workspace=javascript/react18 "$@")
  }
  function bb2() {
      (cd ~/code/bombbomb/app.bombbomb.com && npm --workspace=javascript/bb2 "$@")
  }
fi

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
alias nsns="nslookup -query=ns"
alias nscname="nslookup -query=cname"
alias ttl="dig +noauthority +noquestion +nostats"

# From Rob Ballou
alias node_reinstall='rm -fr node_modules && nvm use && npm install'
alias yarn_reinstall='rm -fr node_modules && nvm use && yarn install'
alias node_re='rm -fr node_modules && nvm use && rm package-lock.json && npm install'
alias node_rec='rm -fr node_modules && nvm use && npm ci'

# Lazily load nvm when needed (archived — nvm oh-my-zsh plugin handles this now)

# Calling nvm use automatically in a directory with a .nvmrc file (archived)

# iTerm2 shell integration (Mac only)
if [[ -n "$IS_MAC" ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# End ZSH Startup Profiling
# Pair this with the command at the start of the file
# zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by LM Studio CLI (lms) — Mac only (hard-coded /Users path)
if [[ -n "$IS_MAC" ]]; then
  export PATH="$PATH:/Users/kyletolle/.cache/lm-studio/bin"
fi
# End of LM Studio CLI section
