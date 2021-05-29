 #!/usr/bin/env bash

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=" "

case $class in
  playing)
    info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
    if [[ ${#info} > 40 ]]; then
      info=$(echo $info | cut -c1-40)"..."
    fi
    text=$info" "$icon
    ;;
  paused)
    text=$icon
    ;;
  stopped)
    text=""
    ;;
esac

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
