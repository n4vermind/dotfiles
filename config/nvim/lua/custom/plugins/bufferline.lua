local colors = require("colors").get()

local present, bufferline = pcall(require, "bufferline")
if not present then
   return
end

bufferline.setup {
   options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      -- buffer_close_icon = "",
      modified_icon = " ",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 10,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = false,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false,
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            end
            return true
         end

         return true
      end,
   },

   highlights = {
      background = {
         guifg = colors.grey_fg,
         guibg = colors.black,
      },

      -- buffers
      buffer_selected = {
         guifg = colors.white,
         guibg = colors.black2,
         gui = "bold",
      },
      buffer_visible = {
         guifg = colors.light_grey,
         guibg = colors.black,
      },

      -- for diagnostics = "nvim_lsp"
      error = {
         guifg = colors.light_grey,
         guibg = colors.black,
      },
      error_diagnostic = {
         guifg = colors.light_grey,
         guibg = colors.black,
      },

      -- close buttons
      close_button = {
         guifg = colors.light_grey,
         guibg = colors.black,
      },
      close_button_visible = {
         guifg = colors.light_grey,
         guibg = colors.black,
      },
      close_button_selected = {
         guifg = colors.red,
         guibg = colors.black2,
      },
      fill = {
         guifg = colors.grey_fg,
         guibg = colors.black,
      },
      indicator_selected = {
         guifg = colors.black,
         guibg = colors.black2,
      },

      -- modified
      modified = {
         guifg = colors.red,
         guibg = colors.black,
      },
      modified_visible = {
         guifg = colors.red,
         guibg = colors.black2,
      },
      modified_selected = {
         guifg = colors.green,
         guibg = colors.black2,
      },

      -- separators
      separator = {
         guifg = colors.black2,
         guibg = colors.black,
      },
      separator_visible = {
         guifg = colors.black2,
         guibg = colors.black,
      },
      separator_selected = {
         guifg = colors.black2,
         guibg = colors.black,
      },

      -- tabs
      tab = {
         guifg = colors.light_grey,
         guibg = colors.one_bg3,
      },
      tab_selected = {
         guifg = colors.black2,
         guibg = colors.nord_blue,
      },
      tab_close = {
         guifg = colors.red,
         guibg = colors.black,
      },
   },
}

