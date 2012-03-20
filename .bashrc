[[ -s "/home/kyle/.rvm/scripts/rvm" ]] && source "/home/kyle/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#alias gvim='gvim -f &'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#${debian_chroot:+($debian_chroot)}\u@\h:\w\$


PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$' #Newline after dir

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi

#alias gvim='gvim -f &'
function gvim { /usr/bin/gvim -f "$@" & true; }

export AUTOFEATURE=true
