#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# starts tmux with every new interactive session
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
  tmux attach || tmux >/dev/null 2>&1
fi

alias ls='ls --color=always'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ #default bash prompt'
export EDITOR=nvim

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/griffen/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/griffen/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/griffen/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/griffen/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/griffen/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/griffen/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# NNN configs
source ~/.config/nnn.bash

function n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

export -f n

# customizing bash prompt
PS1="\e[33;1m\u@arch: \e[31m\W \e[0m\$ "
