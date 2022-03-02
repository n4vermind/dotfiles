 local colors = require("colors").get()
local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity

local config = require("core.utils").load_config().plugins.options.statusline

-- show short statusline on small screens
local shortline = config.shortline == false and true

-- Initialize the components table
local components = {
   active = {},
}

local mode_colors = {
   ["n"] = { "NORMAL", colors.lightbg },
   ["no"] = { "N-PENDING", colors.lightbg },
   ["i"] = { "INSERT", colors.dark_purple },
   ["ic"] = { "INSERT", colors.dark_purple },
   ["t"] = { "TERMINAL", colors.green },
   ["v"] = { "VISUAL", colors.cyan },
   ["V"] = { "V-LINE", colors.cyan },
   [""] = { "V-BLOCK", colors.cyan },
   ["R"] = { "REPLACE", colors.orange },
   ["Rv"] = { "V-REPLACE", colors.orange },
   ["s"] = { "SELECT", colors.nord_blue },
   ["S"] = { "S-LINE", colors.nord_blue },
   [""] = { "S-BLOCK", colors.nord_blue },
   ["c"] = { "COMMAND", colors.pink },
   ["cv"] = { "COMMAND", colors.pink },
   ["ce"] = { "COMMAND", colors.pink },
   ["r"] = { "PROMPT", colors.teal },
   ["rm"] = { "MORE", colors.teal },
   ["r?"] = { "CONFIRM", colors.teal },
   ["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
   return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
   }
end

local vi_mode = {
   provider = function()
      return " " .. mode_colors[vim.fn.mode()][1] .. " "
   end,
   -- hl = chad_mode_hl,
   hl = {
      fg = colors.white,
      bg = colors.lightbg,
   },
}

local file_name2 = {
   provider = function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
         icon = " undefined "
         return icon
      end
      return " " .. filename .. " "
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = colors.white,
      bg = colors.lightbg,
   },

   -- right_sep = { str = statusline_style.right, hl = { fg = colors.lightbg, bg = colors.lightbg2 } },
}

local file_name = {
    provider = 'file_info',
    hl = {
        fg = colors.white,
        bg = colors.lightbg,
    },
    icon = ''
}

local file_type = {
    provider = 'file_type',
    left_sep = ' ',
    right_sep = ' ',
    hl = {
        fg = colors.white,
    }
}

local dir_name = {
   provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      -- return dir_name
      return " " .. dir_name .. " "
   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,

   hl = {
      fg = colors.grey_fg2,
      -- bg = colors.black,
   },
   -- right_sep = {
   --    str = statusline_style.right,
   --    hi = {
   --       fg = colors.lightbg2,
   --       bg = colors.statusline_bg,
   --    },
   -- },
}

local diff = {
   add = {
      provider = "git_diff_added",
      hl = {
         fg = colors.grey_fg2,
         -- bg = colors.statusline_bg,
      },
      icon = " +",
   },

   change = {
      provider = "git_diff_changed",
      hl = {
         fg = colors.grey_fg2,
         -- bg = colors.statusline_bg,
      },
      icon = " ~",
   },

   remove = {
      provider = "git_diff_removed",
      hl = {
         fg = colors.grey_fg2,
         -- bg = colors.statusline_bg,
      },
      icon = " -",
   },
}

local git_branch = {
   provider = "git_branch",
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = colors.grey_fg2,
      -- bg = colors.statusline_bg,
   },
   left_sep = ' ',
   right_sep = ' ',
   icon = "  ",
}

local diagnostic = {
   errors = {
      provider = "diagnostic_errors",
      enabled = function()
         return lsp.diagnostics_exist(lsp_severity.ERROR)
      end,

      hl = { fg = colors.red },
      icon = "  ",
   },

   warning = {
      provider = "diagnostic_warnings",
      enabled = function()
         return lsp.diagnostics_exist(lsp_severity.WARN)
      end,
      hl = { fg = colors.yellow },
      icon = "  ",
   },

   hint = {
      provider = "diagnostic_hints",
      enabled = function()
         return lsp.diagnostics_exist(lsp_severity.HINT)
      end,
      hl = { fg = colors.grey_fg2 },
      icon = "  ",
   },

   info = {
      provider = "diagnostic_info",
      enabled = function()
         return lsp.diagnostics_exist(lsp_severity.INFO)
      end,
      hl = { fg = colors.green },
      icon = "  ",
   },
}

local lsp_progress = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if Lsp then
         local msg = Lsp.message or ""
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or ""
         local spinners = {
            "",
            "",
            "",
         }

         local success_icon = {
            "",
            "",
            "",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
         end

         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return ""
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,
   hl = { fg = colors.green },
}

local lsp_icon = {
   provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
         return "  LSP"
      else
         return ""
      end
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

local empty_space = {
   provider = " ",
   hl = {
      bg = colors.black,
   },
}

local empty_space2 = {
   provider = " ",
   hl = {
      bg = colors.lightbg,
   },
}

-- this matches the vi mode color
local empty_spaceColored = {
   provider = " ",
   hl = function()
      return {
         bg = mode_colors[vim.fn.mode()][2],
      }
   end,
}

local current_line = {
   provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
         return " Top " .. vim.fn.line('.') .. ":" .. vim.fn.col('.')
      elseif current_line == vim.fn.line "$" then
         return " Bot " .. vim.fn.line('.') .. ":" .. vim.fn.col('.')
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% " .. vim.fn.line('.') .. ":" .. vim.fn.col('.')
   end,

   -- enabled = shortline or function(winid)
   --    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   -- end,

   hl = {
      fg = colors.white,
      -- bg = colors.one_bg,
   },
}

local function add_table(a, b)
   table.insert(a, b)
end

-- components are divided in 3 sections
local left = {}
local middle = {}
local right = {}

-- left
-- add_table(left, vi_mode)
-- add_table(left, empty_space)
add_table(left, file_name)
add_table(left, empty_space2)
add_table(left, dir_name)
add_table(left, empty_space)
-- add_table(left, diagnostic.error)
-- add_table(left, diagnostic.warning)
-- add_table(left, diagnostic.hint)
-- add_table(left, diagnostic.info)

-- add_table(middle, lsp_progress)

-- right
-- add_table(right, lsp_icon)
add_table(right, file_type)
add_table(right, diff.add)
add_table(right, diff.change)
add_table(right, diff.remove)
add_table(right, git_branch)
add_table(right, current_line)
add_table(right, empty_space)
add_table(right, empty_spaceColored)

components.active[1] = left
components.active[2] = middle
components.active[3] = right

require("feline").setup {
   theme = {
      bg = colors.black,
      fg = colors.fg,
   },
   components = components,
}

