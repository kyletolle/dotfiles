PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$' #Newline after dir

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.0

function gvim { /usr/bin/gvim -f "$@" & true; }
alias vim='mvim -v'
alias gvim='mvim'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias gitk="gitk 2>/dev/null &"
alias be="bundle exec"

export AUTOFEATURE=true
export JRUBY_OPTS=--2.0
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
# For using git-cola
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

source ~/git-completion.bash
if [ -f ~/.env.sh ] ; then
  source ~/.env.sh
fi

# added by travis gem
source /Users/kyle/.travis/travis.sh

export NVM_DIR="/Users/kyle/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
