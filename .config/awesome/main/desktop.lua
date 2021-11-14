-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Bling
local bling = require("lib.bling")
bling.module.flash_focus.enable()


-- Desktop
------------

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.fair,
    bling.layout.centered,
    bling.layout.mstab,
}

awful.screen.connect_for_each_screen(function(s)

	-- Set wallpaper
    gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)

    -- Tag layouts
    local taglayouts = {
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.floating,
        awful.layout.suit.floating,
        awful.layout.suit.floating
    }

    -- Tag names
    local tagnames = {"1", "2", "3", "4", "5"}

    -- Create all tags at once
    awful.tag(tagnames, s, taglayouts)

end)
