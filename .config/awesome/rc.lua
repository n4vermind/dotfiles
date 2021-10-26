-- Standard library
local gfs = require("gears.filesystem")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")
beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

-- User variables
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "qutebrowser"
launcher = "rofi -show drun"
file_manager = terminal .. " -e ranger"
music_client = terminal .. " -e ncmpcpp"

-- Main (layouts, keybinds, rules, etc)
require("main")

-- Misc (bar, titlebar, notifications, etc)
require("misc")

-- Autostart
awful.spawn.with_shell("~/.config/awesome/main/autorun.sh")
