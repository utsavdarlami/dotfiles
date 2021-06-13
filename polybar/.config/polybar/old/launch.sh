#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u 1000 -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config

DIR="$HOME/.config/polybar/old"

polybar -q bottomleft -c "$DIR"/config &

polybar -q bottommiddle -c "$DIR"/config &

polybar -q bottomright -c "$DIR"/config &

echo Polybar launched...

