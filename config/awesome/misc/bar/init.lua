-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Notifications library
local naughty = require("naughty")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("misc.helpers")

-- Keys
local keys = require("main.keys")


-- Bar
--------

local function boxed_widget(widget)
    local boxed = wibox.widget{
        {
            widget,
            left = dpi(8),
            right = dpi(8),
            widget = wibox.container.margin
        },
        bg = "#162026",
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background
    }

    return boxed
end

awful.screen.connect_for_each_screen(function(s)

    -- Battery
    local charge_icon = wibox.widget{
        bg = beautiful.xcolor8,
        widget = wibox.container.background,
        visible = false
    }

    local batt = wibox.widget{
        charge_icon,
        color = {beautiful.xcolor2},
        bg = beautiful.xcolor8 .. "88",
        value = 50,
        min_value = 0,
        max_value = 100,
        thickness = dpi(3),
        padding = dpi(2),
        -- rounded_edge = true,
        start_angle = math.pi * 3 / 2,
        widget = wibox.container.arcchart
    }

    awesome.connect_signal("signal::battery", function(value) 
        local fill_color = beautiful.xcolor2

        if value >= 11 and value <= 30 then
            fill_color = beautiful.xcolor3
        elseif value <= 10 then
            fill_color = beautiful.xcolor1
        end

        batt.colors = {fill_color}
        batt.value = value
    end)

    awesome.connect_signal("signal::charger", function(state)
        if state then
            charge_icon.visible = true
        else
            charge_icon.visible = false
        end
    end)

    -- Time
    local time_hour = wibox.widget{
        font = beautiful.font_name .. "bold 8",
        format = "%H",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local time_min = wibox.widget{
        font = beautiful.font_name .. "bold 8",
        format = helpers.colorize_text("%M", beautiful.xforeground .. "a8"),
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local time = wibox.widget{
        time_hour,
        time_min,
        spacing = dpi(5),
        layout = wibox.layout.fixed.horizontal
    }

    -- Wibar
    s.mywibar = awful.wibar({
        type = "dock",
        screen = s,
        bg = "#0B161A",
        height = beautiful.wibar_height,
        width = beautiful.wibar_width,
        shape = helpers.rrect(dpi(8)),
        visible = true
    })

    awful.placement.top_right(s.mywibar, {margins = {top = beautiful.useless_gap * 3, right = beautiful.useless_gap * 3}})

    -- Add widgets to wibar
    s.mywibar:setup{
        {
            nil,
            nil,
            {
                {
                    batt,
                    top = dpi(3),
                    bottom = dpi(3),
                    widget = wibox.container.margin
                },
                boxed_widget(time),
                spacing = dpi(15),
                layout = wibox.layout.fixed.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.horizontal,
        },
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(7),
        right = dpi(7),
        -- margins = dpi(5),
        widget = wibox.container.margin
    }

    wibar_show = function()
        s.padding = {top = beautiful.useless_gap * 3}
        s.mywibar.visible = true
    end

    wibar_hide = function()
        s.padding = {top = 0}
        s.mywibar.visible = false
    end

    wibar_toggle = function()
        if s.mywibar.visible then
            wibar_hide()
        else
            wibar_show()
        end
    end

end)
