-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Helpers
local helpers = require("misc.helpers")

-- Keys
local keys = require("main.keys")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


-- Rules
----------

awful.rules.rules = {
    {
        -- Global rules
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            maximized = false,
            titlebars_enabled = beautiful.titlebars_enabled,
            placement = helpers.floating_client_placement
        }
    },

    {
        -- Flying
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
        properties = {floating = true}
    },

    {
        -- Centered
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
        properties = {placement = helpers.centered_client_placement},
    },

    {
        -- Titlebar off
        rule_any = {
            class = {
                "qutebrowser",
                "Brave",
                "discord",
                "whatsapp-for-linux",
                "TelegramDesktop",
                "firefox",
                "Spotify"
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
    },

    {
        -- Titlebar on 
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
    },

    {
        -- Fixed terminal geometry for floating terminals
        rule_any = {
            class = {
                "Alacritty",
                "mpvtube",
                "kitty",
                "st-256color",
                "st",
                "URxvt",
            },
        },
        properties = {width = screen_width * 0.45, height = screen_height * 0.5}
    },

    {
        -- File chooser dialog
        rule_any = {role = {"GtkFileChooserDialog"}},
        properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.65}
    },

    {
        -- Pavucontrol
        rule_any = {class = {"Pavucontrol"}},
        properties = {floating = true, width = screen_width * 0.45, height = screen_height * 0.8}
    },

    {
        -- File managers
        rule_any = {class = {"Thunar"}},
        except_any = {type = {"dialog"}},
        properties = {floating = true, width = screen_width * 0.45, height = screen_height * 0.55}
    },

    {
        -- Music clients (usually a terminal running ncmpcpp)
        rule_any = {class = {"music"}, instance = {"music"}},
        properties = {floating = true, width = screen_width * 0.26, height = screen_height * 0.4}
    },

    {
        -- Image viewers
        rule_any = {
            class = {
                "feh",
                "imv"
            },
        },
        properties = {
            floating = true,
            width = screen_width * 0.7,
            height = screen_height * 0.75
        },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    {
        -- Mpv
        rule = {class = "mpv"},
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
                    margins = {bottom = beautiful.useless_gap * 2, right = beautiful.useless_gap * 2}
                })
                awful.titlebar.hide(c, beautiful.titlebar_position)
            end

            -- restore `ontop` after fullscreen is disabled
            c:connect_signal("property::fullscreen", function ()
                if not c.fullscreen then
                    c.ontop = true
                end
            end)
        end
    },


    {
        -- Browser
        rule_any = {
            class = {
                "firefox",
                "Brave",
                "qutebrowser",
            },
        },
        except_any = {
            role = {"GtkFileChooserDialog"},
            instance = {"Toolkit"},
            type = {"dialog"}
        },
        properties = {screen = 1, tag = awful.screen.focused().tags[2]},
    },

    {
        -- Chatting
        rule_any = {
            class = {
                -- "discord",
                "TelegramDesktop",
                "Slack",
                "zoom",
                "weechat",
            },
        },
        properties = {screen = 1, tag = awful.screen.focused().tags[4]}
    },

    {
        -- Image editing
        rule_any = {
            class = {
                "Gimp",
                "Inkscape",
            },
        },
        properties = {screen = 1, tag = awful.screen.focused().tags[5]}
    }
}
