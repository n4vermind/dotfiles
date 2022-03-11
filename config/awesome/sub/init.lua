-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Notification handling library
local naughty = require("naughty")

-- Error notifs
-----------------

-- Check if awesome encountered an error during startup
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)


-- Stuff
----------

require("sub.battery")
require("sub.volume")
require("sub.brightness")
require("sub.network")
require("sub.playerctl")
require("sub.weather")

