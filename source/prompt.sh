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
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]; then
    echo " +"
  else
    echo ""
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





PS1=""

PS1="$PS1\n"

PS1="$PS1[\033[0;33m\]\w"
PS1="$PS1\[\033[0m\]]"

PS1="$PS1\n"
#PS1="$PS1\033[0;33m\]\u"
#PS1="$PS1\[\033[0m\]"

#PS1="[$PS1@\[\033[0;33m\]\h"
#PS1="$PS1\[\033[0m\]]"


PS1="$PS1 \[\033[0;90m\]\T"
PS1="$PS1\[\033[0m\]"

PS1="$PS1 \[\033[0;34m\]$(parse_git_branch_or_tag)"
PS1="$PS1\[\033[0m\]"

PS1="$PS1\$ "
#PS1="\u@\h:\w\$(parse_git_branch_or_tag) $ "

