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

    -- Generate wallpaper
    -- bling.module.tiled_wallpaper("", s, {
    --     fg = beautiful.xcolor8,
    --     bg = "#03090b",
    --     offset_y = 20,
    --     offset_x = 20,
    --     font = "Material Icons Round",
    --     font_size = 12,
    --     padding = 100,
    --     zickzack = true
    -- })

    -- Tag layouts
    local taglayouts = {
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.floating,
        awful.layout.suit.floating,
        awful.layout.suit.floating
    }

    -- Tag names
    local tagnames = {"", "", "", "", ""}

    -- Create all tags at once
    awful.tag(tagnames, s, taglayouts)

end)
