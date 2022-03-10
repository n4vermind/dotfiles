-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme library
local beautiful = require("beautiful")

-- Ruled
local ruled = require("ruled")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")


-- Decorations
----------------

local music_art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "theme/assets/icons/no_music.png",
    resize = true,
    widget = wibox.widget.imagebox
}

local music_art_container = wibox.widget{
    music_art,
    shape = helpers.rrect(6),
    widget = wibox.container.background
}

local music_now = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_pos = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_bar = wibox.widget {
    max_value = 100,
    value = 0,
    background_color = beautiful.xcolor0,
    color = beautiful.xcolor5,
    forced_height = dpi(3),
    widget = wibox.widget.progressbar
}

music_bar:connect_signal("button::press", function(_, lx, __, button, ___, w)
    if button == 1 then
        awful.spawn.with_shell("mpc seek " .. math.ceil(lx * 100 / w.width) .. "%")
    end
end)

local control_button_bg = "#00000000"
local control_button_bg_hover = beautiful.xcolor0
local control_button = function(c, symbol, color, size, on_click, on_right_click)
    local icon = wibox.widget{
        markup = helpers.colorize_text(symbol, color),
        font = beautiful.icon_font_name .. "Round 13",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        bg = control_button_bg,
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background
    }

    local container = wibox.widget {
        button,
        strategy = "min",
        width = dpi(30),
        widget = wibox.container.constraint,
    }

    container:buttons(gears.table.join(
        awful.button({ }, 1, on_click),
        awful.button({ }, 3, on_right_click)
    ))

    container:connect_signal("mouse::enter", function ()
        button.bg = control_button_bg_hover
    end)
    container:connect_signal("mouse::leave", function ()
        button.bg = control_button_bg
    end)

    return container
end

local music_play_pause = control_button(c, "", beautiful.xforeground, dpi(30), function()
    awful.spawn.with_shell("mpc -q toggle")
end)

-- Loop button
local loop = control_button(c, "", beautiful.xforeground, dpi(30), function()
    awful.spawn.with_shell("mpc repeat")
end)
-- Shuffle playlist
local shuffle = control_button(c, "", beautiful.xforeground, dpi(30), function()
    awful.spawn.with_shell("mpc random")
end)

local music_play_pause_textbox = music_play_pause:get_all_children()[1]:get_all_children()[1]
local loop_textbox = loop:get_all_children()[1]:get_all_children()[1]
local shuffle_textbox = shuffle:get_all_children()[1]:get_all_children()[1]

local playerctl = require("lib.bling").signal.playerctl.lib()
local music_length = 0

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, ___, player_name)
    if player_name == "mpd" then
        local m_now = artist .. " - " .. title .. "/" .. album

        music_art:set_image(gears.surface.load_uncached(album_path))
        music_now:set_markup_silently(m_now)
    end
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if player_name == "mpd" then
        local pos_now = tostring(os.date("!%M:%S", math.floor(interval_sec)))
        local pos_length = tostring(os.date("!%M:%S", math.floor(length_sec)))
        local pos_markup = pos_now .. helpers.colorize_text(" / " .. pos_length, beautiful.xcolor8)

        music_art:set_image(gears.surface.load_uncached(album_path))
        music_pos:set_markup_silently(pos_markup)
        music_bar.value = (interval_sec / length_sec) * 100
        music_length = length_sec
    end
end)

playerctl:connect_signal("playback_status", function(_, playing, player_name)
    if player_name == "mpd" then
        if playing then
            music_play_pause_textbox:set_markup_silently("")
        else
            music_play_pause_textbox:set_markup_silently("")
        end
    end
end)

playerctl:connect_signal("loop_status", function(_, loop_status, player_name)
    if player_name == "mpd" then
        if loop_status == "none" then
            loop_textbox:set_markup_silently("")
        else
            loop_textbox:set_markup_silently("")
        end
    end
end)

playerctl:connect_signal("shuffle", function(_, shuffle, player_name)
    if player_name == "mpd" then
        if shuffle then
            shuffle_textbox:set_markup_silently("")
        else
            shuffle_textbox:set_markup_silently("")
        end
    end
end)

local music_create_decoration = function (c)

    -- Hide default titlebar
    awful.titlebar.hide(c, beautiful.titlebar_pos)

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

    -- Titlebar
    awful.titlebar(c, { position = "top", size = beautiful.titlebar_size, bg = beautiful.xbackground }):setup {
        {
            {
                {
                    {
                        awful.titlebar.widget.closebutton(c),
                        awful.titlebar.widget.minimizebutton(c),
                        awful.titlebar.widget.maximizedbutton(c),
                        -- spacing = dpi(3),
                        layout = wibox.layout.fixed.horizontal
                    },
                    {
                        buttons = buttons,
                        widget = wibox.widget.textbox("")
                    },
                    layout = wibox.layout.align.horizontal
                },
                margins = dpi(10),
                widget = wibox.container.margin
            },
            bg = beautiful.bg_accent,
            forced_width = dpi(200),
            widget = wibox.container.background
        },
        {
            buttons = buttons,
            widget = wibox.widget.textbox("")
        },
		layout = wibox.layout.align.horizontal
    }

    -- Sidebar
    awful.titlebar(c, { position = "left", size = dpi(200), bg = beautiful.bg_accent }):setup {
        nil,
        {
            music_art_container,
            bottom = dpi(20),
            left = dpi(25),
            right = dpi(25),
            widget = wibox.container.margin
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
    }

    -- Toolbar
    awful.titlebar(c, { position = "bottom", size = dpi(63), bg = beautiful.bg_secondary }):setup {
        music_bar,
        {
            {
                {
                    -- Go to playlist and focus currently playing song
                    control_button(c, "", beautiful.xforeground, dpi(30), function()
                        awful.spawn.with_shell("mpc -q prev")
                    end),
                    -- Toggle play pause
                    music_play_pause,
                    -- Go to list of playlists
                    control_button(c, "", beautiful.xforeground, dpi(30), function()
                        awful.spawn.with_shell("mpc -q next")
                    end),
                    layout = wibox.layout.flex.horizontal
                },
                {
                    {
                        step_function = wibox.container.scroll
                            .step_functions
                            .waiting_nonlinear_back_and_forth,
                        speed = 50,
                        {
                            widget = music_now,
                        },
                        -- forced_width = dpi(110),
                        widget = wibox.container.scroll.horizontal
                    },
                    left = dpi(20),
                    right = dpi(20),
                    widget = wibox.container.margin
                },
                {
                    music_pos,
                    {
                        loop,
                        shuffle,
                        -- Go to list of playlists
                        control_button(c, "", beautiful.xforeground, dpi(30), function()
                            helpers.send_key(c, "1")
                        end),
                        layout = wibox.layout.flex.horizontal
                    },
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            },
            top = dpi(15),
            bottom = dpi(15),
            left = dpi(25),
            right = dpi(25),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.vertical
    }

    -- Set custom decoration flags
    c.custom_decoration = { top = true, left = true, bottom = true }
end

-- Add the titlebar whenever a new music client is spawned
ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        id = "music",
        rule = {instance = "music"},
        callback = music_create_decoration
    }
end)

