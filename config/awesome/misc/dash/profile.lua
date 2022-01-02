-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("misc.helpers")


-- Profile
------------

local profile_pic_img = wibox.widget{
    image = beautiful.profile,
    halign = "center",
    valign = "center",
    widget = wibox.widget.imagebox
}

local profile_pic_container = wibox.widget{
    shape = helpers.rrect(5),
    forced_height = dpi(120),
    forced_width = dpi(120),
    widget = wibox.container.background
}

local profile = wibox.widget{
    {
        profile_pic_img,
        widget = profile_pic_container
    },
    margins = dpi(10),
    widget = wibox.container.margin
}

return profile
