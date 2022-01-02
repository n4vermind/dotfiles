local wezterm = require 'wezterm';

return {
    font_dirs = {"/home/raven/.local/share/fonts"},
    front_end = "OpenGL",
    font = wezterm.font("Iosevka", {weight = "Regular", italic = false}),
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    font_size = 9,
    colors = {
        foreground = "#d9d7d6",
        background = "#061115",
        cursor_bg = "#d9d7d6",
        cursor_fg = "#d9d7d6",
        cursor_border = "#d9d7d6",
        selection_fg = "#061115",
        selection_bg = "#d9d7d6",
        scrollbar_thumb = "#d9d7d6",
        split = "#16161a",
        ansi    = {"#061115", "#df5b61", "#78b892", "#de8f78", "#6791c9", "#bc83e3", "#67afc1", "#d9d7d6"},
        brights = {"#484e5b", "#f16269", "#8cd7aa", "#e9967e", "#79aaeb", "#c488ec", "#7acfe4", "#e5e5e5"},
        indexed = {[136] = "#d9d7d6"},
    },
    window_padding = {
        left = 25,
        right = 25,
        top = 25,
        bottom = 25,
    },
    enable_tab_bar = false,
    exit_behavior = "CloseOnCleanExit"
}
