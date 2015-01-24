export MYZSH=$HOME/.my-zsh

# Add my own function path for completions
fpath=($MYZSH/completions $fpath)
autoload -U compinit
compinit
