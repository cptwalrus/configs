#!/usr/bin/bash

if [ "${1}" = "-d" ]; 
    #undo - we done
then
    xrandr --auto --output DP-0 --mode 2560x1440
    xrandr --output HDMI-0 --off
else
    #steam setup
    xrandr --auto --output DP-0 --mode 1920x1080
    xrandr --auto --output HDMI-0 --mode 1920x1080 --same-as DP-0
fi
