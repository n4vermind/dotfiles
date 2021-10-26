-- Standard library
local gears = require("gears")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Notifications library
local naughty = require("naughty")

-- Widget library
local wibox = require("wibox")

-- Menubar
local menubar = require("menubar")

-- Helpers
local helpers = require("misc.helpers")

-- local ping = {}


-- Notification settings
--------------------------

-- Icon
local default_icon = ""
naughty.config.defaults['border_width'] = beautiful.notification_border_width

-- Custom text icons according to the notification's app_name
-- plus whether the title should be visible or not
-- (This will be removed when notification rules are released)
-- Using Material Designs font
local app_config = {
    ['battery'] = { icon = "", title = false },
    ['charger'] = { icon = "", title = false },
    ['volume'] = { icon = "", title = false },
    ['brightness'] = { icon = "", title = false },
    ['screenshot'] = { icon = "", title = false },
    ['Telegram Desktop'] = { icon = "", title = true },
    ['discord'] = { icon = "", title = true },
    ['NetworkManager'] = { icon = "", title = true },
    ['mpd'] = { icon = "", title = true },
    ['mpv'] = { icon = "", title = true },
}

local urgency_color = {
    ['low'] = beautiful.xcolor2,
    ['normal'] = beautiful.xcolor4,
    ['critical'] = beautiful.xcolor11,
}

-- Timeouts
naughty.config.defaults.timeout = 5
naughty.config.presets.low.timeout = 2
naughty.config.presets.critical.timeout = 12


-- Notification template
--------------------------
naughty.connect_signal("request::display", function(n)

    -- Custom icon widget
    -- It can be used instead of naughty.widget.icon if you prefer your icon to be
    -- a textbox instead of an image. However, you have to determine its
    -- text/markup value from the notification before creating the
    -- naughty.layout.box.
    local custom_notification_icon = wibox.widget {
        font = beautiful.icon_font_name .. "18",
        -- font = "icomoon bold 40",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local icon, title_visible
    local color = urgency_color[n.urgency]
    -- Set icon according to app_name
    if app_config[n.app_name] then
        icon = app_config[n.app_name].icon
        title_visible = app_config[n.app_name].title
    else
        icon = default_icon
        title_visible = true
    end

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(3),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        font = beautiful.notification_font,
                        widget = wibox.widget.textbox
                    },
                    left = dpi(6),
                    right = dpi(6),
                    widget = wibox.container.margin
                },
                widget = wibox.container.place
            },
            bg = beautiful.xcolor8.."32",
            forced_height = dpi(25),
            forced_width = dpi(70),
            widget = wibox.container.background
        },
        style = {
            underline_normal = false,
            underline_selected = true
        },
        widget = naughty.list.actions
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        -- For antialiasing: The real shape is set in widget_template
        shape = gears.shape.rectangle,
        border_width = beautiful.notification_border_width,
        border_color = beautiful.notification_border_color,
        position = beautiful.notification_position,
        widget_template = {
            {
                {
                    {
                        markup = helpers.colorize_text(icon, color),
                        align = "center",
                        valign = "center",
                        widget = custom_notification_icon,
                    },
                    forced_width = dpi(50),
                    bg = beautiful.xbackground,
                    widget  = wibox.container.background,
                },
                {
                    {
                        {
                            align = "center",
                            visible = title_visible,
                            font = beautiful.notification_font,
                            markup = "<b>"..n.title.."</b>",
                            widget = wibox.widget.textbox,
                            -- widget = naughty.widget.title,
                        },
                        {
                            align = "center",
                            -- wrap = "char",
                            widget = naughty.widget.message,
                        },
                        {
                            helpers.vertical_pad(dpi(10)),
                            {
                                actions,
                                shape = helpers.rrect(dpi(4)),
                                widget = wibox.container.background,
                            },
                            visible = n.actions and #n.actions > 0,
                            layout  = wibox.layout.fixed.vertical
                        },
                        layout  = wibox.layout.align.vertical,
                    },
                    margins = beautiful.notification_margin,
                    widget  = wibox.container.margin,
                },
                layout  = wibox.layout.fixed.horizontal,
            },
            strategy = "max",
            width    = beautiful.notification_max_width or dpi(350),
            height   = beautiful.notification_max_height or dpi(180),
            widget   = wibox.container.constraint,
        },
    }
end)


-- Notify
-----------
-- Example usage:
--     local my_notif = notifications.notify_dwim({ title = "hello", message = "there" }, my_notif)
--     -- After a while, use this to update or recreate the notification if it is expired / dismissed
--     my_notif = notifications.notify_dwim({ title = "good", message = "bye" }, my_notif)
-- function ping.notify(args, notif)
--     local n = notif
--     if n and not n._private.is_destroyed and not n.is_expired then
--         notif.title = args.title or notif.title
--         notif.message = args.message or notif.message
--         -- notif.text = args.text or notif.text
--         notif.icon = args.icon or notif.icon
--         notif.timeout = args.timeout or notif.timeout
--     else
--         n = naughty.notification(args)
--     end
--     return n
-- end

-- Handle notification icon
naughty.connect_signal("request::icon", function(n, context, hints)
    -- Handle other contexts here
    if context ~= "app_icon" then return end

    -- Use XDG icon
    local path = menubar.utils.lookup_icon(hints.app_icon) or
    menubar.utils.lookup_icon(hints.app_icon:lower())

    if path then
        n.icon = path
    end
end)

-- Use XDG icon
naughty.connect_signal("request::action_icon", function(a, context, hints)
    a.icon = menubar.utils.lookup_icon(hints.id)
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

-- return ping
