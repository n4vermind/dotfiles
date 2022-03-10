-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")

-- Theme handling library
local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")
local theme_dir = gfs.get_configuration_dir() .. "theme/"
local titlebar_dir = theme_dir .. "assets/titlebar/"
local theme_assets = require("beautiful.theme_assets")
local xrdb = require("beautiful.xresources").get_current_theme()


-- Theme
----------

-- Load ~/.Xresources colors
theme.xbackground = xrdb.background
theme.xforeground = xrdb.foreground
theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15
theme.transparent = "#00000000"

----------

-- Wallpaper
theme.wallpaper = theme_dir .. "assets/wall.jpg"

-- Missing icon
theme.default_icon = theme_dir .. "assets/icons/window.png"

-- Icon theme
theme.icon_theme = nil

-- Fonts
theme.font_name = "Iosevka Nerd Font Mono "
theme.icon_font_name = "Material Icons "
theme.font = theme.font_name .. "9"

----------

-- Backgrounds
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xbackground
theme.bg_urgent = theme.xbackground
theme.bg_minimize = theme.xbackground
theme.bg_secondary = "#15181C"
theme.bg_accent = "#1C1E24"

-- Foregrounds
theme.fg_normal = theme.xforeground
theme.fg_focus = theme.xforeground
theme.fg_urgent = theme.xforeground
theme.fg_minimize = theme.xforeground

----------

-- Gaps and borders
theme.useless_gap = dpi(5)
theme.border_radius = dpi(0)
theme.border_outer_width = dpi(0)
theme.border_inner_width = dpi(3)
theme.border_outer_normal = theme.xbackground
theme.border_inner_normal = theme.xcolor0
theme.border_inner_focus = theme.xcolor8

theme.border_width = dpi(0)
theme.border_normal = theme.xcolor0
theme.border_focus  = theme.xcolor0
theme.border_marked = theme.xcolor0

theme.titlebar_enabled = true
theme.titlebar_font = theme.font_name .. "9"
theme.titlebar_size = dpi(35)
theme.titlebar_pos = "top"
theme.titlebar_bg_normal = theme.xbackground
theme.titlebar_bg_focus = theme.xbackground
theme.titlebar_fg_normal = theme.xforeground
theme.titlebar_fg_focus = theme.xforeground

theme.titlebar_close_button_normal = titlebar_dir .. "inactive.png"
theme.titlebar_close_button_focus  = titlebar_dir .. "close.png"

theme.titlebar_minimize_button_normal = titlebar_dir .. "inactive.png"
theme.titlebar_minimize_button_focus  = titlebar_dir .. "minimize.png"

theme.titlebar_ontop_button_normal_inactive = titlebar_dir .. "inactive.png"
theme.titlebar_ontop_button_focus_inactive  = titlebar_dir .. "ontop.png"
theme.titlebar_ontop_button_normal_active   = titlebar_dir .. "inactive.png"
theme.titlebar_ontop_button_focus_active    = titlebar_dir .. "ontop.png"

theme.titlebar_sticky_button_normal_inactive = titlebar_dir .. "inactive.png"
theme.titlebar_sticky_button_focus_inactive  = titlebar_dir .. "sticky.png"
theme.titlebar_sticky_button_normal_active   = titlebar_dir .. "inactive.png"
theme.titlebar_sticky_button_focus_active    = titlebar_dir .. "sticky.png"

theme.titlebar_floating_button_normal_inactive = titlebar_dir .. "inactive.png"
theme.titlebar_floating_button_focus_inactive  = titlebar_dir .. "floating.png"
theme.titlebar_floating_button_normal_active   = titlebar_dir .. "inactive.png"
theme.titlebar_floating_button_focus_active    = titlebar_dir .. "floating.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_dir .. "inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_dir .. "maximize.png"
theme.titlebar_maximized_button_normal_active   = titlebar_dir .. "inactive.png"
theme.titlebar_maximized_button_focus_active    = titlebar_dir .. "maximize.png"

----------

-- Wibar
theme.wibar_pos = "left"
-- theme.wibar_height = dpi(30)
theme.wibar_width = dpi(40)
theme.wibar_bg = theme.xbackground
theme.wibar_fg = theme.xforeground
theme.wibar_border_radius = dpi(0)
theme.wibar_border_width = dpi(0)
theme.wibar_border_color = theme.xcolor0

-- Tooltip
theme.tooltip_height = dpi(490)
theme.tooltip_width = dpi(310)
theme.tooltip_bg     = theme.xbackground
theme.tooltip_box_bg = theme.bg_secondary
theme.tooltip_fg     = theme.xforeground
theme.tooltip_box_fg = theme.xcolor8
theme.tooltip_margin = dpi(15)
theme.tooltip_box_margin = dpi(10)
theme.tooltip_gap = dpi(10)
theme.tooltip_border_radius = dpi(6)
theme.tooltip_box_border_radius = dpi(3)
theme.tooltip_border_width = dpi(0)
theme.tooltip_border_color = theme.xcolor0

-- Taglist
theme.taglist_font = "MotoyaLMaru 9"
theme.taglist_disable_icon = true

theme.taglist_bg_focus    = theme.xcolor4 .. "cc"
theme.taglist_bg_urgent   = theme.xcolor1 .. "cc"
theme.taglist_bg_occupied = theme.transparent
theme.taglist_bg_empty    = theme.transparent

