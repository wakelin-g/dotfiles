export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Library/TeX/texbin/latex:/Library/TeX/texbin/dvips:/opt/homebrew/bin/pstoedit
export PATH=$PATH:/Users/griffen/bin
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"
zstyle ':omz:update' mode disabled

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

plugins=(fd zsh-autosuggestions zsh-syntax-highlighting vi-mode)
source $ZSH/oh-my-zsh.sh

source ~/.zshrc_aliases
source ~/.zshrc_functions
source ~/.zshrc_exports
source ~/.zshrc_conda

if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi
