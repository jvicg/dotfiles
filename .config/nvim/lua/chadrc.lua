-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  hl_override = {
    Normal = { bg = "#21242a" },
    NormalNC = { bg = "#21242a" },
    -- NvimTreeNormal = { bg = "#16213e" },
  },
}

return M

