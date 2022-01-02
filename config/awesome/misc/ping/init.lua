-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Notification handling library
local naughty = require("naughty")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("misc.helpers")

-- Notifications
------------------

naughty.config.defaults.ontop = true
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.timeout = 3
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

beautiful.notification_shape = helpers.rrect(dpi(8))

naughty.config.presets.normal = {
    font = beautiful.font,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal
}

naughty.config.presets.low = {
    font = beautiful.font,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal
}

naughty.config.presets.critical = {
    font = beautiful.font_name .. "10",
    fg = beautiful.xcolor1,
    bg = beautiful.bg_normal,
    timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

local bg_color = {
    type = 'linear',
    from = {-360, 0},
    to = {120, 0},
    stops = {{0, beautiful.xcolor2}, {1, beautiful.xbackground}}
}

naughty.connect_signal("request::display", function(n)
    local appicon = n.app_icon
    if not appicon then appicon = beautiful.notification_icon end
    local time = os.date("%H:%M")

    local action_widget = {
        {
            {
                id = "text_role",
                align = "center",
                valign = "center",
                font = beautiful.font_name .. "8",
                widget = wibox.widget.textbox
            },
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        bg = beautiful.xcolor0,
        forced_height = dpi(25),
        forced_width = dpi(20),
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background
    }

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(8),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = action_widget,
        style = {underline_normal = false, underline_selected = true},
        widget = naughty.list.actions
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        bg = beautiful.transparent,
        widget_template = {
            {
                {
                    {
                        nil,
                        {
                            {
                                {
                                    {
                                        {
                                            step_function = wibox.container.scroll
                                                .step_functions
                                                .waiting_nonlinear_back_and_forth,
                                            speed = 50,
                                            {
                                                markup = "<span weight='bold'>" ..
                                                    n.title .. "</span>",
                                                font = beautiful.font,
                                                align = "left",
                                                widget = wibox.widget.textbox
                                            },
                                            -- forced_width = dpi(204),
                                            widget = wibox.container.scroll
                                                .horizontal
                                        },
                                        {
                                            markup = helpers.colorize_text(n.message, "#666C79"),
                                            align = "left",
                                            font = beautiful.font,
                                            widget = wibox.widget.textbox
                                        },
                                        spacing = 0,
                                        layout = wibox.layout.flex.vertical
                                    },
                                    layout = wibox.layout.align.vertical
                                },
                                layout = wibox.layout.fixed.horizontal
                            },
                            {
                                {actions, layout = wibox.layout.fixed.vertical},
                                margins = dpi(10),
                                visible = n.actions and #n.actions > 0,
                                widget = wibox.container.margin
                            },
                            layout = wibox.layout.fixed.vertical
                        },
                        expand = "none",
                        layout = wibox.layout.align.vertical
                    },
                    top = dpi(20),
                    bottom = dpi(20),
                    left = dpi(25),
                    right = dpi(25),
                    widget = wibox.container.margin
                },
                strategy = "max",
                width    = beautiful.notification_max_width or dpi(270),
                height   = beautiful.notification_max_height or dpi(120),
                widget   = wibox.container.constraint,
            },
            bg = beautiful.xcolor0,
            -- bg = bg_color,
            -- border_width = beautiful.border_width,
            -- border_color = beautiful.xcolor0,
            -- shape = helpers.rrect(beautiful.border_radius),
            widget = wibox.container.background
        }
    }
end)

-- Check if awesome encountered an error during startup
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)
