# Load config.py settings
config.load_autoconfig(False)

# Startpage
# c.url.start_pages = "~/projects/web/startpage/index.html"
# c.url.default_page = "~/projects/web/startpage/index.html"

# Aliases for commands
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Editor
c.editor.command = ["urxvt", "-e", "nvim", "{}"]

# Always restore sites
c.auto_save.session = True

# Completion menu height
c.completion.height = "20%"

# Confirm quit if downloading
c.confirm_quit = ["downloads"]

config.load_autoconfig()

c.fonts.hints = '9pt Iosevka'
c.fonts.keyhint = '9pt Iosevka'
c.fonts.prompts = '9pt Iosevka'
c.fonts.downloads = '9pt Iosevka'
c.fonts.statusbar = '9pt Iosevka'
c.fonts.contextmenu = '9pt Iosevka'
c.fonts.messages.info = '9pt Iosevka'
c.fonts.debug_console = '9pt Iosevka'
c.fonts.tabs.selected = '9pt Iosevka'
c.fonts.tabs.unselected = '9pt Iosevka'
c.fonts.completion.entry = '9pt Iosevka'
c.fonts.completion.category = '9pt Iosevka'

c.colors.completion.category.bg                 = "#061115"
c.colors.completion.category.border.bottom      = "#061115"
c.colors.completion.category.border.top         = "#061115"
c.colors.completion.category.fg                 = "#d9d7d6"
c.colors.completion.even.bg                     = "#061115"
c.colors.completion.item.selected.bg            = "#061115"
c.colors.completion.item.selected.border.bottom = "#061115"
c.colors.completion.item.selected.border.top    = "#061115"
c.colors.completion.item.selected.fg            = "#d9d7d6"
c.colors.completion.match.fg                    = "#d9d7d6"
c.colors.completion.odd.bg                      = "#061115"
c.colors.completion.scrollbar.bg                = "#061115"
c.colors.completion.scrollbar.fg                = "#484e5b"

c.colors.downloads.bar.bg    = "#061115"
c.colors.downloads.error.bg  = "#df5b61"
c.colors.downloads.error.fg  = "#061115"
c.colors.downloads.start.bg  = "#bc83e3"
c.colors.downloads.start.fg  = "#061115"
c.colors.downloads.stop.bg   = "#6791c9"
c.colors.downloads.stop.fg   = "#061115"
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'none'

c.colors.hints.fg       = "#d9d7d6"
c.colors.hints.match.fg = "#969896"

c.colors.messages.error.bg       = "#df5b61"
c.colors.messages.error.border   = "#df5b61"
c.colors.messages.error.fg       = "#061115"
c.colors.messages.info.bg        = "#061115"
c.colors.messages.info.border    = "#061115"
c.colors.messages.info.fg        = "#d9d7d6"
c.colors.messages.warning.bg     = "#de8f78"
c.colors.messages.warning.border = "#de8f78"
c.colors.messages.warning.fg     = "#061115"

c.colors.prompts.bg          = "#061115"
c.colors.prompts.border      = '1px solid gray'
c.colors.prompts.fg          = "#d9d7d6"
c.colors.prompts.selected.bg = "#d9d7d6"

c.colors.statusbar.caret.bg             = "#67afc1"
c.colors.statusbar.caret.fg             = "#061115"
c.colors.statusbar.caret.selection.bg   = "#67afc1"
c.colors.statusbar.caret.selection.fg   = "#061115"
c.colors.statusbar.command.bg           = "#061115"
c.colors.statusbar.command.fg           = "#d9d7d6"
c.colors.statusbar.command.private.bg   = "#061115"
c.colors.statusbar.command.private.fg   = "#d9d7d6"
c.colors.statusbar.insert.bg            = "#bc83e3"
c.colors.statusbar.insert.fg            = "#061115"
c.colors.statusbar.normal.bg            = "#061115"
c.colors.statusbar.normal.fg            = "#d9d7d6"
c.colors.statusbar.passthrough.bg       = "#061115"
c.colors.statusbar.passthrough.fg       = "#6791c9"
c.colors.statusbar.private.bg           = '#061115'
c.colors.statusbar.private.fg           = "#d9d7d6"
c.colors.statusbar.progress.bg          = "#d9d7d6"
c.colors.statusbar.url.fg               = "#d9d7d6"
c.colors.statusbar.url.hover.fg         = "#6791c9"
c.colors.statusbar.url.success.https.fg = "#d9d7d6"
c.colors.statusbar.url.warn.fg          = "#df5b61"

c.colors.tabs.bar.bg           = "#1c252c"
c.colors.tabs.even.bg          = "#1c252c"
c.colors.tabs.even.fg          = "#d9d7d6"
c.colors.tabs.indicator.start  = "#de8f78"
c.colors.tabs.indicator.stop   = "#78b892" 
c.colors.tabs.indicator.error  = '#df5b61'
c.colors.tabs.odd.bg           = "#1c252c"
c.colors.tabs.odd.fg           = "#d9d7d6"
c.colors.tabs.selected.even.bg = "#061115"
c.colors.tabs.selected.even.fg = "#d9d7d6"
c.colors.tabs.selected.odd.bg  = "#061115"
c.colors.tabs.selected.odd.fg  = "#d9d7d6"

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.indicator.width = 0
c.tabs.padding = {"left": 10, "right": 10, "bottom": 5, "top": 5}
c.tabs.favicons.show = 'never'
c.tabs.show = 'multiple'
c.colors.hints.bg = '#061115'
c.colors.hints.fg = '#d9d7d6'
c.zoom.default = '100%'
