# .bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt configuration
PS1="[\u@\h \W]\\$ "

# import aliases
[[ -f $HOME/.aliases ]] && . $HOME/.aliases

# hist
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# shopt
shopt -s autocd           # change to named directory
shopt -s cdspell          # autocorrects cd misspellings
shopt -s cmdhist          # save multi-line commands in history as single line
shopt -s dotglob          # wildcards (e.g * or ?) will include .dotfiles
shopt -s histappend       # do not overwrite history
shopt -s expand_aliases   # expand aliases
shopt -s checkwinsize     # checks term size when bash regains control

# enable programmable completion features 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi

# bindings
bind "set completion-ignore-case on"  # ignore upper and lowercase when TAB completion

# kill proccesses function
pk()
{
  if pids=$(pidof $1); then
    for pid in $pids; do 
      kill -s 15 $pid
    done
  else
    echo "warning: the process '$1' was not found" 
  fi
}
