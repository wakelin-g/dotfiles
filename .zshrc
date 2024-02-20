export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Library/TeX/texbin/latex:/Library/TeX/texbin/dvips:/opt/homebrew/bin/pstoedit
export PATH=$PATH:/Users/griffen/bin
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"
zstyle ':omz:update' mode disabled

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(fd zsh-autosuggestions zsh-syntax-highlighting vi-mode)
source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch arm64"
export EDITOR="nvim"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export ZK_NOTEBOOK_DIR="/Users/griffen/knowledgebase/2_Notes"
export EZA_COLORS='da=1;34:gm=1;34'
export BAT_THEME="tokyonight_storm"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"


# export XCBASE="$(xcrun --show-sdk-path)"
# export C_INCLUDE_PATH=$XCBASE/usr/include
# export CPLUS_INCLUDE_PATH=$XCBASE/usr/include
# export LIBRARY_PATH=$XCBASE/usr/lib

# export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P" # fix for R packages not compiling on apple silicon
# export CPATH=/opt/homebrew/include
# export LIBRARY_PATH=/opt/homebrew/lib

# export CC=/usr/bin/clang
# export CXX=/usr/bin/clang++
# export CPPFLAGS="$CPPFLAGS -Xpreprocessor -fopenmp"
# export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
# export CXXFLAGS="$CXXFLAGS -I/usr/local/opt/libomp/include"
# export LDFLAGS="$LDFLAGS -Wl,-rpath,/usr/local/opt/libomp/lib -L/usr/local/opt/libomp/lib -lomp"

alias r="radian"
alias n="ranger"
alias b="bat"
alias t="eza --tree"
alias o="open ."
alias so="source ~/.zshrc"
alias ..="cd .."
alias ~="cd"
alias rg="batgrep --color"
alias grep="grep --color=auto"
alias nf="neofetch"
alias man="batman"
alias approve="xattr -cr"
alias inkscape="/Applications/Inkscape.app/Contents/MacOS/inkscape"

alias ls="eza --group-directories-first"
alias ll="ls -l --git"
alias l="ll -a"
alias lx="ll -sextension"
alias lt="ll -smodified"
alias lk="ll -ssize"
alias lc="ll -schanged"

alias zkn="zk new --title"
alias zke="zk edit -i"
alias zkl="zk list -i"
alias zks="zk scratch"
alias zkj="zk journal"
alias zki="zk idx"
alias nvcd="cd ~/.config/nvim/"
alias confedit="nvim ~/.zshrc"

export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow -E ~/mambaforge/ -E ~/Library -E ~/.cache"
export FZF_DEFAULT_OPTS='
--multi
--height=100%
--layout=reverse
--margin=10%,3%,8%,5%
--border=rounded
--border-label="fzf"
--border-label-pos=-5
--info=hidden
--prompt="fzf> "
--pointer="->"
--marker="{{"
--color=fg:#908caa,bg:#191724,hl:#ebbcba
--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
--color=border:#403d52,header:#31748f,gutter:#191724
--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
'
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/griffen/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/griffen/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/griffen/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/griffen/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/griffen/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/griffen/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# ranger
rangercd() {
	tmp="$(mktemp)"
	ranger --choosedir="$tmp" "$@"
	if [ -f "$tmp" ]; then
	dir="$(cat "$tmp")"
	rm -f "$tmp"
	[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
alias ranger="rangercd"
if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

# fzf
function f() {
    file=$(fzf) && $EDITOR "$file"
}

# quickloof file w/ bat
function bf() {
    bat "$(fzf)"
}

# ripgrepall + fzf
function rgf() {
    RG_PREFIX="rga --files-with-matches"
    local file
    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
	    fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
	        --phony -q "$1" \
		--bind "change:reload:$RG_PREFIX {q}" \
		--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	$EDITOR "$file"
}
test -e /Users/griffen/.iterm2_shell_integration.zsh && source /Users/griffen/.iterm2_shell_integration.zsh || true

# activate conda environment
function a() {
    local choice=$(
        mamba env list |
        sed 's/\*/ /;1,2d' |
        gxargs -I {} bash -c 'name_path=( {} );py_version=( $(${name_path[1]}/bin/python --version) );echo ${name_path[0]} ${py_version[1]} ${name_path[1]}' |
        column -t |
        fzf --layout=reverse \
        --info=inline \
        --border=rounded \
        --height=40 \
        --preview-window="right:30%" \
        --preview-label=" conda tree leaves " \
        --preview=$'conda tree -p {3} leaves | perl -F\'[^\\w-_]\' -lae \'print for grep /./, @F;\' | sort'
    )
    [[ -n "$choice" ]] && mamba activate $(echo "$choice" | gawk '{print $3}')
}

# fzf edit
function fe() {
    IFS=$'\n'
    files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# fzf cd
function ff() {
    local dir
    while true; do
        dir="$(/bin/ls -1ap | grep '/$' | grep -v '^./$' | fzf --height 90% --reverse --no-multi --preview 'pwd' --preview-window=up,1,border-none --no-info)"
        if [[ -z "${dir}" ]]; then
            break
        else
            cd "${dir}" || exit
        fi
    done
}

# search globally including hidden
function fda() {
    cd "$HOME" || exit
    dir="$(fd -a -H -t d "${1:-.}" | fzf +m)"
    cd "$dir" || exit
}

# open with skim
function fpdf() {
    open -a /Applications/Skim.app "$(fd -u -e pdf | fzf --query "$1")"
}

# open file
function fo() {
    open "$(fd -I -a -t f -H "${1:-.}" | fzf +m --exact)"
}

# open application
function ap() {
    open -a "$(find /Applications /System/Applications/ /System/Applications/Utilities -name '*app' -maxdepth 1 -exec basename {} .app \; | fzf --query "$1")"
}

# fkill - kill process
function fkill() {
    local pid

    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | gxargs kill -${1:-9}
    fi
}

# bip - Brew Install Package
function bip() {
    local inst=$(brew search "$@" | fzf -m)
    if [[ $inst ]]; then
        for prog in $(echo $inst);
        do; brew install $prog; done
    fi
}

# bup - Brew Update Package
function bup() {
    local upd=$(brew leaves | fzf -m)
    if [[ $upd ]]; then
        for prog in $(echo $upd);
        do; brew upgrade $prog; done
    fi
}

# bcp - Brew Clean (delete) Package
function bcp() {
    local uninst=$(brew leaves | fzf -m)
    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

##########################################################

# sensible date and time display format
function ti() {
    [ "$#" -eq 0 ] && set -- +'%a, %b %d, %Y %r'
    command date "$@"
}

function manp() {
    man -t "${1}" | open -f -a Skim
}

function ipy() {
    if [[ -f $CONDA_PREFIX/bin/ipython ]]; then
        ipython
    else
        if [[ -z $CONDA_DEFAULT_ENV ]]; then
            printf "conda not activated\n"
        else
            printf "ipython not installed in conda environment '$CONDA_DEFAULT_ENV'\n"
        fi
    fi
}

function gpath() {
    greadlink -f "${1}" | pbcopy
}
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi
