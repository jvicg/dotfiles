# fish/config.fish
# pretty standard shell configuration
# vim: set ft=fish :

# disable fish greeting
set --global fish_greeting

# path
fish_add_path --global --prepend \
    $HOME/.pyenv/bin \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.local/share/gem/ruby/3.0.0/bin \
    /usr/bin/site_perl \
    /usr/bin/vendor_perl \
    /usr/bin/core_perl

# init external plugins
pyenv init - fish | source
zoxide init --cmd cd fish | source
starship init fish | source
