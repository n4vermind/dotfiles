-- Standard library
local gears = require("gears")
local awful = require("awful")

-- Hotkeys library
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme library
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Notifications library
local naughty = require("naughty")

-- Helpers
local helpers = require("misc.helpers")

local keys = {}


-- Make key easier to call
----------------------------

mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"


-- Global key bindings
------------------------

keys.globalkeys = gears.table.join(

---- App

    -- Terminal
    awful.key({mod}, "Return", function()
        awful.spawn(terminal)
    end,
    {description = "Spawn terminal", group = "App"}),

    -- Floating terminal
    awful.key({mod, shift}, "Return", function()
        awful.spawn(terminal, {floating = true})
    end,
    {description = "Spawn floating terminal", group = "App"}),

    -- Launcher
    awful.key({mod}, "r", function()
        awful.spawn(launcher)
    end,
    {description = "Spawn launcher", group = "App"}),

    -- Hotkeys menu
    awful.key({mod}, "\\",
        hotkeys_popup.show_help,
    {description = "Hotkeys menu", group = "App"}),

---------
---- WM

    -- Toggle titlebar
    awful.key({mod}, "t", function()
        awful.titlebar.toggle(client.focus, beautiful.titlebar_pos)
    end,
    {description = "Toggle titlebar", group = "WM"}),

    -- Toggle titlebar (for all visible clients in selected tag)
	awful.key({mod, shift}, "t", function(c)
		local clients = awful.screen.focused().clients
		for _, c in pairs(clients) do
			awful.titlebar.toggle(c, beautiful.titlebar_pos)
		end
	end,
	{description = "Toggle all titlebar", group = "WM"}),

	-- Toggle bar
	awful.key({mod}, "b", function()
		for s in screen do
			s.mywibar.visible = not s.mywibar.visible
		end
	end,
	{description = "Toggle bar", group = "WM"}),

	-- Restart awesome
	awful.key({mod, shift}, "r", 
		awesome.restart,
	{description = "Reload awesome", group = "WM"}),

	-- Quit awesome
	awful.key({mod, shift}, "q", 
		awesome.quit,
	{description = "Quit awesome", group = "WM"}),

-------------
---- Window

    -- Focus client by direction
	awful.key({mod}, "k", function()
		awful.client.focus.bydirection("up")
	end,
	{description = "Focus up", group = "Window"}),

	awful.key({mod}, "h", function()
		awful.client.focus.bydirection("left")
	end,
	{description = "Focus left", group = "Window"}),

	awful.key({mod}, "j", function()
		awful.client.focus.bydirection("down")
	end,
	{description = "Focus down", group = "Window"}),

	awful.key({mod}, "l", function()
		awful.client.focus.bydirection("right")
	end,
	{description = "Focus right", group = "Window"}),

    -- Resize focused client
	awful.key({mod, ctrl}, "k", function(c)
        helpers.resize_client(client.focus, "up")
	end,
	{description = "Resize to the up", group = "Window"}),

	awful.key({mod, ctrl}, "h", function(c)
        helpers.resize_client(client.focus, "left")
	end,
	{description = "Resize to the left", group = "Window"}),

	awful.key({mod, ctrl}, "j", function(c)
        helpers.resize_client(client.focus, "down")
	end,
	{description = "Resize to the down", group = "Window"}),

	awful.key({mod, ctrl}, "l", function(c)
        helpers.resize_client(client.focus, "right")
	end,
	{description = "Resize to the right", group = "Window"}),

    -- Switch to next layout
    awful.key({mod}, "space", function()
		awful.layout.inc(1)
	end,
	{description = "Switch to next layout", group = "Window"}),

	-- Switch to previous layout
	awful.key({mod, shift}, "space", function()
		awful.layout.inc(-1)
	end,
	{description = "Switch to prev layout", group = "Window"}),

------------
---- Bling

    -- Add client to tabbed layout
	awful.key({mod, shift}, "e", function()
		awesome.emit_signal("tabbed::add")
	end,
	{description = "Add client to tabbed layout", group = "Bling"}),

    -- Remove client from tabbed layout
	awful.key({mod, ctrl}, "e", function()
		awesome.emit_signal("tabbed::destroy")
	end,
	{description = "Remove client from tabbed layout", group = "Bling"}),

	-- Cycle through client in tabbed layout
	awful.key({mod}, "`", function()
		awesome.emit_signal("tabbed::cycle")
	end,
	{description = "Cycle through client in tabbed layout", group = "Bling"}),

    -- Discord scratchpad
	awful.key({mod}, "d", function()
		awesome.emit_signal("scratch::discord")
	end,
	{description = "Toggle music scratchpad", group = "Bling"}),

    -- Spotify scratchpad
	awful.key({mod}, "s", function()
		awesome.emit_signal("scratch::spotify")
	end,
	{description = "Toggle music scratchpad", group = "Bling"}),

-----------
---- Misc

    -- Screen brightness
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("light -U 2")
	end,
	{description = "Decrease screen brightness", group = "Misc"}),

	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("light -A 2")
	end,
	{description = "Increase screen brightness", group = "Misc"}),

    -- Keyboard brightness (i'm using macbook)
	awful.key({}, "XF86KbdBrightnessDown", function()
		awful.spawn.with_shell("light -s sysfs/leds/smc::kbd_backlight -U 5")
	end,
	{description = "Decrease keyboard brightness", group = "Misc"}),

	awful.key({}, "XF86KbdBrightnessUp", function()
		awful.spawn.with_shell("light -s sysfs/leds/smc::kbd_backlight -A 5")
	end,
	{description = "Increase keyboard brightness", group = "Misc"}),

	-- Volume
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
	end,
	{description = "Toggle volume", group = "Misc"}),

	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -2%")
	end,
	{description = "Lower volume", group = "Misc"}),

	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +2%")
	end,
	{description = "Raise volume", group = "Misc"}),

	-- Music
	awful.key({}, "XF86AudioPlay", function()
		awful.spawn.with_shell("playerctl -p spotify,mpd play-pause")
	end,
	{description = "Toggle music", group = "Misc"}),

	awful.key({}, "XF86AudioPrev", function()
		awful.spawn.with_shell("playerctl -p spotify,mpd previous")
	end,
	{description = "Previous music", group = "Misc"}),

	awful.key({}, "XF86AudioNext", function()
		awful.spawn.with_shell("playerctl -p spotify,mpd next")
	end,
	{description = "Next music", group = "Misc"}),

    -- Screenshot
	awful.key({mod}, "/", function()
		awful.spawn.with_shell("screensht")
	end,
	{description = "Take screenshot", group = "Misc"})

)


