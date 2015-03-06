string_colors=(1 2 3 4 5 6 8 9 10 11 12 27 28 29 30 76 77 82 124 125 128 142 148 154)
string_to_color() {
  echo $string_colors[$(echo "$1" | od | tr ' ' '\n' | awk '{total = total + $1}END{print total % 25}')] 
}
if [ -z $hostnamecolor ]; then
    hostnamecolor=$(string_to_color `hostname -f`)
fi
if [ -z $usercolor ]; then
    usercolor=$(string_to_color `whoami`)
fi
if [ "`whoami`" = "root" ]; then
    usercolor=1
fi
