-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")


-- Bar
--------

local function boxed_widget(widget)
    local boxed = wibox.widget{
        {
            widget,
            left = dpi(12),
            right = dpi(12),
            widget = wibox.container.margin
        },
        bg = beautiful.xcolor0,
        shape = helpers.rrect(dpi(5)),
        widget = wibox.container.background
    }

    return boxed
end

awful.screen.connect_for_each_screen(function(s)

    -- Tasklist
    local tasklist_buttons = gears.table.join(
        -- Left click
        awful.button({}, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end),

        -- Middle click
        awful.button({}, 2, nil, function(c) 
            c:kill() 
        end),

        -- Right click
        awful.button({}, 3, function (c) 
            c.minimized = not c.minimized 
        end),

        -- Scrolling
        awful.button({}, 4, function ()
            awful.client.focus.byidx(-1)
        end),
        awful.button({}, 5, function ()
            awful.client.focus.byidx(1)
        end)
    )

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing = dpi(3),
            spacing_widget = {
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon
                    },
                    margins = dpi(8),
                    widget  = wibox.container.margin
                },
                id            = 'background_role',
                widget        = wibox.container.background
            },
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c

                -- BLING: Toggle the popup on hover and disable it off hover
                self:connect_signal('mouse::enter', function()
                        awesome.emit_signal("bling::task_preview::visibility", s,
                                            true, c)
                    end)
                    self:connect_signal('mouse::leave', function()
                        awesome.emit_signal("bling::task_preview::visibility", s,
                                            false, c)
                    end)
            end,
            shape = helpers.rrect(dpi(5)),
            widget = wibox.container.background
        }
    }

    local tasklist = wibox.widget {
        s.mytasklist,
        -- bg = beautiful.xcolor0,
        -- shape = helpers.rrect(dpi(5)),
        widget = wibox.container.background
    }

    -- Layoutbox
    local layoutbox_buttons = gears.table.join(
        -- Left click
        awful.button({}, 1, function (c)
            awful.layout.inc(1)
        end),

        -- Right click
        awful.button({}, 3, function (c) 
            awful.layout.inc(-1) 
        end),

        -- Scrolling
        awful.button({}, 4, function ()
            awful.layout.inc(-1)
        end),
        awful.button({}, 5, function ()
            awful.layout.inc(1)
        end)
    )

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(layoutbox_buttons)

    local layoutbox = wibox.widget{
        s.mylayoutbox,
        margins = dpi(8),
        widget = wibox.container.margin
    }

    -- Start
    local start = wibox.widget{
        markup = "",
        font = beautiful.icon_font_name .. "Round 12",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    start:buttons(gears.table.join(
        awful.button({}, 1, function ()
            awful.spawn(launcher)
        end)
    ))

    -- Wifi
    local wifi = wibox.widget{
        markup = "",
        font = beautiful.icon_font_name .. "Round 12",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    awesome.connect_signal("signal::network", function(status, _)
        local w = ""

        if status then
            w = ""
        end

        wifi.markup = w
    end)

    -- Volume
    local vol = wibox.widget{
        markup = "",
        font = beautiful.icon_font_name .. "Round 12",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    awesome.connect_signal("signal::volume", function(value, muted)
        local fill_color = beautiful.xcolor4
        local vol_value = value or 0
        local v = ""

        if muted then
            fill_color = beautiful.xcolor8
            v = ""
        else
            if vol_value >= 60 then
                v = ""
            elseif vol_value >= 20 and vol_value < 60 then
                v = ""
            else
                v = ""
            end
        end

        vol.markup = v
    end)

    vol:buttons(gears.table.join(
        awful.button({}, 1, function ()
            helpers.volume_control(0)
        end),
        awful.button({}, 4, function ()
            helpers.volume_control(2)
        end),
        awful.button({}, 5, function ()
            helpers.volume_control(-2)
        end)
    ))

    -- Battery
    local batt = wibox.widget{
        markup = helpers.colorize_text("", beautiful.xcolor1),
        font = beautiful.icon_font_name .. "Round 12",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local batt_val = 0
    local batt_charger

    awesome.connect_signal("signal::battery", function(value)
        batt_val = value
        awesome.emit_signal("widget::battery")
    end)

    awesome.connect_signal("signal::charger", function(state)
        batt_charger = state
        awesome.emit_signal("widget::battery")
    end)

    awesome.connect_signal("widget::battery", function()
        local b = ""
        local fill_color = beautiful.xforeground

        if batt_val >= 88 and batt_val <= 100 then
            b = ""
        elseif batt_val >= 76 and batt_val < 88 then
            b = ""
        elseif batt_val >= 64 and batt_val < 76 then
            b = ""
        elseif batt_val >= 52 and batt_val < 64 then
            b = ""
        elseif batt_val >= 40 and batt_val < 52 then
            b = ""
        elseif batt_val >= 28 and batt_val < 40 then
            b = ""
        elseif batt_val >= 16 and batt_val < 28 then
            b = ""
        else
            b = ""
        end

        if batt_charger then
            fill_color = beautiful.xcolor2 .. "d5"
        else
            if batt_val <= 15 then
                fill_color = beautiful.xcolor1
            end
        end

        batt.markup = helpers.colorize_text(b, fill_color)
    end)

    local stats = wibox.widget {
        {
            {
                wifi,
                vol,
                batt,
                spacing = dpi(18),
                layout = wibox.layout.fixed.vertical
            },
            top = dpi(8),
            bottom = dpi(8),
            widget = wibox.container.margin
        },
        shape = helpers.rrect(dpi(5)),
        widget = wibox.container.background
    }

    stats:connect_signal("mouse::enter", function()
        stats.bg = beautiful.bg_secondary
        stats_tooltip.visible = true
    end)

    stats:connect_signal("mouse::leave", function()
        stats.bg = beautiful.transparent
        stats_tooltip.visible = false
    end)

    -- Time
    local time_hour = wibox.widget{
        font = beautiful.font_name .. "bold 12",
        format = "%H",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local time_min = wibox.widget{
        font = beautiful.font_name .. "bold 12",
        format = "%M",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local time = wibox.widget{
        time_hour,
        time_min,
        spacing = dpi(5),
        layout = wibox.layout.fixed.vertical
    }

    time:connect_signal("mouse::enter", function()
        cal_tooltip_show()
    end)

    time:connect_signal("mouse::leave", function()
        cal_tooltip_hide()
    end)

    -- Separator
    local separator = wibox.widget {
        color = beautiful.separator_color,
        forced_height = dpi(2),
        shape = gears.shape.rounded_bar,
        widget = wibox.widget.separator
    }

    -- Wibar
    s.mywibar = awful.wibar({
        type = "dock",
        screen = s,
        position = beautiful.wibar_pos,
        visible = true
    })

    -- Add widgets to wibar
    s.mywibar:setup{
        {
            {
                start,
                tasklist,
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            nil,
            {
                stats,
                separator,
                time,
                separator,
                layoutbox,
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            expand = "none",
            layout = wibox.layout.align.vertical
        },
        left = dpi(4),
        right = dpi(4),
        top = dpi(10),
        bottom = dpi(10),
        widget = wibox.container.margin
    }
end)

