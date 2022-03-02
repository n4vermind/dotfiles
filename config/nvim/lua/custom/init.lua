local map = require("core.utils").map

-- Indent control
map("v", "<S-Tab>", "<gv", opt)
map("v", "<TAB>", ">gv", opt)

-- Move buffer
map("n", ">", ":BufferLineMoveNext <CR>", opt)
map("n", "<", ":BufferLineMovePrev <CR>", opt)

-- Buffer pick
map("n", "<leader>bp", ":BufferLinePick <CR>", opt)
