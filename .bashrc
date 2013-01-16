[[ -s "/Users/kyle/.rvm/scripts/rvm" ]] && source "/Users/kyle/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=/usr/local/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$' #Newline after dir

function gvim { /usr/bin/gvim -f "$@" & true; }
alias vim='mvim -v'
alias gvim='mvim'
alias lin='ssh kyle@greywacke.nullsix.com'
##Launch Chrome with given URL from commandline
alias url="open -a /Applications/Google\ Chrome.app"
alias gitk='gitk 2>/dev/null &'

export AUTOFEATURE=true
export JRUBY_OPTS=--1.9
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
# For using git-cola
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

source ~/git-completion.bash
source ~/.env.sh
