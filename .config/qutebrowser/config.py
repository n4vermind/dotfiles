# Load config.py settings
config.load_autoconfig(False)

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

c.colors.completion.category.bg                 = "#131517"
c.colors.completion.category.border.bottom      = "#131517"
c.colors.completion.category.border.top         = "#131517"
c.colors.completion.category.fg                 = "#c5c8c6"
c.colors.completion.even.bg                     = "#131517"
c.colors.completion.item.selected.bg            = "#131517"
c.colors.completion.item.selected.border.bottom = "#131517"
c.colors.completion.item.selected.border.top    = "#131517"
c.colors.completion.item.selected.fg            = "#c5c8c6"
c.colors.completion.match.fg                    = "#c5c8c6"
c.colors.completion.odd.bg                      = "#131517"
c.colors.completion.scrollbar.bg                = "#131517"
c.colors.completion.scrollbar.fg                = "#969896"

c.colors.downloads.bar.bg    = "#131517"
c.colors.downloads.error.bg  = "#cc6666"
c.colors.downloads.error.fg  = "#131517"
c.colors.downloads.start.bg  = "#b294bb"
c.colors.downloads.start.fg  = "#131517"
c.colors.downloads.stop.bg   = "#81a2be"
c.colors.downloads.stop.fg   = "#131517"
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'none'

c.colors.hints.fg       = "#c5c8c6"
c.colors.hints.match.fg = "#969896"

c.colors.messages.error.bg       = "#cc6666"
c.colors.messages.error.border   = "#cc6666"
c.colors.messages.error.fg       = "#131517"
c.colors.messages.info.bg        = "#131517"
c.colors.messages.info.border    = "#131517"
c.colors.messages.info.fg        = "#c5c8c6"
c.colors.messages.warning.bg     = "#f0c674"
c.colors.messages.warning.border = "#f0c674"
c.colors.messages.warning.fg     = "#131517"

c.colors.prompts.bg          = "#131517"
c.colors.prompts.border      = '1px solid gray'
c.colors.prompts.fg          = "#c5c8c6"
c.colors.prompts.selected.bg = "#c5c8c6"

c.colors.statusbar.caret.bg             = "#8abeb7"
c.colors.statusbar.caret.fg             = "#131517"
c.colors.statusbar.caret.selection.bg   = "#8abeb7"
c.colors.statusbar.caret.selection.fg   = "#131517"
c.colors.statusbar.command.bg           = "#131517"
c.colors.statusbar.command.fg           = "#c5c8c6"
c.colors.statusbar.command.private.bg   = "#131517"
c.colors.statusbar.command.private.fg   = "#c5c8c6"
c.colors.statusbar.insert.bg            = "#b294bb"
c.colors.statusbar.insert.fg            = "#131517"
c.colors.statusbar.normal.bg            = "#131517"
c.colors.statusbar.normal.fg            = "#c5c8c6"
c.colors.statusbar.passthrough.bg       = "#131517"
c.colors.statusbar.passthrough.fg       = "#81a2be"
c.colors.statusbar.private.bg           = '#131517'
c.colors.statusbar.private.fg           = "#c5c8c6"
c.colors.statusbar.progress.bg          = "#c5c8c6"
c.colors.statusbar.url.fg               = "#c5c8c6"
c.colors.statusbar.url.hover.fg         = "#81a2be"
c.colors.statusbar.url.success.https.fg = "#c5c8c6"
c.colors.statusbar.url.warn.fg          = "#cc6666"

c.colors.tabs.bar.bg           = "#131517"
c.colors.tabs.even.bg          = "#c5c8c6"
c.colors.tabs.even.fg          = "#131517"
c.colors.tabs.indicator.start  = "#f0c674"
c.colors.tabs.indicator.stop   = "#b5bd68" 
c.colors.tabs.indicator.error  = '#cc6666'
c.colors.tabs.odd.bg           = "#c5c8c6"
c.colors.tabs.odd.fg           = "#131517"
c.colors.tabs.selected.even.bg = "#131517"
c.colors.tabs.selected.even.fg = "#c5c8c6"
c.colors.tabs.selected.odd.bg  = "#131517"
c.colors.tabs.selected.odd.fg  = "#c5c8c6"

# c.url.start_pages = "https://mcotocel.github.io/startpage/"

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.indicator.width = 0
c.tabs.padding = {"left": 10, "right": 10, "bottom": 5, "top": 5}
c.tabs.favicons.show = 'never'
c.tabs.show = 'multiple'
c.colors.hints.bg = '#131517'
c.colors.hints.fg = '#c5c8c6'
c.zoom.default = '100%'
