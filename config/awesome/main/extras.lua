-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi


-- Signals
------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set every new window as a slave,
    if not awesome.startup then awful.client.setslave(c) end
end)

-- Fixes wrong geometry when titlebars are enabled in fullscreen
client.connect_signal("manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

-- Raise focused clients automatically
client.connect_signal("focus", function(c)
    c:raise()
end)

-- Hide wibar when client is maximized or fullscreen
client.connect_signal("property::floating", function(c)
    if c.maximized or c.fullscreen then
        wibar_hide()
    else
        wibar_show()
    end
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        wibar_hide()
    elseif not c.fullscreen then
        wibar_show()
    end
end)

client.connect_signal("property::maximized", function(c)
    if c.maximized then
        wibar_hide()
    elseif not c.maximized then
        wibar_show()
    end
end)

tag.connect_signal('property::layout', function(t)
    if t.layout == awful.layout.suit.max.name then
        wibar_hide()
    end
end)


-- Restore geometry for floating clients
------------------------------------------

tag.connect_signal('property::layout', function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, 'floating_geometry')
            if cgeo then
                c:geometry(awful.client.property.get(c, 'floating_geometry'))
            end
        end
    end
end)

client.connect_signal('manage', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)

client.connect_signal('property::geometry', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)
