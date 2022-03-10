-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme handling library
local beautiful = require("beautiful")

-- Notifications library
local naughty = require("naughty")

-- Bling
local bling = require("lib.bling")
local playerctl = bling.signal.playerctl.lib()

-- Helpers
local helpers = require("helpers")


-- Make key easier to call
----------------------------

mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"


-- Global key bindings
------------------------

awful.keyboard.append_global_keybindings({

---- App

    -- Terminal
    awful.key({mod}, "Return", function()
        awful.spawn(terminal)
    end,
    {description = "Spawn terminal", group = "App"}),

    -- Launcher
    awful.key({mod}, "a", function()
        awful.spawn(launcher)
    end,
    {description = "Spawn launcher", group = "App"}),

    -- Hotkeys menu
    awful.key({mod}, "\\",
        hotkeys_popup.show_help,
    {description = "Hotkeys menu", group = "App"}),


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
        wibar_toggle()
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

    -- Un-minimize windows
    awful.key({mod, shift}, "n", function()
        local c = awful.client.restore()
        if c then
            c:activate{raise = true, context = "key.unminimize"}
        end
    end),


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

    -- Keyboard backlight (i'm using macbook)
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
        helpers.volume_control(0)
    end,
    {description = "Toggle volume", group = "Misc"}),

    awful.key({}, "XF86AudioLowerVolume", function()
        helpers.volume_control(-2)
    end,
    {description = "Lower volume", group = "Misc"}),

    awful.key({}, "XF86AudioRaiseVolume", function()
        helpers.volume_control(2)
    end,
    {description = "Raise volume", group = "Misc"}),

    -- Music
    awful.key({}, "XF86AudioPlay", function()
        playerctl:play_pause()
    end,
    {description = "Toggle music", group = "Misc"}),

    awful.key({}, "XF86AudioPrev", function()
        playerctl:previous()
    end,
    {description = "Previous music", group = "Misc"}),

    awful.key({}, "XF86AudioNext", function()
        playerctl:next()
    end,
    {description = "Next music", group = "Misc"}),

    -- Screenshot
    awful.key({mod}, "/", function()
        awful.spawn.with_shell("screensht")
    end,
    {description = "Take screenshot", group = "Misc"}),

    -- Window switcher
    awful.key({mod}, "Tab", function()
        awesome.emit_signal("bling::window_switcher::turn_on")
    end,
    {description = "Window switcher", group = "Misc"}),

})


-- Client key bindings
------------------------

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
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
        awful.key({mod, ctrl}, " ",
            awful.client.floating.toggle
        ),

        awful.key({}, "XF86LaunchA",
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
    })
end)


-- Move through workspaces
----------------------------

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = { mod },
        keygroup = "numrow",
        description = "Only view tag",
        group = "Tag",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { mod, ctrl },
        keygroup = "numrow",
        description = "Toggle tag",
        group = "Tags",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { mod, shift },
        keygroup = "numrow",
        description = "Move focused client to tag",
        group = "Tags",
        on_press = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }
})


-- Mouse bindings on desktop
------------------------------

awful.mouse.append_global_mousebindings({

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
    end),

    -- Side key
    awful.button({}, 8, awful.tag.viewprev),
    awful.button({}, 9, awful.tag.viewnext)

})


-- Mouse buttons on the client
--------------------------------

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({mod}, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({mod}, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

