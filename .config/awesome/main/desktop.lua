-- Standard library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Hotkeys library
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Bling
local bling = require("lib.bling")
bling.module.flash_focus.enable()

-- Machi (layouts)
local machi = require("lib.layout-machi")
beautiful.layout_machi = machi.get_icon()

-- Layouts
tag.connect_signal(
    "request::default_layouts",
    function()
        awful.layout.append_default_layouts( {
            awful.layout.suit.floating,
            awful.layout.suit.tile,
            awful.layout.suit.max,
            awful.layout.suit.fair,
            bling.layout.centered,
            machi.default_layout,
            bling.layout.mstab,
        })
    end
)

awful.screen.connect_for_each_screen(function(s)

	-- Set wallpaper
	gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)

    -- Tag names
    local tagnames = {"1", "2", "3", "4"}

    -- Tag layouts
    local taglayouts = {
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.floating,
        awful.layout.suit.floating
    }

    -- Create all tags at once
    awful.tag(tagnames, s, taglayouts)

    -- Menu
    awesomemenu = {
        {"Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
        {"Edit Config", editor_cmd .. awesome.conffile},
        {"Reload", awesome.restart},
    }

    mymainmenu = awful.menu({
        items = {
            {"Terminal", function() awful.spawn.with_shell(terminal) end},
            {"Browser", function() awful.spawn.with_shell(browser) end},
            {"Music", function() awful.spawn.with_shell(music_client) end},
            {"File manager", function() awful.spawn.with_shell(file_manager) end},
            {"Awesome", awesomemenu},
            {"Quit", function() awesome.quit() end}
        }
    })
end)
