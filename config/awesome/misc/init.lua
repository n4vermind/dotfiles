-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Bling
local bling = require("lib.bling")

-- rubato (animations)
local rubato = require("lib.rubato")

-- Helpers
local helpers = require("helpers")


-- Tag Preview
----------------

bling.widget.tag_preview.enable {
    show_client_content = false,  -- Whether or not to show the client content
    x = 10,                       -- The x-coord of the popup
    y = 10,                       -- The y-coord of the popup
    scale = 0.25,                 -- The scale of the previews compared to the screen
    honor_padding = false,        -- Honor padding when creating widget size
    honor_workarea = false,       -- Honor work area when creating widget size
    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.useless_gap,
                left = beautiful.wibar_width + beautiful.useless_gap
            }
        })
    end,
    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        widget = wibox.widget.imagebox
    }
}


-- Task Preview
----------------

bling.widget.task_preview.enable {
    -- x = 20,                    -- The x-coord of the popup
    -- y = 20,                    -- The y-coord of the popup
    height = dpi(150),              -- The height of the popup
    width = dpi(220),               -- The width of the popup
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.useless_gap,
                left = beautiful.wibar_width + beautiful.useless_gap
            }
        })
    end
}


-- Window switcher
--------------------

bling.widget.window_switcher.enable {
    type = "thumbnail",

    hide_window_switcher_key = "Escape",
    minimize_key = "n",
    unminimize_key = "N",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Right",
    next_key = "Left",
    vim_previous_key = "l",
    vim_next_key = "h"
}


-- Scratchpad
---------------

local anim_y = rubato.timed {
    pos = 1090,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true       -- this option must be set to true.
}

local anim_x = rubato.timed {
    pos = 2070,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true       -- this option must be set to true.
}

local discord_scratch = bling.module.scratchpad:new {
    command = "discocss",
    rule = { instance = "discord" },
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = { x = 245, y = 85, height = 600, width = 800 },
    reapply = true,
    dont_focus_before_close = false,
    rubato = { x = anim_x }
}

local spotify_scratch = bling.module.scratchpad:new {
    command = "spotify",
    rule = { instance = "spotify" },
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = { x = 150, y = 65, height = 660, width = 960 },
    reapply = true,
    dont_focus_before_close = false,
    rubato = { y = anim_y }
}


-- Signals
------------

awesome.connect_signal("scratch::discord", function() discord_scratch:toggle() end)
awesome.connect_signal("scratch::spotify", function() spotify_scratch:toggle() end)


-- Stuff
----------

require("misc.ping")
require("misc.bar")
require("misc.titlebar")
require("misc.tooltip")
require("misc.pop")
require("misc.deco")

