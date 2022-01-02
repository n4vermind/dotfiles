-- Standard awesome library
local awful = require("awful")

-- Notification handling library
local naughty = require("naughty")

-- Bling
local bling = require("lib.bling")

bling.signal.playerctl.enable {
    backend = "playerctl_lib",
    ignore = {"firefox", "qutebrowser", "chromium", "brave"},
    -- playerctl_position_update_interval = 1,
    update_on_activity = true
}

awesome.connect_signal("bling::playerctl::title_artist_album",
    function(title, artist, art_path)
    naughty.notification({title = "Now Playing", text = artist .. " - " .. title, image = art_path})
end)
