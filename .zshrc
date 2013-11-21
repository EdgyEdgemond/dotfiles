# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_fcntl_lock      # use fcntl for locking the history file
setopt append_history       # all zsh sessions append to history
# setopt share_history        # shares history across sessions
setopt hist_ignore_all_dups # unique history items only
setopt hist_ignore_space    # don't add lines that start with a space
setopt hist_allow_clobber   # > and >> become >! and >>! in hist
setopt pushd_ignore_dups    # ignore duplicate pushes

# double-handling (see noflowcontrol below)
stty start undef
stty stop undef

ip_addr=`hostname -i 2>&1`

ip_addr=${ip_addr// /}
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

unsetopt beep
bindkey -e

# variables
export EDITOR="vim"
export PAGER="vimpager"
export PATH="$PATH:$HOME/bin"
export TMP="$HOME/tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export WORKON_HOME=$HOME/.virtualenvs
# export BROWSER='/usr/bin/dwb'

source /usr/bin/virtualenvwrapper.sh
source /usr/share/git/completion/git-prompt.sh

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
alias jc='journalctl --no-pager'
alias jf='journalctl -fa --no-pager'
alias mkdir='mkdir -p'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias h='history'
alias j='jobs -l'
alias ..='cd ..'
alias gs='git status'
alias gc='git commit'
alias gd='git diff'
alias path='echo -e ${PATH//:/\\n}'
alias hc='herbstclient'
alias spm='sudo pacman'
alias chromium='sudo chromium --user-data-dir=~/.config/chromium/'
alias mkvirtualenv2='mkvirtualenv -p $(which python2.7)'
alias won='workon'
alias woff='deactivate && cd'
alias pi2='pip-2.7 install'
alias sql='mysql -u root'
alias pep8out='find . -name "*.py" | grep -ve \/migrations\/ | xargs -n 1 -t pep8 --max-line-length 120 >| out'
alias settitle='printf \\033]0\;\%s\\007'

alias bootstore='settitle Store && won store && ./manage.py runserver $ip_addr:8000'
alias bootlocker='settitle Locker && won locker && ./manage.py runserver $ip_addr:8001'
alias bootconman='settitle Conman && won conman && ./manage.py runserver $ip_addr:8002'
alias bootpostman='settitle Postman && won postman && ./manage.py runserver $ip_addr:8003'
alias bootauth='settitle Auth && won authenticate && ./manage.py runserver $ip_addr:8004'
alias bootservice='settitle ServiceManager && won service_manager && ./manage.py runserver $ip_addr:8005'
alias bootcust='settitle CustomerService && won customer_service && ./manage.py runserver $ip_addr:8006'
alias boothb='settitle Heartbeat && won heartbeat && python local_run.py'
alias bootkey='settitle KeyDelivery && won keydelivery && ./manage.py runserver $ip_addr:8008'
alias bootflower='settitle Flower && flower --address=$ip_addr --port=8009 --broker=amqp://guest@localhost:5672//'
alias bootmonitor='settitle Monitor && won monitor && python app.py'
alias bootimage='settitle Image && won image && ./manage.py runserver $ip_addr:8012'

alias tf='sudo tail -f'
# alias df='df -hT'

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
else
    alias sc='sudo systemctl --no-pager'
    alias spm='sudo pacman'
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





