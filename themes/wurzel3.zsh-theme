# Theme with full path names and hostname
# Handy if you work on different servers all the time;
#PROMPT='%{$fg[yellow]%}$(hostname -f)%{$reset_color%}:%{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%/%{$reset_color%} $(git_prompt_info) %(!.#.$) '
#PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}$(hostname -f):%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info) %(!.#.$) '

PROMPT='%F{$usercolor}%n%{$reset_color%}@%F{$hostnamecolor}$(hostname -f):%f%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info) %(!.#.$) '

function title {
  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek%n:$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ $TERM == rxvt* ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" #set window name
    print -Pn "\e]1;%n@$(hostname -f)\a" #set icon (=tab) name (will override window name on broken terminal)
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[125]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
