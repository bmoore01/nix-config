---@type ChadrcConfig
local M = {}

M.ui = { theme = 'gruvbox_light' }

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
end

return M
