-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification handling library
local naughty = require("naughty")

-- Ruled
local ruled = require("ruled")

-- Helpers
local helpers = require("helpers")

-- Keys
local keys = require("main.keys")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


-- Rules
----------

ruled.client.connect_signal("request::rules", function()

    -- Global
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            size_hints_honor = false,
            titlebars_enabled = beautiful.titlebar_enabled,
            placement = helpers.floating_client_placement
        }
    }

    -- Float
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {
                "Devtools", -- Firefox devtools
            },
            class = {
                "Lxappearance",
                "Nm-connection-editor",
            },
            name = {
                "Event Tester",  -- xev
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileChooserDialog",
                "conversation",
            },
            type = {
                "dialog",
            }
        },
        properties = { floating = true }
    }

    -- Centered
    ruled.client.append_rule {
        id = "centered",
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                -- "discord",
            },
            role = {
                "GtkFileChooserDialog",
                "conversation",
            }
        },
        properties = { placement = helpers.centered_client_placement },
    }

    -- Titlebar off
    ruled.client.append_rule {
        id = "titlebar_off",
        rule_any = {
            class = {
                "qutebrowser",
                "Brave",
                "discord",
                "whatsapp-for-linux",
                "TelegramDesktop",
                "firefox",
                "Spotify",
                "figma-linux"
            },
            type = {
              "splash"
            },
            name = {
                "^discord.com is sharing your screen.$" -- Discord (running in browser) screen sharing popup
            }
        },
        callback = function(c)
            awful.titlebar.hide(c, beautiful.titlebar_position)
        end
    }

    -- Titlebar on 
    ruled.client.append_rule {
        id = "titlebar_on",
        rule_any = {
            type = {
                "dialog",
            },
            role = {
                "conversation",
            }
        },
        callback = function(c)
            awful.titlebar.show(c, beautiful.titlebar_position)
        end
    }

    -- Fixed terminal geometry for floating terminals
    -- ruled.client.append_rule {
    --     rule_any = {
    --         class = {
    --             "Alacritty",
    --             "mpvtube",
    --             "kitty",
    --             "st-256color",
    --             "st",
    --             "URxvt",
    --         },
    --     },
    --     properties = { width = screen_width * 0.45, height = screen_height * 0.5 }
    -- }

    ruled.client.append_rule {
        -- File chooser dialog
        rule_any = {role = {"GtkFileChooserDialog"}},
        properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.65}
    }

    ruled.client.append_rule {
        -- Pavucontrol
        rule_any = {class = {"Pavucontrol"}},
        properties = {floating = true, width = screen_width * 0.4, height = screen_height * 0.8}
    }

    ruled.client.append_rule {
        -- File managers
        rule_any = {class = {"Thunar"}},
        except_any = {type = {"dialog"}},
        properties = {floating = true, width = screen_width * 0.45, height = screen_height * 0.55}
    }

    ruled.client.append_rule {
        -- Music clients (usually a terminal running ncmpcpp)
        rule_any = {class = {"music"}, instance = {"music"}},
        properties = {floating = true, width = screen_width * 0.26, height = screen_height * 0.35}
    }

    -- Image viewers
    ruled.client.append_rule {
        rule_any = {
            class = {
                "feh",
                "imv"
            }
        },
        properties = {
            floating = true,
            width = screen_width * 0.7,
            height = screen_height * 0.75
        },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    }

    -- Mpv
    ruled.client.append_rule {
        rule = { class = "mpv" },
        properties = {},
        callback = function (c)
            -- make it floating, ontop and move it out of the way if the current tag is maximized
            if awful.layout.get(awful.screen.focused()) == awful.layout.suit.floating then
                c.floating = true
                c.ontop = true
                c.width = screen_width * 0.30
                c.height = screen_height * 0.35
                awful.placement.bottom_right(c, {
                    honor_padding = true,
                    honor_workarea = true,
                    margins = { bottom = beautiful.useless_gap * 2, right = beautiful.useless_gap * 2 }
                })
                awful.titlebar.hide(c, beautiful.titlebar_pos)
            end

            -- restore `ontop` after fullscreen is disabled
            c:connect_signal("property::fullscreen", function ()
                if not c.fullscreen then
                    c.ontop = true
                end
            end)
        end
    }
end)

ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule {
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        },
    }
end)

