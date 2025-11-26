# fish/config.fish
# pretty standard shell configuration

# sources
export fish_greeting                               # disable fish_greeting
source ~/.config/fish/colors.fish                  # set colors using external file
source ~/.aliases                                  # import aliases
source /opt/miniconda3/etc/fish/conf.d/conda.fish  # enable conda

# path
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin /usr/bin /usr/local/bin $HOME/.pyenv/bin $HOME/.cargo/bin $HOME/.config/emacs/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl $HOME/.local/share/gem/ruby/3.0.0/bin $fish_user_paths 

# init pyenv
pyenv init - fish | source

# init zoxide
zoxide init fish | source

# init starship
starship init fish | source

# autorun startx to start awesome WM, if not using Gnome as DE
if status is-login; and test -z "$SSH_TTY"; and test "$DESKTOP_SESSION" != "gnome";
   exec startx > $HOME/.log/awesome/init.log 2>$HOME/.log/awesome/errors.log  # redirect the output of startx to log files
end

# simple backup function
function bak --argument filename
    cp -v $filename $filename.bak
end

# bang-bang funcs
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# bang-bang bindings
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end