-- Client key bindings
------------------------
keys.clientkeys = gears.table.join(

    -- Move or swap by direction
	awful.key({mod, shift}, "k", function(c)
        helpers.move_client(c, "up")
	end),

	awful.key({mod, shift}, "h", function(c)
        helpers.move_client(c, "left")
	end),

	awful.key({mod, shift}, "j", function(c)
        helpers.move_client(c, "down")
	end),

	awful.key({mod, shift}, "l", function(c)
        helpers.move_client(c, "right")
	end),

    -- Relative move client
    awful.key({mod, shift, ctrl}, "j", function (c)
        c:relative_move(0,  dpi(20), 0, 0)
    end),

    awful.key({mod, shift, ctrl}, "k", function (c)
        c:relative_move(0, dpi(-20), 0, 0)
    end),

    awful.key({mod, shift, ctrl}, "h", function (c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end),

    awful.key({mod, shift, ctrl}, "l", function (c)
        c:relative_move(dpi( 20), 0, 0, 0)
    end),

	-- Toggle floating
	awful.key({mod, ctrl}, "space",
		awful.client.floating.toggle
    ),

	-- Toggle fullscreen
	awful.key({mod}, "f", function()
		client.focus.fullscreen = not client.focus.fullscreen 
		client.focus:raise()
	end),

	-- Toggle maximize
	awful.key({mod}, "m", function()
		client.focus.maximized = not client.focus.maximized
	end),

	-- Minimize windows
	awful.key({mod}, "n", function()
		client.focus.minimized = true
	end),

	-- Un-minimize windows
	awful.key({mod, shift}, "n", function()
		local c = awful.client.restore()
		if c then
			c:activate{raise = true, context = "key.unminimize"}
		end
	end),

    -- Keep on top
    awful.key({mod}, "p", function (c)
        c.ontop = not c.ontop
    end),

    -- Sticky
    awful.key({mod, shift}, "p", function (c)
        c.sticky = not c.sticky
    end),

	-- Close window
	awful.key({mod}, "w", function()
		client.focus:kill()
	end),

	-- Center window
	awful.key({mod}, "c", function()
        awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
	end),

	-- Window switcher
	awful.key({mod}, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end)

)


-- Move through workspaces
----------------------------
for i = 1, 10 do
    keys.globalkeys = gears.table.join(keys.globalkeys,

        -- view workspaces
        awful.key({mod}, "#" .. i + 9, function()
            local s = mouse.screen
            local tag = s.tags[i]
            if tag then
                if tag == s.selected_tag then
                    awful.tag.history.restore()
                else
                    tag:view_only()
                end
            end
		    awesome.emit_signal("bling::tag_preview::visibility", s, false)
        end),

        -- move focused client to workspaces
		awful.key({mod, "Shift"}, "#" .. i + 9, function() 
			if client.focus then 
				local tag = client.focus.screen.tags[i] 
				if tag then 
					client.focus:move_to_tag(tag) 
				end 
			end 
        end)

    )
end


-- Mouse bindings on desktop
------------------------------
keys.desktopbuttons = gears.table.join(

    -- Left click
    awful.button({}, 1, function()
        naughty.destroy_all_notifications()
        if mymainmenu then
            mymainmenu:hide()
        end
    end),

    -- Right click
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end)

)


