# Theme with full path names and hostname
# Handy if you work on different servers all the time;
#PROMPT='%{$fg[yellow]%}$(hostname -f)%{$reset_color%}:%{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%/%{$reset_color%} $(git_prompt_info) %(!.#.$) '
#PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}$(hostname -f):%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info) %(!.#.$) '

string_colors=(1 2 3 4 5 6 8 9 10 11 12 27 28 29 30 76 77 82 124 125 128 142 148 154)
num_colors=${#string_colors}
string_to_color() {
  echo $string_colors[$(echo $1 | od | tr ' ' '\n' | awk '{total = total + $1}END{print total%$num_colors}')]
}

hostnamecolor=$(string_to_color `hostname -f`)
usercolor=$(string_to_color `whoami`)

PROMPT='%F{%{$usercolor%}%n%{$reset_color%}@%F{%{$hostnamecolor%}$(hostname -f):%F{255}%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info) %(!.#.$) '

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
