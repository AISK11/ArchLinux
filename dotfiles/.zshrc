##########################################################
## File:           ${HOME}/.zshrc                       ##
## Dependencies:   zsh                                  ##
##                 zsh-syntax-highlighting              ##
##                 zsh-completions (recommended)        ##
##                 zsh-autosuggestions (recommended)    ##
## Created:        2022-01-03                           ##
## Updated:        2022-01-04                           ##
## Author:         AISK11                               ##
##########################################################


####################
##     CLEAR      ##
####################
## Security clear:
clear


####################
##     COLORS     ##
####################
### Enable colors (with supressed alias):
autoload -U colors && colors


####################
## COMMAND PROMPT ##
####################
## Get time in format HH:MM:SS:
DATE_TIME=$(date '+%H:%M:%S')


## Define colors:
BLUE="#2c43b8"
YELLOW="#ffd369"

COLOR1=${YELLOW}
COLOR2=${BLUE}

### Command prompt:
## HH:MM:SS user@fullHostName $(pwd) privState
#export PS1="$HOUR%D{:%M:%S} %n@%M %~ %# "
export PS1="%F{${COLOR1}}${DATE_TIME} %F{${COLOR2}}%n%F{${COLOR1}}@%F{${COLOR2}}%M %F{${COLOR1}}%~ %F{$COLOR2}%# %f"


####################
##   COMPLETION   ##
####################
### Enable autocompletion (with supressed alias, using zsh style):
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

### COMPLETION OPTIONS:
## When completion is performed, move cursor to the end of the world:
setopt ALWAYS_TO_END
## Do not autolist options on 1st tab:
setopt no_AUTO_LIST
## Do not autolist parametes on 1st tab:
setopt no_AUTO_PARAM_KEYS
## Do not complete '*' as all matches:
setopt GLOB_COMPLETE
## DONT append first menu result after first tab:
setopt no_MENU_COMPLETE


####################
##    HISTORY     ##
####################
## Append to history file rather then overwrite it, good with multiple zsh sessions:
setopt APPEND_HISTORY
## Timestamp for history commands in history file:
setopt EXTENDED_HISTORY
## Do not enter command to command history if is duplicate of previous command:
setopt HIST_IGNORE_DUPS
## Enter command to command history and delete all previous instnces of this command from history:
setopt HIST_IGNORE_ALL_DUPS
## Immediately write command to history file:
setopt INC_APPEND_HISTORY_TIME
## History should be shared:
setopt SHARE_HISTORY
## History file:
export HISTFILE="${HOME}/.zsh_history"
## History size:
export HISTSIZE=2000
export SAVEHIST=${HISTSIZE}


####################
##      KEYS      ##
####################
### OPTIONS:
## Use Zsh Line Editor (default in interactive shells):
setopt ZLE
## Use vi-like controlling:
setopt VI
## Time in 0.0X of second for another key to be pressed when reading bound multi-char sequences:
export KEYTIMEOUT=1

### Map keys:
## Create a zkbd compatible hash:
typeset -g -A key

key[Backspace]="${terminfo[kbs]}"
key[Insert]="${terminfo[kich1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Delete]="${terminfo[kdch1]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"

## Setup keys:
[[ -n "${key[Backspace]}"   ]] && bindkey -- "${key[Backspace]}"    backward-delete-char
[[ -n "${key[Insert]}"      ]] && bindkey -- "${key[Insert]}"       overwrite-mode
[[ -n "${key[Up]}"          ]] && bindkey -- "${key[Up]}"           up-line-or-history
[[ -n "${key[Down]}"        ]] && bindkey -- "${key[Down]}"         down-line-or-history
[[ -n "${key[Left]}"        ]] && bindkey -- "${key[Left]}"         backward-char
[[ -n "${key[Right]}"       ]] && bindkey -- "${key[Right]}"        forward-char
[[ -n "${key[Home]}"        ]] && bindkey -- "${key[Home]}"         beginning-of-line
[[ -n "${key[End]}"         ]] && bindkey -- "${key[End]}"          end-of-line
[[ -n "${key[Delete]}"      ]] && bindkey -- "${key[Delete]}"       delete-char
[[ -n "${key[Shift-Tab]}"   ]] && bindkey -- "${key[Shift-Tab]}"    reverse-menu-complete
[[ -n "${key[PageUp]}"      ]] && bindkey -- "${key[PageUp]}"       beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"    ]] && bindkey -- "${key[PageDown]}"     end-of-buffer-or-history

## Make sure that terminal is in application mode, when zle is active,
## otherwise $terminfo values are invalid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop  { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init   zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


####################
##    CURSORS     ##
####################


####################
##    GLOBBING    ##
####################
## Also treat '^', '#' and '~' as globbing:
setopt EXTENDED_GLOB
## Do not match dotfiles:
setopt no_GLOB_DOTS
### Path:
## Add direcotries to access it's commands:
export PATH="${PATH}"

## Support commands with '#' (comment) at the end:
setopt interactivecomments


#########################
## CHANGE DIRECTORIES  ##
#########################
## DONT auto cd to dir when non-exec file specified:
setopt AUTO_CD
## When cd, push directory to the directory stack:
setopt AUTO_PUSHD
## Ignore multiple copies of the same dir on the stack:
setopt PUSHD_IGNORE_DUPS
## Pushd with no arguments ack like pushd ${HOME}:
setopt PUSHD_TO_HOME
## Do not print directory (cd -):
setopt CD_SILENT
## Do not print directroy stack after pushd or popd:
setopt PUSHD_SILENT


####################
##    ALIASES     ##
####################
## Auto colors:
#COLOR_MODE="auto"  ## does not persist colors when piped/redirected
COLOR_MODE="always" ## persist colors when piped/redirected

## Aliases with colors:
alias ls="ls --color=${COLOR_MODE}"
alias grep="grep --color=${COLOR_MODE}"
alias egrep="egrep --color=${COLOR_MODE}"
alias diff="diff --color=${COLOR_MODE}"
alias ip="ip --color=${COLOR_MODE}"
alias dmesg='dmesg --color=always'
## Interpret colors in 'less':
export LESS='-R --use-color -Dd+r$Du+b'

## Aliases:
alias mtr='mtr -r'


#####################
## ALIAS FUNCTIONS ##
#####################
### System:
## See how much RAM process uses:
## Usage: $(mem <PROGRAM-NAME>)
mem()
{
    ps -eo rss,pid,euser,args --sort %mem | grep -i $@ | grep -v grep | awk '{printf $1/1024 "MB"; $1=""; print }'
}

### Network:
## Enable IPv4 forwarding:
ipv4_forward_yes()
{
    doas bash -c 'echo "1" > /proc/sys/net/ipv4/ip_forward'
}
## Disable IPv4 forwarding:
ipv4_forward_no()
{
    doas bash -c 'echo "0" > /proc/sys/net/ipv4/ip_forward'
}


#####################
##      Xorg       ##
#####################
if [[ -z ${DISPLAY} ]] && [[ $(tty) == "/dev/tty1" ]]; then
    source /etc/profile
    #startx
fi


#########################
##   Autosuggestions   ##
#########################
## Autosuggest commands from the history:
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


#########################
## Syntax highlighting ##
#########################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

