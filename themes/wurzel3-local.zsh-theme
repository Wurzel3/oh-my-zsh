# Theme with full path names and hostname
# Handy if you work on different servers all the time;
#PROMPT='%{$fg[yellow]%}$(hostname -f)%{$reset_color%}:%{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%/%{$reset_color%} $(git_prompt_info) %(!.#.$) '

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ -z $ref ]; then
    # check if in detached HEAD mode
    branch_name=$(git status -sb $(git_submodule_syntax) 2> /dev/null | head -n 1)
    if [ "$branch_name" = "## HEAD (no branch)" ]; then
      # set tag name if found
      tag_name=$(git name-rev --name-only $(git --no-pager show --stat 2> /dev/null | head -n 1 | awk '{ print $2 }') 2> /dev/null)
      if [ -z $tag_name ]; then
      	ref="detached HEAD"
      else
      	ref=$tag_name
      fi
    else
      return
    fi
  fi
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

git_submodule_syntax() {
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
#    echo "--ignore-submodules=dirty"
	echo ""
  else
    echo ""
  fi
}

hostnamecolor() {
 echo $(hostname | od | tr ' ' '\n' | awk '{total = total + $1}END{print 1+total%14}')
}


PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%F{%{$(hostnamecolor)%}$(hostname -f):%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info) %(!.#.$) '

#function title {
#  if [[ "$TERM" == screen* ]]; then
#    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
#  elif [[ "$TERM" == xterm* ]] || [[ $TERM == rxvt* ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
#    print -Pn "\e]2;$2:q\a" #set window name
#    print -Pn "\e]1;%n@$(hostname -f)\a" #set icon (=tab) name (will override window name on broken terminal)
#  fi
#}

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[125]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
