-- hyprland/services.lua
-- Background services and daemon management

-- This module can be extended to manage quickshell IPC calls
-- and other service integrations

local M = {}

M.quickshell_ipc = function(call)
    local qsConfig = os.getenv("qsConfig") or "ii"
    return "qs -c " .. qsConfig .. " ipc call " .. call
end

return M
