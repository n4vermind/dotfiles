-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")


-- Titlebar
-------------

awful.titlebar.enable_tooltip = false
client.connect_signal("request::titlebars", function(c)

    -- Buttons for the titlebar
    local buttons = gears.table.join(
        -- Left click
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),

        -- Middle click
        awful.button({}, 2, nil, function(c) 
            c:kill() 
        end),

        -- Right click
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

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
            buttons = buttons,
            widget = wibox.widget.textbox("")
        },
        {
            awful.titlebar.widget.iconwidget(c),
            margins = dpi(9),
            buttons = buttons,
            widget = wibox.container.margin
        },
		layout = wibox.layout.align.horizontal
	}

end)

