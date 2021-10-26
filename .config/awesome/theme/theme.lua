-- Standard library
local gears = require("gears")
local gfs = require("gears.filesystem")

-- Theme library
local themes_path = gfs.get_themes_dir()
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local theme = dofile(themes_path .. "default/theme.lua")
-- local theme = {}

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
theme.wallpaper = "~/pictures/wallpapers/trees.jpg"

-- Icon theme
theme.icon_theme = nil

-- Fonts
theme.font_name = "MotoyaLMaru "
theme.icon_font_name = "SF Mono "
theme.font = theme.font_name .. "9"

-- Gaps and borders
theme.useless_gap = dpi(5)
theme.gap_single_client = true
theme.border_width = dpi(2)
theme.border_radius = dpi(0)
theme.border_color = theme.xforeground
theme.border_color_normal = theme.xforeground
theme.border_color_active = theme.xforeground
theme.border_color_marked = theme.xforeground

----------

-- backgrounds
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xbackground
theme.bg_urgent = theme.xbackground
theme.bg_minimize = theme.xbackground

-- foregrounds
theme.fg_normal = theme.xforeground
theme.fg_focus = theme.xforeground
theme.fg_urgent = theme.xforeground
theme.fg_minimize = theme.xforeground

----------

-- titlebar
theme.titlebars_enabled = true
theme.titlebar_bg_focus = theme.xcolor7
theme.titlebar_bg_normal = theme.xcolor7
theme.titlebar_size = dpi(30)
theme.titlebar_pos = "top"

-- bar
theme.wibar_pos = "bottom"
theme.wibar_width = dpi(900)
theme.wibar_height = dpi(40)
theme.wibar_margin = dpi(16)
theme.wibar_vmargin = dpi(10)
theme.wibar_border_radius = theme.border_radius
theme.wibar_border_width = theme.border_width
theme.wibar_border_color = theme.border_color_normal

-- taglist
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

theme.taglist_bg_focus = theme.xcolor0
theme.taglist_bg_empty = theme.transparent
theme.taglist_bg_occupied = theme.transparent

theme.taglist_fg_focus = theme.xcolor7
theme.taglist_fg_empty = theme.xcolor0
theme.taglist_fg_occupied = theme.xbackground

-- tasklist
theme.tasklist_align = "center"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.tasklist_border = dpi(0)
theme.tasklist_spacing = dpi(10)
theme.tasklist_bg_normal = theme.transparent
theme.tasklist_bg_focus = theme.transparent
theme.tasklist_bg_urgent = theme.transparent
theme.tasklist_bg_minimize = theme.transparent

theme.tasklist_fg_normal = theme.xforeground
theme.tasklist_fg_focus = theme.xcolor4
theme.tasklist_fg_urgent = theme.xcolor5
theme.tasklist_fg_minimize = theme.xforeground

-- Layoutbox
theme = theme_assets.recolor_layout(theme, theme.xforeground)

----------

-- tabbar
theme.tabbar_style = "modern"
theme.tabbar_position = "top"
theme.tabbar_size = 30
theme.tabbar_radius = theme.border_radius
theme.tabbar_bg_normal = theme.xcolor8
theme.tabbar_bg_focus = theme.xbackground

-- mstab
theme.mstab_bar_padding = dpi(0)

-- tag preview
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0
theme.tag_preview_client_border_color = theme.xcolor8
theme.tag_preview_client_border_width = dpi(2)
theme.tag_preview_widget_border_radius = theme.border_radius
theme.tag_preview_client_border_radius = theme.border_radius
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.border_color
theme.tag_preview_widget_border_width = dpi(0)
theme.tag_preview_widget_margin = dpi(10)

----------

-- menu
theme.menu_height = dpi(30) 
theme.menu_width = dpi(180) 
theme.menu_bg_normal = theme.xcolor7
theme.menu_fg_normal= theme.xbackground
theme.menu_bg_focus = theme.xbackground
theme.menu_fg_focus= theme.xcolor7
theme.menu_border_width = theme.border_width
theme.menu_border_color = theme.border_color_normal
theme.menu_submenu = "»  "
theme.menu_submenu_icon = nil

-- hotkey popup
theme.hotkeys_font = theme.font_name .. "11"
theme.hotkeys_description_font = theme.font_name .. "9"
theme.hotkeys_modifiers_fg = theme.xcolor4
theme.hotkeys_border_width = 2
theme.hotkeys_group_margin = 18
theme.hotkeys_border_color = theme.xbackground

-- notifications
theme.notification_font = theme.font_name .. "10"
theme.notification_fg = theme.xforeground
theme.notification_bg = theme.xbackground
theme.notification_crit_fg = theme.xcolor1
theme.notification_crit_bg = theme.xbackground
theme.notification_margin = dpi(16)
theme.notification_position = "top_right"
theme.notification_border_radius = theme.border_radius
theme.notification_border_width = theme.border_width
theme.notification_border_color = theme.border_color
theme.notification_icon_size = dpi(60)
-- theme.notification_width = dpi(260)
-- theme.notification_height = dpi(80)
-- theme.notification_max_width = dpi(260)

-- widget separator
theme.separator_text = "│"
theme.separator_fg = theme.xcolor8

return theme
