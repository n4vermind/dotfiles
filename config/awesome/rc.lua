--[[
 _____ __ _ __ _____ _____ _____ _______ _____
|     |  | |  |  ___|  ___|     |       |  ___|
|  -  |  | |  |  ___|___  |  |  |  | |  |  ___|
|__|__|_______|_____|_____|_____|__|_|__|_____|

--]]
pcall(require, "luarocks.loader")

-- Standard awesome library
local gfs = require("gears.filesystem")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")


-- User vars
-------------------

terminal = "wezterm"
editor = terminal .. " start " .. os.getenv("EDITOR")
browser = "qutebrowser"
launcher = "rofi -show drun"
file_manager = terminal .. " start --class file ranger"
music_client = terminal .. " start --class music ncmpcpp"

openweathermap_key = "################################"
openweathermap_city_id = "#######"
weather_units = "metric"

lock_screen_password = " "


-- Load configuration
-----------------------

-- Sub (signals for battery, volume, brightness, etc)
require("sub")

-- Misc (bar, titlebar, notification, etc)
require("misc")

-- Main (layouts, keybinds, rules, etc)
require("main")


-- Autostart
--------------

awful.spawn.with_shell("~/.config/awesome/main/autorun.sh")


-- Garbage Collector
----------------------

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
