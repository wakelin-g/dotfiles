# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/griffen/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/griffen/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/griffen/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/griffen/.fzf/shell/key-bindings.zsh"
