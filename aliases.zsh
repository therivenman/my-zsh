# general aliases
alias ll='ls -al'
alias la='ls -A'
alias lah='ls -lah'
alias l='ls -CF'
alias apt-get='sudo apt-get'
alias apt='sudo apt'

alias grep='grep --color --exclude=\*.svn'
alias ngrep='grep -n --color --exclude=\*.svn'
alias crgrep='grep -rni	--include={*.c,*.cpp,*.h,*.icc,*.mk,{M,m}akefile{*},*.py,*.pyc}'
alias quickack='ack-grep --thpppt;ack-grep -icl'

alias back='popd -q'

alias ssh='TERM=xterm-256color ssh'

alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'
