# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_fcntl_lock      # use fcntl for locking the history file
setopt append_history       # all zsh sessions append to history
# setopt share_history        # shares history across sessions
setopt hist_ignore_all_dups # unique history items only
setopt hist_ignore_space    # dont add lines that start with a space
setopt hist_allow_clobber   # > and >> become >! and >>! in hist
setopt pushd_ignore_dups    # ignore duplicate pushes

# double-handling (see noflowcontrol below)
stty start undef
stty stop undef

#ip_addr=`hostname -i | cut -c1-12 2>&1`

#ip_addr=${ip_addr// /}
# options
setopt autocd           # no cd required
setopt appendhistory    # fuck knows
setopt extendedglob     # extended globs
setopt extendedhistory  # add timestamps to history
setopt globdots         # globs match dotfiles
setopt listtypes        # show autocompleted files with trailing type mark
setopt noflowcontrol    # turn off flowcontrol
setopt noclobber        # >! and >>! to make it happen
setopt nonomatch        # bash-style no glob match behaviour

# unsetopt beep
bindkey -e

# variables
export EDITOR="vim"
export PAGER="less"
export PATH="$PATH:$HOME/bin:$HOME/code/go/bin"
export GOPATH="$HOME/code/go"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export PYTHONDONTWRITEBYTECODE=1
export MYSQL_PS1="\u@\h [\d]> "
export PM_ENV="dev"

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=~/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH

export AUTOENV_DEBUG=0
export AUTOENV_FILE_ENTER=.autoenv.zsh
export AUTOENV_FILE_LEAVE=.autoenv.zsh
export AUTOENV_HANDLE_LEAVE=1
export PIPENV_VENV_IN_PROJECT=1
source ~/.dotfiles/lib/zsh-autoenv/autoenv.zsh

source $HOME/git-prompt.sh

#Python
# source $HOME/.poetry/env

#Rust
# source $HOME/.cargo/env

# completion
autoload -Uz compinit
compinit
# zstyle :compinstall filename '${HOME}/.zshrc'
zstyle :compinstall filename '/home/edgy/.zshrc'

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:*:cdr:*:*' menu selection

# # aliases
alias activate='. .venv/bin/activate'
alias sz='source ~/.zshrc'
alias jc='journalctl --no-pager'
alias jf='journalctl -fa --no-pager'
alias kc='kubectl'
alias mkdir='mkdir -p'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias h='history'
alias j='jobs -l'
alias ..='cd ..'
alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias path='echo -e ${PATH//:/\\n}'
alias hc='herbstclient'
alias spm='sudo pacman'
alias chromium='chromium --user-data-dir=~/.config/chromium/'
alias sql='mysql -u root'
alias grep='grep --color=auto'
alias pep8out='find . -name "*.py" | grep -ve \/migrations\/ | xargs -n 1 -t pycodestyle --max-line-length 120 >| out'
alias settitle='printf \\033]0\;\%s\\007'

alias tf='sudo tail -f'
alias df='df -hT'

# Fuck ubuntu
alias pipenv='python3 -m pipenv --python 3.6'
alias pipenv37='python3 -m pipenv --python 3.7'

# alias -g C='| wc -l'
# alias -g DN=/dev/null
alias -g VLE=/var/log/everything.log
alias -g VLM=/var/log/messages.log
#
# systemd aliases
if [[ '$EUID' == '0' ]]; then
    # these are here just to stop log entries for root user (from sudo calls)
    alias sc='systemctl --no-pager'
    alias spm='pacman'
    

    # UBUNUTU
    alias ai='apt install'
else
    alias sc='sudo systemctl --no-pager'
    alias spm='sudo pacman'
    alias ai='sudo apt install'
fi
alias cg='systemd-cgls'
alias psc='ps xawf -eo pid,user,cgroup,args'

# alias l.='ls -d .[^.]*'
alias la='ls -la'
# alias lc='ls -1 | wc -l'
# alias p='pwd -P'
alias h='hostname'
alias u='whoami'
# alias tree='tree -CF'
alias s='ssh'

# # optional app aliases
# [[ -x =task ]] && alias t='task'

