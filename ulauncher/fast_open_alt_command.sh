#!/bin/bash
pkill -f gnome-commander
setsid gnome-commander -r "$(dirname "$1")" >/dev/null 2>&1 &
