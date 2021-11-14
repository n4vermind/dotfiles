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
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        bg = beautiful.xcolor8 .. "55",
        shape = helpers.rrect(dpi(3)),
        widget = wibox.container.background
    }

    return boxed
end

awful.screen.connect_for_each_screen(function(s)

    -- Taglist
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = keys.taglistbuttons,
        layout = {
            spacing = 0,
            spacing_widget = {
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
		widget_template = {
			{
                {
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                        align = 'center',
                        valign = 'center'
                    },
                    left = dpi(9),
                    right = dpi(9),
                    widget = wibox.container.margin
                },
                id = "background_role",
                widget = wibox.container.background,
			},
			layout = wibox.layout.fixed.horizontal,
			create_callback = function(self, c3, _, _)
				self:connect_signal(
					"mouse::enter",
					function()
						if #c3:clients() > 0 then
							awesome.emit_signal("bling::tag_preview::update", c3)
							awesome.emit_signal("bling::tag_preview::visibility", s, true)
						end
					end
				)

				self:connect_signal(
					"mouse::leave",
					function()
						awesome.emit_signal("bling::tag_preview::visibility", s, false)
					end
				)
			end
		}
    }

    -- Tasklist
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = keys.tasklistbuttons,
        layout = {
            spacing = 0,
            spacing_widget = {
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    nil,
                    awful.widget.clienticon,
                    nil,
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(7),
                right = dpi(7),
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background
        }
    }

    -- Battery
    local batt_icon = wibox.widget{
        markup = "N/A",
        font = beautiful.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local batt_text = wibox.widget{
        markup = "N/A",
        font = beautiful.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local batt = wibox.widget{
        batt_icon,
        helpers.horizontal_pad(dpi(4)),
        batt_text,
        layout = wibox.layout.fixed.horizontal
    }

    local batt_val = 0
    local batt_charger

    awesome.connect_signal("signal::battery", function(value) 
        batt_val = value
        awesome.emit_signal("widget::battery")
    end)

    awesome.connect_signal("signal::charger", function(state)
        if state then
            batt_charger = true
        else
            batt_charger = false
        end
        awesome.emit_signal("widget::battery")
    end)

    awesome.connect_signal("widget::battery", function()
        local b = ""

        if batt_charger then
            b = ""
        else
            if batt_val >= 90 and batt_val <= 100 then
                b = ""
            elseif batt_val >= 70 and batt_val < 90 then
                b = ""
            elseif batt_val >= 60 and batt_val < 70 then
                b = ""
            elseif batt_val >= 50 and batt_val < 60 then
                b = ""
            elseif batt_val >= 30 and batt_val < 50 then
                b = ""
            elseif batt_val >= 15 and batt_val < 30 then
                b = ""
            else
                b = ""
            end
        end

        batt_icon.markup = b
        batt_text.markup = tostring(batt_val) .. "%"
    end)

    -- Time
    local time_icon = wibox.widget{
        markup = "",
        font = beautiful.font_name .. "14",
        align = "left",
        valign = "center",
        forced_width = dpi(11),
        widget = wibox.widget.textbox
    }

    local time_text = wibox.widget{
        font = beautiful.font,
        format = "%H:%M",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local time = wibox.widget{
        time_icon,
        helpers.horizontal_pad(dpi(3)),
        time_text,
        layout = wibox.layout.fixed.horizontal
    }

    -- Date
    local date_icon = wibox.widget{
        markup = "",
        font = beautiful.font_name .. "14",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local date_text = wibox.widget{
        font = beautiful.font,
        format = "%a, %d %b %y",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local date = wibox.widget{
        date_icon,
        helpers.horizontal_pad(dpi(5)),
        date_text,
        layout = wibox.layout.fixed.horizontal
    }

    -- Layoutbox
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(keys.layoutboxbuttons)

    local layoutbox = wibox.widget{
        s.mylayoutbox,
        top = dpi(5),
        bottom = dpi(5),
        widget = wibox.container.margin
    }

    -- Notification center
    local notifs = wibox.widget{
        markup = "",
        font = beautiful.font_name .. "10",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    notifs:buttons(gears.table.join(
        awful.button({}, 1, function()
            notifs_toggle()
        end)
    ))

    -- Wibar
    s.mywibar = awful.wibar({
        -- type = "dock",
        position = beautiful.wibar_pos,
        screen = s,
        height = beautiful.wibar_height,
        bg = beautiful.xbackground,
        visible = true
    })

    -- Add widgets to wibar
    s.mywibar:setup{
        nil,
        {
            {
                -- Left
                {
                    s.mytasklist,
                    shape = helpers.rrect(dpi(3)),
                    widget = wibox.container.background
                },

                -- Middle
                {
                    s.mytaglist,
                    shape = helpers.rrect(dpi(3)),
                    widget = wibox.container.background
                },

                -- Right
                {
                    boxed_widget(batt),
                    boxed_widget(time),
                    boxed_widget(date),
                    boxed_widget({layoutbox, notifs, spacing = dpi(8), layout = wibox.layout.fixed.horizontal}),
                    -- boxed_widget(notifs),
                    spacing = dpi(6),
                    layout = wibox.layout.fixed.horizontal
                },
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            top = dpi(4),
            bottom = dpi(4),
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        {
            bg = beautiful.border_color,
            forced_height = beautiful.border_width,
            layout = wibox.container.background
        },
        layout = wibox.layout.align.vertical
    }
end)
