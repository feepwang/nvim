local M = {}

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- initialize
function M.init()
  require("config.options")
  require("config.settings")
  require("config.lazy")
end

return M
