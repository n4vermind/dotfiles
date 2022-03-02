-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Keys
local keys = require("main.keys")

-- Helpers
local helpers = require("helpers")


-- Titlebar
-------------

awful.titlebar.enable_tooltip = false
client.connect_signal("request::titlebars", function(c)

    -- Titlebar setup
	awful.titlebar(c, {position = beautiful.titlebar_pos, size = beautiful.titlebar_size}):setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                -- spacing = dpi(3),
                layout = wibox.layout.fixed.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = keys.titlebarbuttons,
            widget = wibox.widget.textbox("")
        },
        {
            awful.titlebar.widget.iconwidget(c),
            margins = dpi(9),
            buttons = keys.titlebarbuttons,
            widget = wibox.container.margin
        },
		layout = wibox.layout.align.horizontal
	}

end)