theme.taglist_fg_focus    = theme.xforeground
theme.taglist_fg_urgent   = theme.xforeground
theme.taglist_fg_occupied = theme.xforeground
theme.taglist_fg_empty    = theme.xcolor8

theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

-- Tasklist
theme.tasklist_font = theme.font_name .. "9"
theme.tasklist_align = "center"
theme.tasklist_disable_icon = false
theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = true
theme.tasklist_border = dpi(0)
theme.tasklist_spacing = dpi(10)

theme.tasklist_bg_normal   = theme.transparent
theme.tasklist_bg_focus    = theme.bg_accent
theme.tasklist_bg_urgent   = theme.xcolor1
theme.tasklist_bg_minimize = theme.bg_secondary

theme.tasklist_fg_normal   = theme.xforeground
theme.tasklist_fg_focus    = theme.xforeground
theme.tasklist_fg_urgent   = theme.xforeground
theme.tasklist_fg_minimize = theme.xforeground

-- Pop up
theme.pop_size = dpi(180)
theme.pop_bg = theme.xbackground
theme.pop_bar_bg = theme.xcolor0
theme.pop_vol_color = theme.xcolor4
theme.pop_brightness_color = theme.xcolor3
theme.pop_fg = theme.xforeground
theme.pop_border_radius = dpi(6)

-- Prompt
theme.prompt_fg_cursor = theme.xcolor7
theme.prompt_bg_cursor = theme.xcolor8

-- Separator
theme.separator_color = theme.bg_accent

-- Layoutbox
theme = theme_assets.recolor_layout(theme, theme.xforeground)

----------

-- Tag preview
theme.tag_preview_client_opacity       = 0.5
theme.tag_preview_client_bg            = theme.xcolor0
theme.tag_preview_client_border_color  = theme.xcolor8
theme.tag_preview_client_border_width  = dpi(2)
theme.tag_preview_client_border_radius = dpi(2)

theme.tag_preview_widget_bg            = theme.xbackground
theme.tag_preview_widget_border_color  = theme.border_width
theme.tag_preview_widget_border_width  = dpi(0)
theme.tag_preview_widget_border_radius = theme.tag_preview_client_border_radius * 2
theme.tag_preview_widget_margin        = dpi(10)

-- Task preview
theme.task_preview_widget_bg = theme.xbackground
theme.task_preview_widget_margin = dpi(10)

theme.task_preview_widget_border_color = theme.xcolor0
theme.task_preview_widget_border_width = dpi(0)
theme.task_preview_widget_border_radius = dpi(2)

-- Window switcher
theme.thumbnail_scale = false

theme.window_switcher_widget_bg = theme.xbackground
theme.window_switcher_widget_border_width = dpi(0)
theme.window_switcher_widget_border_radius = dpi(0)
theme.window_switcher_widget_border_color = theme.xcolor0

theme.window_switcher_clients_spacing = dpi(30)
theme.window_switcher_client_icon_horizontal_spacing = dpi(5)
theme.window_switcher_client_width = dpi(150)
theme.window_switcher_client_height = dpi(250)
theme.window_switcher_client_margins = dpi(10)
theme.window_switcher_thumbnail_margins = dpi(10)

theme.window_switcher_name_margins = dpi(10)
theme.window_switcher_name_valign = "center"
theme.window_switcher_name_forced_width = dpi(200)
theme.window_switcher_name_font = theme.font_name .. "11"
theme.window_switcher_name_normal_color = theme.xforeground
theme.window_switcher_name_focus_color = theme.xcolor8

theme.window_switcher_icon_valign = "center"
theme.window_switcher_icon_width = dpi(30)

-- Playerctl
theme.playerctl_ignore  = {"firefox", "qutebrowser", "chromium", "brave"}
theme.playerctl_player  = {"spotify", "mpd", "%any"}
theme.playerctl_update_on_activity = true
theme.playerctl_position_update_interval = 1

----------

-- Mainmenu
theme.menu_font = theme.font_name .. "10"
theme.menu_height = dpi(30) 
theme.menu_width = dpi(150) 

theme.menu_bg_normal = theme.xbackground
theme.menu_bg_focus = theme.xbackground

theme.menu_fg_normal= theme.xforeground
theme.menu_fg_focus= theme.xcolor4

theme.menu_border_width = dpi(0)
theme.menu_border_color = theme.xcolor0

theme.menu_submenu = "»  "
theme.menu_submenu_icon = nil

-- Layout list
theme.layoutlist_bg_normal = theme.bg_normal
theme.layoutlist_bg_selected = theme.bg_secondary

-- Hotkey popup
theme.hotkeys_font = theme.font_name .. "11"
theme.hotkeys_description_font = theme.font_name .. "9"

theme.hotkeys_border_width = dpi(0)
theme.hotkeys_border_color = theme.xbackground

theme.hotkeys_group_margin = dpi(4)
theme.hotkeys_modifiers_fg = theme.xcolor4

-- Notifications
theme.notification_font = theme.font_name .. "11"
theme.notification_max_width = dpi(800)
theme.notification_max_height = dpi(240)
theme.notification_margin = dpi(10)
theme.notification_icon_size = dpi(40)

theme.notification_bg = theme.transparent
theme.notification_fg = theme.xforeground

theme.notification_border_width = dpi(0)
theme.notification_border_radius = dpi(7)
theme.notification_border_color = theme.xcolor0

return theme

