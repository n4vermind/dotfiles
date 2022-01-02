-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("misc.helpers")

-- Keys
local keys = require("main.keys")


-- Titlebar
-------------

awful.titlebar.enable_tooltip = false
client.connect_signal("request::titlebars", function(c)

    -- Titlebar setup
    -- awful.titlebar(c, {position = beautiful.titlebar_pos, size = beautiful.titlebar_size}):setup {
    --         nil,
    --         {
    --             buttons = keys.titlebarbuttons,
    --             widget = wibox.widget.textbox("")
    --         },
    --         {
    --             awful.titlebar.widget.minimizebutton(c),
    --             awful.titlebar.widget.maximizedbutton(c),
    --             awful.titlebar.widget.closebutton(c),
    --             helpers.horizontal_pad(5),
    --             layout = wibox.layout.fixed.horizontal
    --         },
    --     layout = wibox.layout.align.horizontal
    -- }

    -- Side titlebar setup
    awful.titlebar(c, {position = beautiful.titlebar_position, size = beautiful.titlebar_size}):setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                layout = wibox.layout.fixed.vertical
            },
            {
                buttons = keys.titlebarbuttons,
                widget = wibox.widget.textbox("")
            },
            layout = wibox.layout.align.vertical
        },
        margins = dpi(4),
        widget = wibox.container.margin
    }

end)
