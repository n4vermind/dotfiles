-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- rubato
local rubato = require("lib.rubato")

-- Helpers
local helpers = require("helpers")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


-- Tooltip
------------

-- Helpers
local function create_boxed_widget(widget_to_be_boxed, width, height, inner_pad)
    local box_container = wibox.container.background()
    box_container.bg = beautiful.tooltip_box_bg
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(beautiful.tooltip_box_border_radius)

    local inner = dpi(0)

    if inner_pad then inner = beautiful.tooltip_box_margin end

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- The actual widget goes here
                widget_to_be_boxed,
                margins = inner,
                widget = wibox.container.margin
            },
            widget = box_container,
        },
        margins = beautiful.tooltip_gap / 2,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end


---- Stats

-- Wifi
local wifi_text = wibox.widget{
    markup = helpers.colorize_text("WiFi", beautiful.xcolor8),
    font = beautiful.font_name .. "8",
    widget = wibox.widget.textbox
}

local wifi_ssid = wibox.widget{
    markup = "Offline",
    font = beautiful.font_name .. "bold 10",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local wifi = wibox.widget{
    wifi_text,
    nil,
    wifi_ssid,
    layout = wibox.layout.align.vertical
}

awesome.connect_signal("signal::network", function(status, ssid)
    wifi_ssid.markup = ssid
end)

-- Battery
local batt_text = wibox.widget{
    markup = helpers.colorize_text("Battery", beautiful.xcolor8),
    font = beautiful.font_name .. "8",
    valign = "center",
    widget = wibox.widget.textbox
}

local batt_perc = wibox.widget{
    markup = "N/A",
    font = beautiful.font_name .. "bold 10",
    valign = "center",
    widget = wibox.widget.textbox
}

local batt_bar = wibox.widget {
    max_value = 100,
    value = 20,
    background_color = beautiful.transparent,
    color = beautiful.xcolor0,
    widget = wibox.widget.progressbar
}

local batt = wibox.widget{
    batt_bar,
    {
        {
            batt_text,
            nil,
            batt_perc,
            -- spacing = dpi(5),
            layout = wibox.layout.align.vertical
        },
        margins = beautiful.tooltip_box_margin,
        widget = wibox.container.margin
    },
    layout = wibox.layout.stack
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
    local b = batt_val
    local fill_color = beautiful.bg_accent

    if batt_charger then
        fill_color = beautiful.xcolor2 .. "33"
    else
        if batt_val <= 15 then
            fill_color = beautiful.xcolor1 .. "33"
        end
    end

    batt_perc.markup = b .. "%"
    batt_bar.value = b
    batt_bar.color = fill_color
end)

-- Music
local music_text = wibox.widget{
    markup = helpers.colorize_text("Nothing Playing", beautiful.xcolor8),
    font = beautiful.font_name .. "8",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "theme/assets/icons/no_music.png",
    resize = true,
    opacity = 0.2,
    halign = "center",
    valign = "center",
    widget = wibox.widget.imagebox
}

local music_title = wibox.widget{
    markup = "No Title",
    font = beautiful.font_name .. "bold 10",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_artist = wibox.widget{
    markup = helpers.colorize_text("No Artist", beautiful.xcolor8),
    font = beautiful.font_name .. "9",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_status = wibox.widget{
    markup = "",
    font = beautiful.icon_font_name .. "Round 16",
    align = "right",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local music_volume_icon = wibox.widget{
    markup = "",
    font = beautiful.icon_font_name .. "Round 12",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local music_volume_perc = wibox.widget{
    markup = "N/A",
    font = beautiful.font_name .. "bold 10",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local music_volume = wibox.widget{
    music_volume_icon,
    music_volume_perc,
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}

local music = wibox.widget{
    music_art,
    {
        {
            {
                music_text,
                {
                    step_function = wibox.container.scroll
                        .step_functions
                        .waiting_nonlinear_back_and_forth,
                    speed = 50,
                    {
                        widget = music_title,
                    },
                    -- forced_width = dpi(110),
                    widget = wibox.container.scroll.horizontal
                },
                {
                    step_function = wibox.container.scroll
                        .step_functions
                        .waiting_nonlinear_back_and_forth,
                    speed = 50,
                    {
                        widget = music_artist,
                    },
                    -- forced_width = dpi(110),
                    widget = wibox.container.scroll.horizontal
                },
                layout = wibox.layout.fixed.vertical
            },
            nil,
            {
                music_volume,
                nil,
                music_status,
                layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.align.vertical
        },
        margins = beautiful.tooltip_box_margin,
        widget = wibox.container.margin
    },
    layout = wibox.layout.stack
}

local playerctl = require("lib.bling").signal.playerctl.lib()
playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
    if title == "" then title = "No Title" end
    if artist == "" then artist = "No Artist" end
    if album_path == "" then album_path = gears.filesystem.get_configuration_dir() .. "theme/assets/icons/no_music.png" end

    music_art:set_image(gears.surface.load_uncached(album_path))
    music_title:set_markup_silently(title)
    music_artist:set_markup_silently(helpers.colorize_text(artist, beautiful.xcolor8))
end)

playerctl:connect_signal("playback_status", function(_, playing, __)
    if playing then
        music_text:set_markup_silently(helpers.colorize_text("Now Playing", beautiful.xcolor8))
        music_status:set_markup_silently("")
    else
        music_text:set_markup_silently(helpers.colorize_text("Music", beautiful.xcolor8))
        music_status:set_markup_silently("")
    end
end)

awesome.connect_signal("signal::volume", function(value, muted)
    local v = value or 0

    if muted then
        v = "Muted"
    end

    music_volume_perc.markup = v
end)

local wifi_boxed = create_boxed_widget(wifi, dpi(110), dpi(50), true)
local batt_boxed = create_boxed_widget(batt, dpi(110), dpi(50))
local music_boxed = create_boxed_widget(music, dpi(110), dpi(110))

-- Stats
stats_tooltip = wibox({
    type = "dropdown_menu",
    screen = screen.primary,
    height = dpi(150),
    width = dpi(270),
    shape = helpers.rrect(beautiful.tooltip_border_radius - 1),
    bg = beautiful.transparent,
    ontop = true,
    visible = false
})

awful.placement.bottom_left(stats_tooltip, {honor_workarea = true, margins = {left = beautiful.useless_gap, bottom = dpi(109)}})

stats_tooltip_show = function()
    stats_tooltip.visible = true
end

stats_tooltip_hide = function()
    stats_tooltip.visible = false
end

stats_tooltip:setup {
    {
        {
            {
                wifi_boxed,
                batt_boxed,
                layout = wibox.layout.fixed.vertical
            },
            music_boxed,
            layout = wibox.layout.fixed.horizontal
        },
        margins = beautiful.tooltip_margin,
        widget = wibox.container.margin
    },
    shape = helpers.rrect(beautiful.tooltip_border_radius),
    bg = beautiful.xbackground,
    widget = wibox.container.background
}


---- Calendar

-- Date
local date_day = wibox.widget{
    font = beautiful.font_name .. "8",
    format = helpers.colorize_text("%A", beautiful.xcolor8),
    widget = wibox.widget.textclock
}

local date_month = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    format = "%d %B",
    widget = wibox.widget.textclock
}

local date = wibox.widget{
    date_day,
    nil,
    date_month,
    layout = wibox.layout.align.vertical
}

-- Time
local time_hour = wibox.widget{
    font = beautiful.font_name .. "bold 18",
    format = "%I",
    align = "center",
    widget = wibox.widget.textclock
}

local time_min = wibox.widget{
    font = beautiful.font_name .. "bold 18",
    format = "%M",
    align = "center",
    widget = wibox.widget.textclock
}

local time_eq = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    format = "%p",
    align = "center",
    widget = wibox.widget.textclock
}

-- Weather
local weather_icon = wibox.widget{
    markup = "",
    font = "icomoon 20",
    align = "center",
    widget = wibox.widget.textbox
}

local weather_temp = wibox.widget{
    markup = "25°C",
    font = beautiful.font_name .. "bold 10",
    align = "center",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local weather = wibox.widget{
    weather_icon,
    nil,
    weather_temp,
    layout = wibox.layout.align.vertical
}

awesome.connect_signal("signal::weather", function(temperature, _, icon_widget)
    local weather_temp_symbol
    if weather_units == "metric" then
        weather_temp_symbol = "°C"
    elseif weather_units == "imperial" then
        weather_temp_symbol = "°F"
    end

    weather_icon.markup = icon_widget
    weather_temp.markup = temperature .. weather_temp_symbol
end)

-- Widget
local date_boxed = create_boxed_widget(date, dpi(110), dpi(50), true)
local hour_boxed = create_boxed_widget(time_hour, dpi(50), dpi(50), true)
local min_boxed = create_boxed_widget(time_min, dpi(50), dpi(50), true)
local eq_boxed = create_boxed_widget(time_eq, dpi(50), dpi(30), true)
local weather_boxed = create_boxed_widget(weather, dpi(50), dpi(70), true)

-- Stats
cal_tooltip = wibox({
    type = "dropdown_menu",
    screen = screen.primary,
    height = dpi(150),
    width = dpi(210),
    shape = helpers.rrect(beautiful.tooltip_border_radius - 1),
    bg = beautiful.transparent,
    ontop = true,
    visible = false
})

awful.placement.bottom_left(cal_tooltip, {honor_workarea = true, margins = {left = beautiful.useless_gap, bottom = dpi(12)}})

cal_tooltip_show = function()
    cal_tooltip.visible = true
end

cal_tooltip_hide = function()
    cal_tooltip.visible = false
end

cal_tooltip:setup {
    {
        {
            {
                date_boxed,
                {
                    hour_boxed,
                    min_boxed,
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.vertical
            },
            {
                weather_boxed,
                eq_boxed,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        margins = beautiful.tooltip_margin,
        widget = wibox.container.margin
    },
    shape = helpers.rrect(beautiful.tooltip_border_radius),
    bg = beautiful.xbackground,
    widget = wibox.container.background
}

