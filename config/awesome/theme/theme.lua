-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")

-- Theme handling library
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local theme_assets = require("beautiful.theme_assets")
local theme_dir = gfs.get_configuration_dir() .. "theme/"
local titlebar_icon_dir = theme_dir .. "titlebar/"
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi


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
theme.wallpaper = theme_dir .. "wall.jpg"

-- Profile pic
theme.profile = theme_dir .. "profile.jpg"

-- Icon theme
theme.icon_theme = nil

-- Fonts
theme.font_name = "Iosevka "
theme.icon_font_name = "Material Icons "
theme.font = theme.font_name .. "8"

-- Gaps and borders
theme.useless_gap = dpi(5)
theme.border_width = dpi(0)
theme.border_radius = dpi(3)
theme.border_color = theme.xcolor0
theme.border_color_normal = theme.border_color
theme.border_color_active = theme.border_color
theme.border_color_marked = theme.border_color

----------

-- Backgrounds
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xbackground
theme.bg_urgent = theme.xbackground
theme.bg_minimize = theme.xbackground

-- Foregrounds
theme.fg_normal = theme.xforeground
theme.fg_focus = theme.xforeground
theme.fg_urgent = theme.xforeground
theme.fg_minimize = theme.xforeground

----------

-- Titlebar
theme.titlebars_enabled = true
theme.titlebar_bg_focus = "#0a1419"
theme.titlebar_bg_normal = "#0a1419"
theme.titlebar_fg_focus = theme.xbackground
theme.titlebar_fg_normal = theme.xbackground
theme.titlebar_size = dpi(30)
theme.titlebar_position = "left"

theme.titlebar_close_button_normal = titlebar_icon_dir .. "default.svg"
theme.titlebar_close_button_focus  = titlebar_icon_dir .. "close.svg"
theme.titlebar_minimize_button_normal = titlebar_icon_dir .. "default.svg"
theme.titlebar_minimize_button_focus  = titlebar_icon_dir .. "minimize.svg"
theme.titlebar_maximized_button_normal_inactive = titlebar_icon_dir .. "default.svg"
theme.titlebar_maximized_button_focus_inactive  = titlebar_icon_dir .. "maximized.svg"
theme.titlebar_maximized_button_normal_active = titlebar_icon_dir .. "default.svg"
theme.titlebar_maximized_button_focus_active  = titlebar_icon_dir .. "maximized.svg"

-- Wibar
theme.wibar_pos = "top"
theme.wibar_width = dpi(92)
theme.wibar_height = dpi(30)
theme.wibar_border_radius = theme.border_radius
theme.wibar_border_width = dpi(0)
theme.wibar_border_color = theme.border_color

-- Taglist
theme.taglist_font = theme.icon_font_name .. "11"

theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

theme.taglist_bg_focus = theme.xbackground
theme.taglist_bg_empty = theme.xbackground
theme.taglist_bg_occupied = theme.xbackground

theme.taglist_fg_focus = theme.xforeground
theme.taglist_fg_empty = theme.xcolor8
theme.taglist_fg_occupied = theme.xcolor8

-- Tasklist
theme.tasklist_align = "center"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = false
theme.tasklist_border = dpi(0)
theme.tasklist_spacing = dpi(10)

theme.tasklist_bg_normal = theme.xbackground
theme.tasklist_bg_focus = theme.xbackground
theme.tasklist_bg_urgent = theme.xbackground
theme.tasklist_bg_minimize = theme.xbackground

theme.tasklist_fg_normal = theme.xcolor8
theme.tasklist_fg_focus = theme.xforeground
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_fg_minimize = theme.xcolor0

-- Prompt
theme.prompt_fg_cursor = theme.xcolor7
theme.prompt_bg_cursor = theme.xcolor8

-- Dashboard
theme.dash_width = dpi(300)
theme.dash_box_bg = "#162026"
theme.dash_box_fg = "#666c79"

-- Layoutbox
theme = theme_assets.recolor_layout(theme, theme.xforeground)

----------

-- Tabbar
theme.tabbar_style = "modern"
theme.tabbar_position = "top"
theme.tabbar_size = 30
theme.tabbar_radius = theme.border_radius
theme.tabbar_bg_normal = theme.xcolor8
theme.tabbar_bg_focus = theme.xbackground

-- mstab
theme.mstab_bar_padding = dpi(0)

-- Tag preview
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0
theme.tag_preview_client_border_color = theme.xcolor8
theme.tag_preview_client_border_width = dpi(2)
theme.tag_preview_client_border_radius = dpi(2)

theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.border_color
theme.tag_preview_widget_border_width = theme.border_width
theme.tag_preview_widget_border_radius = theme.tag_preview_client_border_radius * 2
theme.tag_preview_widget_margin = dpi(10)

-- Window switcher
theme.window_switcher_widget_bg = theme.xbackground
theme.window_switcher_widget_border_width = theme.border_width
theme.window_switcher_widget_border_radius = theme.border_radius
theme.window_switcher_widget_border_color = theme.border_color

theme.window_switcher_clients_spacing = dpi(30)
theme.window_switcher_client_icon_horizontal_spacing = dpi(5)
theme.window_switcher_client_width = dpi(150)
theme.window_switcher_client_height = dpi(250)
theme.window_switcher_client_margins = dpi(10)

theme.window_switcher_thumbnail_margins = dpi(10)
theme.thumbnail_scale = false

theme.window_switcher_name_margins = dpi(10)
theme.window_switcher_name_valign = "center"
theme.window_switcher_name_forced_width = dpi(200)
theme.window_switcher_name_font = theme.font_name .. "9"
theme.window_switcher_name_normal_color = theme.xforeground
theme.window_switcher_name_focus_color = theme.xcolor8

theme.window_switcher_icon_valign = "center"
theme.window_switcher_icon_width = dpi(30)

----------

-- Mainmenu
theme.menu_font = theme.font_name .. "9"
theme.menu_height = dpi(30) 
theme.menu_width = dpi(150) 
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal= theme.xforeground
theme.menu_bg_focus = theme.xbackground
theme.menu_fg_focus= theme.xcolor4
theme.menu_border_width = theme.border_width
theme.menu_border_color = theme.border_color_normal
theme.menu_submenu = "»  "
theme.menu_submenu_icon = nil

-- Hotkey popup
theme.hotkeys_font = theme.font_name .. "11"
theme.hotkeys_description_font = theme.font_name .. "9"
theme.hotkeys_modifiers_fg = theme.xcolor4
theme.hotkeys_border_width = 2
theme.hotkeys_group_margin = 8
theme.hotkeys_border_color = theme.xbackground

-- Notifications
theme.notification_font = theme.font_name .. "10"
theme.notification_icon = theme_dir .. "icons/notification.png"
theme.notification_fg = theme.xforeground
theme.notification_bg = theme.xbackground
theme.notification_margin = dpi(16)
theme.notification_border_width = dpi(0)
theme.notification_border_color = theme.transparent

return theme
