#!/bin/bash

set -exuo pipefail

# Turn on tv remote display
# echo 'scan' | cec-client -s -d 1

# Open our lovely screensaver
firefox --new-window https://apodviewer.github.io/ > /dev/null 2> /dev/null &
WM_BROWSER_SELECTOR="firefox"
sleep 7
wmctrl -r "$WM_BROWSER_SELECTOR" -b add,fullscreen

# Wait a bit
sleep 10

# Close our screensaver
wmctrl -r "$WM_BROWSER_SELECTOR" -b remove,fullscreen
wmctrl -c "$WM_BROWSER_SELECTOR" 

# Turn off tv
# FIXME
