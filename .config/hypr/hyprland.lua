-- This file sources other files in `hyprland` and `custom` folders
-- You wanna add your stuff in files in `custom`

require("hyprland.lib")

local HOME = os.getenv("HOME")

-- Helper function to check if file exists
local function is_file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Variables
require("hyprland.variables")
if is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
    require("custom.variables")
end

-- Environment variables
require("hyprland.env")
if is_file_exists(HOME .. "/.config/hypr/custom/env.lua") then
    require("custom.env")
end

-- Startup executables
require("hyprland.execs")
if is_file_exists(HOME .. "/.config/hypr/custom/execs.lua") then
    require("custom.execs")
end

-- General settings (decorations, animations, input)
require("hyprland.general")
if is_file_exists(HOME .. "/.config/hypr/custom/general.lua") then
    require("custom.general")
end

-- Window and layer rules
require("hyprland.rules")
if is_file_exists(HOME .. "/.config/hypr/custom/rules.lua") then
    require("custom.rules")
end

-- Colors and borders
require("hyprland.colors")

-- Keybindings
require("hyprland.keybinds")
if is_file_exists(HOME .. "/.config/hypr/custom/keybinds.lua") then
    require("custom.keybinds")
end

-- nwg-displays support
require("hyprland.nwg")

-- Shell overrides
require("hyprland.shellOverrides.main")
