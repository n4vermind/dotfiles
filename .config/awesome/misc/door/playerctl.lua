-- Standard library
local awful = require("awful")
local bling = require("lib.bling")

bling.signal.playerctl.enable {
    backend = "playerctl_lib",
    ignore = {"Brave", "qutebrowser", "chromium"},
    -- playerctl_position_update_interval = 1,
    update_on_activity = true
}
