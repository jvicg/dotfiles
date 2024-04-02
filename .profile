# .profile

# path
export PATH=$HOME/.local/bin:$HOME/.config/emacs/bin:$HOME/.cargo/bin:$PATH

# login configuration
[[ -f "$HOME/.bashrc" ]] && . $HOME/.bashrc       # load bashrc
[[ -n "$SSH_CLIENT" ]] && fish                    # set fish for ssh connections
[[ -d "$HOME/tmp" ]] && /bin/rm -rf $HOME/tmp/*   # clear tmp dir

# adjust umask
umask 0027

# default programs
export TERM="alacritty"
export NAVIGATOR="brave"
export EDITOR="nvim"
export VISUAL="code"

# configuration related envvars
export VAGRANT_HOME="/media/nrk/storage/vir/vagrant"
export LIBVIRT_DEFAULT_URI="qemu:///system"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

