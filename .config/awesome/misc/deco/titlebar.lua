-- Standard library
local gears = require("gears")
local awful = require("awful")

-- Widget library
local wibox = require("wibox")

-- Theme library
local beautiful = require("beautiful")

-- Keys
local keys = require("main.keys")

-- Helpers
local helpers = require("misc.helpers")

awful.titlebar.enable_tooltip = false
client.connect_signal("request::titlebars", function(c)

	-- Titlebar setup
	awful.titlebar(c, {position = beautiful.titlebar_pos, size = beautiful.titlebar_size}):setup{
		buttons = keys.titlebarbuttons,
		layout = wibox.layout.align.horizontal
	}
end)
