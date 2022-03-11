-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")


-- Layout list
----------------

local ll = awful.widget.layoutlist {
    -- source = awful.widget.layoutlist.source.default_layouts,
    spacing = dpi(24),
    base_layout = wibox.widget {
        spacing = dpi(24),
        forced_num_cols = dpi(4),
        layout = wibox.layout.grid.vertical
    },
    widget_template = {
        {
            {
                id = "icon_role",
                forced_height = dpi(68),
                forced_width = dpi(68),
                widget = wibox.widget.imagebox,
            },
            margins = dpi(24),
            widget = wibox.container.margin
        },
        id = "background_role",
        forced_width = dpi(68),
        forced_height = dpi(68),
        widget = wibox.container.background
    }
}

-- Pop up
------------

local pop_icon = wibox.widget{
    font = beautiful.icon_font_name .. "Round 48",
    align = "center",
    widget = wibox.widget.textbox
}

local pop_bar = wibox.widget {
    max_value = 100,
    value = 0,
    background_color = beautiful.pop_bar_bg,
    color = beautiful.bg_accent,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    forced_height = dpi(5),
    widget = wibox.widget.progressbar
}

local pop = wibox({
    type = "dock",
    screen = screen.focused,
    height = beautiful.pop_size,
    width = beautiful.pop_size,
    shape = helpers.rrect(beautiful.pop_border_radius - 1),
    bg = beautiful.transparent,
    ontop = true,
    visible = false
})

pop:setup {
    {
        {
            {
                helpers.vertical_pad(dpi(10)),
                pop_icon,
                layout = wibox.layout.fixed.vertical
            },
            nil,
            pop_bar,
            layout = wibox.layout.align.vertical
        },
        margins = dpi(30),
        widget = wibox.container.margin
    },
    bg = beautiful.xbackground,
    shape = helpers.rrect(beautiful.pop_border_radius),
    widget = wibox.container.background
}
awful.placement.bottom(pop, {margins = {bottom = dpi(100)}})

local pop_timeout = gears.timer {
    timeout = 1.4,
    autostart = true,
    callback = function()
        pop.visible = false
    end
}

local function toggle_pop()
    if pop.visible then
        pop_timeout:again()
    else
        pop.visible = true
        pop_timeout:start()
    end
end

local vol_first_time = true
awesome.connect_signal("signal::volume", function(value, muted)
    if vol_first_time then
        vol_first_time = false
    else
        pop_icon.markup = ""
        pop_bar.value = value

        if muted then
            pop_bar.color = beautiful.xcolor8
        else
            pop_bar.color = beautiful.pop_vol_color
        end

        toggle_pop()
    end
end)

awesome.connect_signal("signal::brightness", function(value)
    pop_icon.markup = ""
    pop_bar.value = value
    pop_bar.color = beautiful.pop_brightness_color

    toggle_pop()
end)

-- Popup
local layout_popup = awful.popup {
    widget = wibox.widget {
        {ll, margins = dpi(24), widget = wibox.container.margin},
        bg = beautiful.layoutlist_bg_normal,
        border_color = beautiful.border_color_normal,
        border_width = beautiful.border_width,
        shape = helpers.rrect(beautiful.pop_border_radius),
        widget = wibox.container.background,
    },
    type = "dropdown_menu",
    placement = awful.placement.centered,
    bg = beautiful.transparent,
    shape = helpers.rrect(beautiful.pop_border_radius - 1),
    ontop = true,
    visible = false,
}

function gears.table.iterate_value(t, value, step_size, filter, start_at)
    local k = gears.table.hasitem(t, value, true, start_at)
    if not k then return end

    step_size = step_size or 1
    local new_key = gears.math.cycle(#t, k + step_size)

    if filter and not filter(t[new_key]) then
        for i = 1, #t do
            local k2 = gears.math.cycle(#t, new_key + i)
            if filter(t[k2]) then return t[k2], k2 end
        end
        return
    end

    return t[new_key], new_key
end

mod = "Mod4"
shift = "Shift"
awful.keygrabber {
    start_callback = function() layout_popup.visible = true end,
    stop_callback = function() layout_popup.visible = false end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = {"Escape", "Super_L", "Super_R", "Mod4"},
    keybindings = {
        {
            {mod}, " ", function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1), nil)
            end
        },
        {
            {mod, shift}, " ", function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
            end
        }
    }
}

