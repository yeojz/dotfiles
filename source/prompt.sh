#
# Adapted from https://github.com/sethwoodworth/dotfiles/blob/dot/.bashrc
#

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

# Hostname styles
FULL='\H'
SHORT='\h'

# System => color/hostname map:
#   UC: username color
#   LC: location/cwd color
#   HD: hostname display (\h vs \H)
# Defaults:
UC=$GREEN
LC=$BLUE
HD=$SHORT

# Manually cut hostname; hostname -s bails out on some systems.
case $( hostname | cut -d '.' -f 1 ) in
    jeff | ytram ) UC=$YELLOW LC=$GREEN HD=$SHORT ;;
    bitprophet ) UC=$CYAN ;;
    *-production ) UC=$RED HD=$SHORT ;;
    mail | code | bacula | www* | monitor | bender | xen ) UC=$RED ;;
esac

# Prompt function because PROMPT_COMMAND is awesome
function prompt_command() {
    # Before setting the prompt, start logging the full history, and if there was a success or fail
    echo "$? $(hostname) $PWD $(history 1)" >> ~/.full_history

    # Virtualenv
    _venv=`basename "$VIRTUAL_ENV"`
    venv="" # need this to clear it when we leave a venv
    if [[ -n $_venv ]]; then
        venv="(${_venv})${NIL} "
    fi


    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then

        # Git branch / dirtiness
        # Dirtiness cribbed from:
        # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
        if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
            then _dirty=""
        else
            _dirty="[*]"
        fi

        branch=" (${RED}${_branch} ${_dirty}${NIL})"
    fi

    # Dollar/pound sign
    end="\$${NIL} "




    PS1=""

    #virualenv
    PS1="$PS1${PURPLE}${venv}"
    
    #username
    PS1="$PS1${GREY}\u${NIL}"

    PS1="$PS1${GREY}@"
    #hostname
    PS1="$PS1${GREY}${HD}${NIL}"
    PS1="$PS1:"
    
    #current path
    PS1="$PS1${YELLOW}\W${NIL}"
    
    #time
    PS1="$PS1 ${GREEN}\T${NIL}"
    
    #git branch
    PS1="$PS1${branch}"
    
    #$
    PS1="$PS1 ${end}"

}
PROMPT_COMMAND="prompt_command"