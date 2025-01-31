-- vim: tabstop=2 shiftwidth=2 expandtab

-- We almost always start by importing the wezterm module
local wezterm = require 'wezterm'
-- Define a lua table to hold _our_ module's functions
local module = {}

-- Returns a bool based on whether the host operating system's
-- appearance is light or dark.
function module.is_dark()
    -- it assume appearance is dark.
    -- return wezterm.gui.get_appearance():find("Dark")
  return true
end

return module
