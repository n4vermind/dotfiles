-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.options = {
    shiftwidth = 4,
    tabstop = 4,
    -- showmode = false,
}

M.ui = {
   theme = "tomorrow-night",
}

M.plugins = {
    status = {
        colorizer = true,
        dashboard = true,
        better_escape = false,
    },
}

return M
