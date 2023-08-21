#!/run/current-system/sw/bin/bash
wid=`xdotool search --title "Mozilla Firefox"`
xdotool windowactivate $wid
