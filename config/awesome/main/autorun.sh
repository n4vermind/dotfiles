#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# music
run mpd
run mpDris2 # add playerctl support to mpd

# wallpaper (not recommended, use awesome instead)
# nitrogen  --restore

# compositor
run picom --experimental-backends

# redshift
# run redshift

# auth
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
