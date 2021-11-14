-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- rubato
local rubato = require("lib.rubato")

-- Helpers
local helpers = require("misc.helpers")


-- Sidebar
------------

local function centered_widget(widget)
    local w = wibox.widget{
        nil,
        {
            nil,
            widget,
            nil,
            expand = "none",
            layout = wibox.layout.align.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal
    }

    return w
end


-- User
local username = "@ner0z"
local name = "Dani Daneswara"

local profile_pic_img = wibox.widget{
    image = beautiful.profile,
    halign = "center",
    valign = "center",
    widget = wibox.widget.imagebox
}

local profile_pic_container = wibox.widget{
    shape = gears.shape.circle,
    forced_height = dpi(115),
    forced_width = dpi(115),
    widget = wibox.container.background
}

local profile_pic = wibox.widget{
    profile_pic_img,
    widget = profile_pic_container
}

local name_text = wibox.widget{
    markup = name,
    font = beautiful.font_name .. "20",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local username_text = wibox.widget{
    markup = helpers.colorize_text(username, beautiful.xcolor8),
    font = "Iosevka Italic 10",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local user = wibox.widget{
    profile_pic,
    helpers.vertical_pad(dpi(9)),
    name_text,
    username_text,
    layout = wibox.layout.fixed.vertical
}

-- Bars
local function boxed_bar()
    local w = wibox.widget{
        max_value = 100,
        value = 50,
        background_color = beautiful.xcolor8 .. "20",
        color = beautiful.xcolor8 .. "55",
        shape = helpers.rrect(dpi(8)),
        widget = wibox.widget.progressbar
    }

    return w
end

local function format_bar(bar, icon, color)
    local bars = wibox.widget{
        bar,
        forced_height = dpi(55),
        forced_width = dpi(55),
        direction = "east",
        widget = wibox.container.rotate
    }

    local icons = wibox.widget{
        markup = helpers.colorize_text(icon, color),
        align = "center",
        valign = "center",
        font = beautiful.icon_font_name .. "14",
        widget = wibox.widget.textbox
    }

    local text = wibox.widget{
        markup = helpers.colorize_text("0", color),
        align = "center",
        valign = "center",
        font = "Iosevka Extrabold 14",
        widget = wibox.widget.textbox,
        visible = false
    }

    local w = wibox.widget{bars, icons, text, layout = wibox.layout.stack}

    return w
end

local function mouse_hover(widget)
    widget:connect_signal("mouse::enter", function()
        widget.children[2].visible = false
        widget.children[3].visible = true
    end)

    widget:connect_signal("mouse::leave", function()
        widget.children[2].visible = true
        widget.children[3].visible = false
    end)
end

local volume = boxed_bar()
local brightness = boxed_bar()
local cpu = boxed_bar()
local disk = boxed_bar()

local volume_color = beautiful.xcolor4
local brightness_color = beautiful.xcolor3
local cpu_color = beautiful.xcolor2
local disk_color = beautiful.xcolor5

local volume_bar = format_bar(volume, "", volume_color)
local brightness_bar = format_bar(brightness, "", brightness_color)
local cpu_bar = format_bar(cpu, "", cpu_color)
local disk_bar = format_bar(disk, "", disk_color)

awesome.connect_signal("signal::volume", function(value, muted)
	local fill_color

    if muted then
        volume_bar.children[2].markup = helpers.colorize_text("", volume_color)
        volume_bar.children[3].markup = helpers.colorize_text("M", volume_color)
        fill_color = beautiful.xcolor1 .. "55"
    else
        if value then
            if value > 50 then
                volume_bar.children[2].markup = helpers.colorize_text("", volume_color)
            else
                volume_bar.children[2].markup = helpers.colorize_text("", volume_color)
            end
            volume_bar.children[3].markup = helpers.colorize_text(tostring(value), volume_color)
        end
        fill_color = beautiful.xcolor8 .. 55
    end

    volume.value = value
    volume.color = fill_color
end)

awesome.connect_signal("signal::brightness", function (value)
    brightness.value = value
    brightness_bar.children[3].markup = helpers.colorize_text(tostring(value), brightness_color)
end)

awesome.connect_signal("signal::cpu", function(value)
    cpu.value = value
    cpu_bar.children[3].markup = helpers.colorize_text(tostring(value), cpu_color)
end)

awesome.connect_signal("signal::disk", function(used, total)
    disk.value = used * 100 / total
    disk_bar.children[3].markup = helpers.colorize_text(tostring(helpers.round(total - used, 1)), disk_color)
end)

mouse_hover(volume_bar)
mouse_hover(brightness_bar)
mouse_hover(cpu_bar)
mouse_hover(disk_bar)

volume_bar:buttons(gears.table.join(
    awful.button({}, 4, function()
        helpers.volume_control(2)
    end),

    awful.button({}, 5, function()
        helpers.volume_control(-2)
    end)
))

brightness_bar:buttons(gears.table.join(
    awful.button({}, 4, function()
        awful.spawn.with_shell("light -A 2")
    end),

    awful.button({}, 5, function()
        awful.spawn.with_shell("light -U 2")
    end)
))

local stat = centered_widget({
	volume_bar,
	brightness_bar,
	cpu_bar,
	disk_bar,
	forced_num_cols = 2,
	spacing = dpi(10) * 2,
	layout = wibox.layout.grid
})

-- Music
local create_button = function(symbol, color, command, playpause)

    local icon = wibox.widget{
        markup = helpers.colorize_text(symbol, color),
        font = beautiful.icon_font_name .. "10",
        align = "center",
        valigin = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget{
        icon,
        forced_height = dpi(15),
        forced_width = dpi(15),
        widget = wibox.container.background
    }

    awesome.connect_signal("bling::playerctl::status", function(playing)
        if playpause then
            if playing then
                icon.markup = helpers.colorize_text("", color)
            else
                icon.markup = helpers.colorize_text("", color)
            end
        end
    end)

    button:buttons(gears.table.join(awful.button({}, 1, function() command() end)))

    button:connect_signal("mouse::enter", function()
        icon.markup = helpers.colorize_text(icon.text, beautiful.xcolor15)
    end)

    button:connect_signal("mouse::leave", function()
        icon.markup = helpers.colorize_text(icon.text, color)
    end)

    return button
end

local art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "theme/icons/no_music.png",
    resize = true,
    forced_height = dpi(55),
    widget = wibox.widget.imagebox
}

local art_container = wibox.widget {
    shape = helpers.rrect(dpi(5)),
    forced_height = dpi(55),
    forced_width = dpi(55),
    widget = wibox.container.background
}

local title = wibox.widget {
    markup = "Nothing Playing",
    font = beautiful.font_name .. "9",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local artist = wibox.widget {
    markup = "Nothing Playing",
    font = beautiful.font_name .. "9",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
    visible = false
}

awesome.connect_signal("bling::playerctl::title_artist_album", function(title_current, artist_current, art_path)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(art_path))

    title:set_markup_silently('<span foreground="' .. beautiful.xforeground .. '">' .. title_current .. '</span>')
    artist:set_markup_silently('<span foreground="' .. beautiful.xcolor7 .. '">' .. artist_current .. '</span>')
end)

local pos_min = wibox.widget {
    markup = "00",
    align = "center",
    valign = "center",
    font = "Iosevka Extrabold 14",
    widget = wibox.widget.textbox,
}

local pos_sec = wibox.widget {
    markup = "00",
    align = "center",
    valign = "center",
    font = "Iosevka Extrabold 14",
    widget = wibox.widget.textbox,
}

local position = wibox.widget {
    {
        nil,
        {
            {pos_min, right = dpi(11), widget = wibox.container.margin},
            {pos_sec, left = dpi(11), widget = wibox.container.margin},
            widget = wibox.layout.fixed.vertical
        },
        nil,
        expand = "none",
        widget = wibox.layout.align.vertical
    },
    bg = beautiful.xcolor0 .. "77",
    widget = wibox.container.background,
    visible = false
}

awesome.connect_signal("bling::playerctl::position", function(pos, length)
    local pos_now = math.floor(length - pos)

    pos_min.markup = helpers.colorize_text(tostring(os.date("!%M", pos_now)), beautiful.xforeground)
    pos_sec.markup = helpers.colorize_text(tostring(os.date("!%S", pos_now)), beautiful.xforeground)
end)

art:connect_signal("mouse::enter", function()
    position.visible = true
end)
art:connect_signal("mouse::leave", function()
    position.visible = false
end)

title:connect_signal("mouse::enter", function()
    title.visible = false
    artist.visible = true
end)
title:connect_signal("mouse::leave", function()
    title.visible = true
    artist.visible = false
end)

local play_command = function() helpers.music_control("toggle") end
local prev_command = function() helpers.music_control("prev") end
local next_command = function() helpers.music_control("next") end

local play_symbol = create_button("", beautiful.xcolor4, play_command, true)
local prev_symbol = create_button("", beautiful.xcolor4, prev_command, false)
local next_symbol = create_button("", beautiful.xcolor4, next_command, false)

local music = wibox.widget{
    {
        {
            {art, position, layout = wibox.layout.stack},
            widget = art_container
        },
        {
            nil,
            {
                {
                    -- step_function = wibox.container.scroll
                    --     .step_functions
                    --     .waiting_nonlinear_back_and_forth,
                    -- speed = 50,
                    {title, artist, layout = wibox.layout.stack},
                    forced_height = dpi(20),
                    left = dpi(20),
                    right = dpi(20),
                    widget = wibox.container.margin
                },
                {
                    nil,
                    {
                        prev_symbol,
                        play_symbol,
                        next_symbol,
                        spacing = dpi(20),
                        layout = wibox.layout.fixed.horizontal
                    },
                    nil,
                    expand = "none",
                    layout = wibox.layout.align.horizontal
                },
                spacing = dpi(12),
                layout = wibox.layout.fixed.vertical
            },
            nil,
            expand = "none",
            layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal
    },
    left = dpi(5),
    right = dpi(5),
    widget = wibox.container.margin
    -- bg = beautiful.xcolor8 .. "22",
    -- shape = helpers.rrect(dpi(4)),
    -- widget = wibox.container.background
}

-- Sidebar
sidebar = wibox({
    type = "dock",
    screen = screen.primary,
    height = beautiful.sidebar_height or dpi(500),
    width = beautiful.sidebar_width or dpi(250),
    shape = helpers.prrect(dpi(8), false, true, true, false),
    border_width = dpi(2),
    border_color = beautiful.border_color,
    ontop = true,
    visible = false
})

awful.placement.left(sidebar, {honor_workarea = true, margins = {top = beautiful.wibar_size}})

sidebar:buttons(gears.table.join(
    -- Middle click - Hide sidebar
    awful.button({}, 2, function()
        sidebar_hide()
    end)
))

local slide = rubato.timed{
    pos = dpi(-254),
    rate = 60,
    intro = 0.3,
    duration = 0.8,
    easing = rubato.quadratic,
    awestore_compat = true,
    subscribed = function(pos) sidebar.x = pos end
}

local sidebar_status = false

slide.ended:subscribe(function()
    if sidebar_status then
        sidebar.visible = false
    end
end)

sidebar_show = function()
    sidebar.visible = true
    slide:set(-2)
    sidebar_status = false
end

sidebar_hide = function()
    slide:set(-254)
    sidebar_status = true
end

sidebar_toggle = function()
    if sidebar.visible then
        sidebar_hide()
    else
        sidebar_show()
    end
end

sidebar:setup {
	{
		user,
		stat,
		music,
		widget = wibox.layout.align.vertical
	},
	left = dpi(20),
	right = dpi(20),
    top = dpi(30),
    bottom = dpi(30),
	widget = wibox.container.margin
}
