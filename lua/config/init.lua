local M = {}

-- basic environment
if vim.env.VSCODE then
  vim.g.vscode = true
end

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

  if vim.g.vscode then
    vim.notify = require("vscode-neovim").notify
  end
end

return M