-- Mouse buttons on the client
--------------------------------
keys.clientbuttons = gears.table.join(

	-- Focus to client
    awful.button({}, 1, function(c)
		c:activate{context = "mouse_click"}
	end),

	-- Move client
    awful.button({mod}, 1, function(c)
		c:activate{context = "mouse_click", action = "mouse_move"}
	end),

	-- Resize client
    awful.button({mod}, 3, function(c)
		c:activate{contect = "mouse_click", action = "mouse_resize"}
    end)

)


-- Mouse buttons on the taglist
---------------------------------
keys.taglistbuttons = gears.table.join(

    -- Move to selected tag
	awful.button({'Any'}, 1, function(t) 
		t:view_only() 
        awesome.emit_signal("bling::tag_preview::visibility", s, false)
	end),

    -- Move focused client to selected tag
	awful.button({mod}, 1, function(t)
        if client.focus then 
			client.focus:move_to_tag(t) 
		end
    end), 

    -- Cycle through workspaces
	awful.button({'Any'}, 4, function(t)
        awful.tag.viewprev(t.screen)
    end), 
	awful.button({'Any'}, 5, function(t)
        awful.tag.viewnext(t.screen)
    end)

)


-- Mouse buttons on the tasklist
----------------------------------
keys.tasklistbuttons = gears.table.join(

    -- Left click
    awful.button({'Any'}, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
            c:emit_signal("request::activate", "tasklist", {raise = true})
		end
    end),

    -- Middle click
    awful.button({'Any'}, 2, nil, function(c) 
		c:kill() 
	end),

    -- Right click
    awful.button({'Any'}, 3, function (c) 
		c.minimized = not c.minimized 
	end),

    -- Scrolling
    awful.button({'Any'}, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({'Any'}, 5, function ()
        awful.client.focus.byidx(1)
    end)

)


-- Mouse buttons on the layoutbox
-----------------------------------
keys.layoutboxbuttons = gears.table.join(

    -- Left click
    awful.button({'Any'}, 1, function (c)
		awful.layout.inc(1)
    end),

    -- Right click
    awful.button({'Any'}, 3, function (c) 
		awful.layout.inc(-1) 
	end),

    -- Scrolling
    awful.button({'Any'}, 4, function ()
        awful.layout.inc(-1)
    end),
    awful.button({'Any'}, 5, function ()
        awful.layout.inc(1)
    end)

)


-- Mouse buttons on the titlebar
----------------------------------
keys.titlebarbuttons = gears.table.join(

    -- Left click
    awful.button({}, 1, function (c)
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.move(c)
    end),

    -- Middle click
    awful.button({}, 2, function (c) 
        local c = mouse.object_under_pointer()
        c:kill()
	end),

    -- Right click
    awful.button({}, 3, function ()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.resize(c)
    end)

)

-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
