export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\] \[\033[01;35m\]\t\[\033[00m\]\$ '

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

HISTSIZE=1000
HISTFILESIZE=2000

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi