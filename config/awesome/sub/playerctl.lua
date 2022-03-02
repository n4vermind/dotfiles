-- Notification handling library
local naughty = require("naughty")

-- Playerctl
local playerctl = require("lib.bling").signal.playerctl.lib()

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
    if new == true then
        naughty.notify({title = title, text = artist, image = album_path})
    end
end)
