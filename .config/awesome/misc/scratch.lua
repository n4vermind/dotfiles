-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Bling
local bling = require("lib.bling")

-- rubato (animations)
local rubato = require("lib.rubato")


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
	rule = {instance = "discord"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x=245, y=85, height=600, width=800},
    reapply = true,
    dont_focus_before_close = false,
    rubato = {x = anim_x}
}

local spotify_scratch = bling.module.scratchpad:new {
    command = "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify",
	rule = {instance = "spotify"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x=150, y=65, height=660, width=960},
    reapply = true,
    dont_focus_before_close = false,
    rubato = {y = anim_y}
}


-- Signals
------------

awesome.connect_signal("scratch::discord", function() discord_scratch:toggle() end)
awesome.connect_signal("scratch::spotify", function() spotify_scratch:toggle() end)
