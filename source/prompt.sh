# ANSI CODES - SEPARATE MULTIPLE VALUES WITH ;
#
#  0  reset          4  underline
#  1  bold           7  inverse
#
# FG  BG  COLOR     FG  BG  COLOR
# 30  40  black     34  44  blue
# 31  41  red       35  45  magenta
# 32  42  green     36  46  cyan
# 33  43  yellow    37  47  white
# \[\e[0;31m\]
# \[\033[0;30m\]
# RESET \[\033[0m\]

parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'


}

parse_git_tag () {
  git describe --tags 2> /dev/null
}

parse_git_changes(){
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]; then
    echo "+"
  fi
}

parse_git_branch_or_tag() {
  local OUT="$(parse_git_branch)"

  if [ "$OUT" == "(no branch)" ]; then
    OUT="$(parse_git_tag)";
  fi

  if [[ "$OUT" ]]; then
    OUT="($OUT$(parse_git_changes))"
  fi
  echo $OUT
}


# Exit code of previous command.
function prompt_exitcode() {
  [[ $1 != 0 ]] && echo " $1"
}


prompt_command(){
  local exit_code=$?
  # If the first command in the stack is prompt_command, no command was run.
  # Set exit_code to 0 and reset the stack.
  [[ "${prompt_stack[0]}" == "prompt_command" ]] && exit_code=0
  prompt_stack=()

  PS1=""

  PS1="$PS1\n"

  PS1="$PS1[\033[0;33m\]\w"
  PS1="$PS1\[\033[0m\]]"

  PS1="$PS1\n"
  PS1="$PS1\033[0;32m\]\u"
  PS1="$PS1\[\033[0m\]"

  #PS1="[$PS1@\[\033[0;33m\]\h"
  #PS1="$PS1\[\033[0m\]]"


  PS1="$PS1 \[\033[0;90m\]\T"
  PS1="$PS1\[\033[0m\]"

  PS1="$PS1 \[\033[0;34m\]$(parse_git_branch_or_tag)"
  PS1="$PS1\[\033[0m\]"

  PS1="$PS1\$ "
#PS1="\u@\h:\w\$(parse_git_branch_or_tag) $ "

  PS1="$PS1$(prompt_exitcode "$exit_code")"
}

PROMPT_COMMAND="prompt_command"

