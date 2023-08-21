#!/run/current-system/sw/bin/bash

scrot -s /home/josiah/Pictures/screenshots/$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'
