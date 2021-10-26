#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# music
#killall mpd
run mpd
run mpDris2 # add playerctl support to mpd

# wallpaper (not recommended, use awesome instead)
# nitrogen  --restore

# compositor
run picom

# redshift
run redshift

# auth
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# QT scale
# export QT_SCALE_FACTOR=2

# QT theme
# export QT_QPA_PLATFORMTHEME=qt5ct

# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5