setopt prompt_subst
autoload -U regexp-replace
autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg svn
zstyle ':vcs_info:hg*:*' check-for-changes true
zstyle ':vcs_info:hg*' formats '%{$fg[yellow]%}%s%b '
zstyle ':vcs_info:hg*' actionformats '%{$fg[yellow]%}%b|%a'
zstyle ':vcs_info:hg*' branchformat '-%b'
zstyle ':vcs_info:svn*:*' formats '%{$fg[yellow]%}%s%b '
zstyle ':vcs_info:svn*' actionformats '%{$fg[yellow]%}%b|%a'
zstyle ':vcs_info:svn*' branchformat '-%b'

# function hg_dirty() {
#     hg status 2> /dev/null | awk '$1 == '?' { print '??' } $1 != '?' {print '!!'}' | sort | uniq | head -c2
# }
# 
# function svn_dirty() {
#     svn status 2> /dev/null | awk '$1 == '?' { print '??' } $1 != '?' {print '!!'}' | sort | uniq | head -c2
# }
# 
# precmd () {
#     vcs_info
#     if [[ $(hg_dirty) == '!!' || $(hg_dirty) == '??' ]]
#     then
#         PROMPT_CHAR=$(hg_dirty)
#     else
#         if [[ $(svn_dirty) == '!!' || $(svn_dirty) == '??' ]]
#         then
#             PROMPT_CHAR=$(svn_dirty)
#         else
#             PROMPT_CHAR='>>'
#         fi
#     fi
# }
# PROMPT='${vcs_info_msg_0_}'
# PROMPT_2='$PROMPT_CHAR'
# PS1='%{$fg[cyan]%}%m $PROMPT%{$fg[white]%}$PROMPT_2 '

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

PS1='%{$fg[cyan]%}%m %{$fg[red]%}$(__git_ps1 "(%s) ")%{$fg[white]%}>> '
RPROMPT='%{$fg[magenta]%}%~ %{$fg[magenta]%}%{$fg[white]%}%n'

# keyboard malarkey                                                                                                                                       
autoload zkbd
typeset -g -A key

key[F1]='^[[11~'
key[F2]='^[[12~'
key[F3]='^[[13~'
key[F4]='^[[14~'
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]='^[[19~'
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'
key[Backspace]='^?'
key[Insert]='^[[2~'
key[Home]='^[[7~'
key[PageUp]='^[[5~'
key[Delete]='^[[3~'
key[End]='^[[8~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Left]='^[[D'
key[Down]='^[[B'
key[Right]='^[[C'
key[Menu]=''''

[[ -n ${key[Left]}     ]] && bindkey '${key[Left]}'     backward-char
[[ -n ${key[Right]}    ]] && bindkey '${key[Right]}'    forward-char
[[ -n ${key[Up]}       ]] && bindkey '${key[Up]}'       up-line-or-history
[[ -n ${key[Down]}     ]] && bindkey '${key[Down]}'     down-line-or-history
[[ -n ${key[Home]}     ]] && bindkey '${key[Home]}'     beginning-of-line
[[ -n ${key[End]}      ]] && bindkey '${key[End]}'      end-of-line
[[ -n ${key[PageUp]}   ]] && bindkey '${key[PageUp]}'   history-beginning-search-backward
[[ -n ${key[PageDown]} ]] && bindkey '${key[PageDown]}' history-beginning-search-forward
[[ -n ${key[Delete]}   ]] && bindkey '${key[Delete]}'   delete-char
[[ -n '${key[Insert]}' ]] && bindkey '${key[Insert]}'   overwrite-mode

# .zshrc
# mel boyce <mel@melboyce.com>


mid=`xinput | grep SteelSeries | awk '{ split($9,a,"=");print(a[2]) }'`
[ ! -z $mid ] && sid=`xinput list-props $mid | grep "Natural Scrolling Enabled (" | awk '{ split($5,a,"(");split(a[2],a,")");print a[1] }'`
[ ! -z $sid ] && exec `xinput set-prop $mid $sid 1`


export NVM_DIR="/home/edgy/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

zstyle ':completion:*' menu select
fpath+=~/.zfunc
