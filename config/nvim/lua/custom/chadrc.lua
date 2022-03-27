local M = {}

local userPlugins = require "custom.plugins"

M.options = {
    shiftwidth = 4,
    tabstop = 4,
    -- showmode = false,
}

M.ui = {
   -- theme = "yami",
}

M.plugins = {
    status = {
        colorizer = true,
        alpha = true,
        better_escape = false,
    },

    default_plugin_config_replace = {
        feline = "custom.plugins.statusline",
        bufferline = "custom.plugins.bufferline",
    },

    install = userPlugins
}

return M
