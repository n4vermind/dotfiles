-- Standard library
local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Notifications library
local naughty = require("naughty")

-- Widget library
local wibox = require("wibox")

-- Keys
local keys = require("main.keys")

-- Helpers
------------
local helpers = require("misc.helpers")

-- Create boxed widget
local function create_boxed_widget(widget_to_be_boxed, border_size, bg_color)
    local boxed_widget = wibox.widget {
        {
            widget_to_be_boxed,
            left = border_size,
            right = border_size,
            top = border_size,
            bottom = border_size,
            widget = wibox.container.margin
        },
        bg = bg_color,
        border_width = border_size,
        widget = wibox.container.background
    }

    return boxed_widget
end

-- Create text widget
local function create_text_widget()
    local text_widget = wibox.widget {
        font = beautiful.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    return text_widget
end


-- Bar
--------
awful.screen.connect_for_each_screen(function(s)

----- Taglist
	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = keys.taglistbuttons,
		widget_template = {
			{
                {
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                        align='center',
                        valign='center'
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

------ Tasklist
	s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.minimizedcurrenttags,
        buttons = keys.tasklistbuttons,
        layout = {
            spacing_widget = wibox.widget {
                color = beautiful.xforeground,
                orientation = "vertical",
                span_ratio  = 0.53,
                thickness   = 1,
                widget      = wibox.widget.separator,
            },
            layout        = wibox.layout.fixed.horizontal
        },
        widget_template = {
            -- {
                {
                    {
                        nil,
                        {
                            id = 'text_role',
                            widget = wibox.widget.textbox
                        },
                        nil,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = 10,
                    right = 10,
                    widget = wibox.container.margin
                },
                id = "background_role",
                widget = wibox.container.background,
            -- },
            -- border_width = dpi(2),
            -- widget = wibox.container.background,
        }
    }

------ Notification center
    -- Add a button to dismiss all notifications, because why not.
    local dismiss_button = wibox.widget{
        {
            markup = helpers.colorize_text("", beautiful.xcolor1),
            align  = "center",
            valign = "center",
            widget = wibox.widget.textbox
        },
        buttons = gears.table.join(
            awful.button({ }, 1, function() naughty.destroy_all_notifications() end)
        ),
        forced_width       = dpi(30),
        -- shape              = gears.shape.rounded_bar,
        -- shape_border_width = dpi(2),
        -- shape_border_color = beautiful.xforeground,
        widget = wibox.container.background
    }

    s.mynotification = wibox.widget{
        visible  = #naughty.active > 0,
        {
            {
            dismiss_button,
                {
                    base_layout = wibox.widget {
                        spacing_widget = wibox.widget {
                            color = beautiful.xforeground,
                            orientation = "vertical",
                            span_ratio  = 0.53,
                            thickness   = 0.5,
                            widget      = wibox.widget.separator,
                        },
                        spacing       = dpi(20),
                        layout        = wibox.layout.fixed.horizontal
                    },
                    widget_template = {
                        {
                            -- naughty.widget.icon,
                            {
                                naughty.widget.title,
                                {
                                    text   = ": ",
                                    align  = "center",
                                    valign = "center",
                                    widget = wibox.widget.textbox
                                },
                                naughty.widget.message,
                                -- {
                                    -- layout = wibox.widget {
                                    --     -- Adding the wibox.widget allows to share a
                                    --     -- single instance for all spacers.
                                    --     layout  = wibox.layout.flex.horizontal
                                    -- },
                                --     widget = naughty.list.widgets,
                                -- },
                                layout = wibox.layout.fixed.horizontal
                            },
                            spacing = 10,
                            fill_space = true,
                            layout  = wibox.layout.fixed.horizontal
                        },
                        margins = 5,
                        widget  = wibox.container.margin
                    },
                    widget = naughty.list.notifications,
                },
                layout = wibox.layout.fixed.horizontal
            },
            left = dpi(2),
            right = dpi(10),
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        border_width = dpi(2),
        widget = wibox.container.background,
    }

    -- We don't want to have that bar all the time, only when there is content.
    naughty.connect_signal("property::active", function()
        s.mynotification.visible = #naughty.active > 0
    end)

------ Layoutbox
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(keys.layoutboxbuttons)

------ Time
    local time = wibox.widget{
        font = beautiful.font,
        -- format = "%H:%M %b %y",
        format = "%H:%M",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock
    }

------ Battery
    local batt_icon = create_text_widget()
    batt_icon.font = beautiful.font_name .. "10"
    local batt_text = create_text_widget()

    local batt = wibox.widget {
        batt_icon,
        batt_text,
        -- {batt_icon, bottom = dpi(1.5), widget = wibox.container.margin},
        spacing = dpi(5),
        layout = wibox.layout.fixed.horizontal
    }

    awesome.connect_signal("stat::battery", function(percentage, state)
        local b_icon = ""
        local b_val = tostring(percentage)

        if percentage >= 80 and percentage <= 100 then
            b_icon = ""
        elseif percentage >= 60 and percentage < 80 then
            b_icon = ""
        elseif percentage >= 40 and percentage < 60 then
            b_icon = ""
        elseif percentage >= 10 and percentage < 40 then
            b_icon = ""
        else
            b_icon = ""
        end

        if state == 1 then b_icon = helpers.colorize_text(b_icon, beautiful.xcolor4) end
        b_text,_ = b_val:match"([^.]*).(.*)"

        batt_icon.markup = b_icon
        batt_text.markup = b_text .. "%"
    end)

------ Volume
    local vol_icon = create_text_widget()
    vol_icon.font = beautiful.icon_font_name .. "9"
    vol_icon.align = "left"
    vol_icon.forced_width = 12

    awesome.connect_signal("stat::volume", function(val, muted)
        local v_icon = ""

        if val >= 60 and val <= 100 then
            v_icon = ""
        elseif val >= 30 and val < 60 then
            v_icon = ""
        elseif val >= 0 and val < 30 then
            v_icon = ""
        end

        if muted then v_icon = "" end
        vol_icon.markup = v_icon
    end)

------ Brightness
    local bright_icon = create_text_widget()
    bright_icon.font = beautiful.icon_font_name .. "9"
    bright_icon.align = "left"
    bright_icon.forced_width = 12

    awesome.connect_signal("stat::brightness", function(val)
        local br_icon = ""

        if val >= 60 and val <= 100 then
            br_icon = ""
        elseif val >= 30 and val < 60 then
            br_icon = ""
        elseif val >= 0 and val < 30 then
            br_icon = ""
        else
            br_icon = ""
        end

        bright_icon.markup = br_icon
    end)

------ Separator
    local separator = create_text_widget()
    separator.markup = beautiful.separator_text
    separator.forced_width = dpi(27)
    -- local separator = wibox.widget{
    --     orientation = "vertical",
    --     span_ratio  = 0.5,
    --     widget      = wibox.widget.separator,
    -- }


-- Group widgets
------------------

------ Left
    local l_widget = create_boxed_widget(s.mytaglist, dpi(2), beautiful.xforeground)

------ Middle
    local m_widget = create_boxed_widget({
        {
            time,
            {separator, right = dpi(3), widget = wibox.container.margin},
            batt,
            {separator, right = dpi(3), widget = wibox.container.margin},
            {
                {vol_icon, bottom = dpi(1), widget = wibox.container.margin},
                {bright_icon, bottom = dpi(1), widget = wibox.container.margin},
                {s.mylayoutbox, left = dpi(3), top = dpi(7), bottom = dpi(7), widget = wibox.container.margin},
                spacing = dpi(7),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(11),
        right = dpi(11),
        widget = wibox.container.margin
    }, dpi(2), beautiful.xbackground)

------ Right
    local r_widget = wibox.widget{ 
        -- visible = #clients > 0
        {
            -- s.mytasklist,
            s.mynotification,
            bg = beautiful.xbackground,
            widget = wibox.container.background
        },
        border_width = dpi(2),
        widget = wibox.container.background,
    }


------ Create wibar
    s.mywibar = awful.wibar({
		type = "dock",
		position = beautiful.wibar_pos, 
		screen = s, 
		-- width = beautiful.wibar_width, 
		height = beautiful.wibar_height, 
        bg = beautiful.transparent,
        border_width = dpi(0),
		visible = true,
    })

------ Add widgets to wibar
    s.mywibar:setup {
        {
            l_widget,
            m_widget,
            r_widget,
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        left = 10,
        right = 10,
        bottom = 10,
        widget = wibox.container.margin
    }

end)
