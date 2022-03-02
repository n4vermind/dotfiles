-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")


-- Menu
-------------

awful.screen.connect_for_each_screen(function(s)

    -- Submenu
    awesomemenu = {
        {"Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
        {"Edit Config", editor .. awesome.conffile},
        {"Reload", awesome.restart},
    }

    -- Mainmenu
    mymainmenu = awful.menu({
        items = {
            {"Terminal", function() awful.spawn.with_shell(terminal) end},
            {"Browser", function() awful.spawn.with_shell(browser) end},
            {"Music", function() awful.spawn.with_shell(music_client) end},
            {"File manager", function() awful.spawn.with_shell(file_manager) end},
            {"Awesome", awesomemenu},
            {"Quit", function() awesome.quit() end}
        }
    })

end)

