-- hyprland/lib.lua
-- Core Hyprland Lua API wrapper and helper functions

local M = {}

-- Dispatch helper
M.dispatch = function(cmd, args)
    hl.dsp.dispatcher(cmd, args or "")
end

-- Execute command helper
M.exec = function(cmd)
    hl.dsp.exec_cmd(cmd)
end

-- Notification helper
M.notify = function(title, message)
    M.exec("notify-send '" .. title .. "' '" .. message .. "'")
end

-- Monitor dimension helpers
M.monitor_width = function()
    return "monitor_w"
end

M.monitor_height = function()
    return "monitor_h"
end

return M
