#!/bin/sh

# ignore same successive entries and duplicates
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth


# Color codes
RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
PURPLE='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
GREY='\[\033[0;90m\]'
NIL='\[\033[00m\]'


# __git_ps1 Settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWCOLORHINTS=
#GIT_PS1_DESCRIBE_STYLE="branch"
#GIT_PS1_SHOWUPSTREAM="auto git"


# misc
function get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}


#
#   Main Prompt
#
function prompt_command() {


    # Virtualenv
    _venv=`basename "$VIRTUAL_ENV"`
    venv="" # need this to clear it when we leave a venv

    if [[ -n $_venv ]]; then
        venv="(${_venv})${NIL} "
    fi

    PS1="\n"

    #
    #   FIRST LINE
    #

    #username
    PS1="$PS1${GREY}\u${NIL}"
    
    # @
    PS1="$PS1${GREY}@"

    #hostname
    PS1="$PS1${GREY}\h${NIL}"

    #full path
    PS1="$PS1:${GREY}\w${NIL} \n"

    #current path
    #PS1="$PS1 [${YELLOW}\W${NIL}]"

    #
    #   SECOND LINE
    #

    #virualenv
    PS1="$PS1${PURPLE}${venv}"


    #time
    PS1="$PS1${GREEN}\t${NIL}"

    #git branch
    PS1="$PS1${RED}$(__git_ps1)${NIL}"

    #$
    PS1="$PS1 \$ "
}


PROMPT_COMMAND="prompt_command"
