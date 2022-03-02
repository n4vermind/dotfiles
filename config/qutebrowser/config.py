# Load config.py settings
config.load_autoconfig(False)

# Startpage
# c.url.start_pages = "~/projects/web/startpage/index.html"
# c.url.default_page = "~/projects/web/startpage/index.html"

# Aliases for commands
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Editor
c.editor.command = ["alacritty", "-e", "nvim", "{}"]

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

c.colors.completion.category.bg                 = "#101317"
c.colors.completion.category.border.bottom      = "#101317"
c.colors.completion.category.border.top         = "#101317"
c.colors.completion.category.fg                 = "#d4d4d5"
c.colors.completion.even.bg                     = "#101317"
c.colors.completion.item.selected.bg            = "#101317"
c.colors.completion.item.selected.border.bottom = "#101317"
c.colors.completion.item.selected.border.top    = "#101317"
c.colors.completion.item.selected.fg            = "#d4d4d5"
c.colors.completion.match.fg                    = "#d4d4d5"
c.colors.completion.odd.bg                      = "#101317"
c.colors.completion.scrollbar.bg                = "#101317"
c.colors.completion.scrollbar.fg                = "#949494"

c.colors.downloads.bar.bg    = "#101317"
c.colors.downloads.error.bg  = "#f87070"
c.colors.downloads.error.fg  = "#101317"
c.colors.downloads.start.bg  = "#c397d8"
c.colors.downloads.start.fg  = "#101317"
c.colors.downloads.stop.bg   = "#7ab0df"
c.colors.downloads.stop.fg   = "#101317"
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'none'

c.colors.hints.fg       = "#d4d4d5"
c.colors.hints.match.fg = "#949494"

c.colors.messages.error.bg       = "#f87070"
c.colors.messages.error.border   = "#f87070"
c.colors.messages.error.fg       = "#101317"
c.colors.messages.info.bg        = "#101317"
c.colors.messages.info.border    = "#101317"
c.colors.messages.info.fg        = "#d4d4d5"
c.colors.messages.warning.bg     = "#ffe59e"
c.colors.messages.warning.border = "#ffe59e"
c.colors.messages.warning.fg     = "#101317"

c.colors.prompts.bg          = "#101317"
c.colors.prompts.border      = '1px solid gray'
c.colors.prompts.fg          = "#d4d4d5"
c.colors.prompts.selected.bg = "#d4d4d5"

c.colors.statusbar.caret.bg             = "#70c0ba"
c.colors.statusbar.caret.fg             = "#101317"
c.colors.statusbar.caret.selection.bg   = "#70c0ba"
c.colors.statusbar.caret.selection.fg   = "#101317"
c.colors.statusbar.command.bg           = "#101317"
c.colors.statusbar.command.fg           = "#d4d4d5"
c.colors.statusbar.command.private.bg   = "#101317"
c.colors.statusbar.command.private.fg   = "#d4d4d5"
c.colors.statusbar.insert.bg            = "#c397d8"
c.colors.statusbar.insert.fg            = "#101317"
c.colors.statusbar.normal.bg            = "#101317"
c.colors.statusbar.normal.fg            = "#d4d4d5"
c.colors.statusbar.passthrough.bg       = "#101317"
c.colors.statusbar.passthrough.fg       = "#7ab0df"
c.colors.statusbar.private.bg           = '#101317'
c.colors.statusbar.private.fg           = "#d4d4d5"
c.colors.statusbar.progress.bg          = "#d4d4d5"
c.colors.statusbar.url.fg               = "#d4d4d5"
c.colors.statusbar.url.hover.fg         = "#7ab0df"
c.colors.statusbar.url.success.https.fg = "#d4d4d5"
c.colors.statusbar.url.warn.fg          = "#f87070"

c.colors.tabs.bar.bg           = "#23242A"
c.colors.tabs.even.bg          = "#23242A"
c.colors.tabs.even.fg          = "#d4d4d5"
c.colors.tabs.indicator.start  = "#ffe59e"
c.colors.tabs.indicator.stop   = "#79dcaa" 
c.colors.tabs.indicator.error  = '#f87070'
c.colors.tabs.odd.bg           = "#23242A"
c.colors.tabs.odd.fg           = "#d4d4d5"
c.colors.tabs.selected.even.bg = "#101317"
c.colors.tabs.selected.even.fg = "#d4d4d5"
c.colors.tabs.selected.odd.bg  = "#101317"
c.colors.tabs.selected.odd.fg  = "#d4d4d5"

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.indicator.width = 0
c.tabs.padding = {"left": 10, "right": 10, "bottom": 5, "top": 5}
c.tabs.favicons.show = 'never'
c.tabs.show = 'multiple'
c.colors.hints.bg = '#101317'
c.colors.hints.fg = '#d4d4d5'
c.zoom.default = '100%'
