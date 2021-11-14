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

local close_button = wibox.widget {
    markup = helpers.colorize_text("", beautiful.xcolor1),
    font = beautiful.icon_font_name .. "11",
    align = "center",
    valign = "center",
    forced_width = dpi(40),
    widget = wibox.widget.textbox
}

close_button:buttons(gears.table.join(
    awful.button({}, 1, function(c)
        local c = mouse.object_under_pointer()
        c:kill()
    end)
))

awful.titlebar.enable_tooltip = false
client.connect_signal("request::titlebars", function(c)

	-- Titlebar setup
	awful.titlebar(c, {position = beautiful.titlebar_pos, size = beautiful.titlebar_size}):setup {
        nil,
        {
            buttons = keys.titlebarbuttons,
            widget = wibox.widget.textbox("")
        },
        {
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            helpers.horizontal_pad(5),
            layout = wibox.layout.fixed.horizontal
        },
		layout = wibox.layout.align.horizontal
	}

end)
