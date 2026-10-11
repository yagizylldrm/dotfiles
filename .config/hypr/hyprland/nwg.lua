-- Translate nwg-displays' generated Hyprland files to the Lua config API.

local HOME = os.getenv("HOME")

local function trim(value)
    return value:match("^%s*(.-)%s*$")
end

local function fields(value)
    local result = {}
    for field in value:gmatch("[^,]+") do
        result[#result + 1] = trim(field)
    end
    return result
end

local function generated_lines(path, apply)
    local file = io.open(path, "r")
    if not file then
        return
    end

    local line_number = 0
    for line in file:lines() do
        line_number = line_number + 1
        local directive = trim(line)
        if directive ~= "" and directive:sub(1, 1) ~= "#" then
            local ok, err = pcall(apply, directive)
            if not ok then
                file:close()
                error(string.format("%s:%d: %s", path, line_number, err), 0)
            end
        end
    end
    file:close()
end

local monitors = HOME .. "/.config/hypr/monitors.conf"
generated_lines(monitors, function(line)
    local value = line:match("^monitor%s*=%s*(.+)$")
    if not value then
        error("unsupported nwg-displays directive: " .. line, 0)
    end

    local spec = fields(value)
    if #spec ~= 4 then
        error("expected monitor=output,mode,position,scale", 0)
    end

    hl.monitor({
        output = spec[1],
        mode = spec[2],
        position = spec[3],
        scale = tonumber(spec[4]) or spec[4],
    })
end)

local workspace_fields = {
    animation = "animation",
    bordersize = "border_size",
    decorate = "decorate",
    default = "default",
    defaultname = "default_name",
    floatgaps = "float_gaps",
    gapsin = "gaps_in",
    gapsout = "gaps_out",
    layout = "layout",
    monitor = "monitor",
    noborder = "no_border",
    norounding = "no_rounding",
    noshadow = "no_shadow",
    oncreatedempty = "on_created_empty",
    persistent = "persistent",
}

local function typed(value)
    if value == "true" then
        return true
    elseif value == "false" then
        return false
    end
    return tonumber(value) or value
end

local workspaces = HOME .. "/.config/hypr/workspaces.conf"
generated_lines(workspaces, function(line)
    local value = line:match("^workspace%s*=%s*(.+)$")
    if not value then
        error("unsupported nwg-displays directive: " .. line, 0)
    end

    local parts = fields(value)
    local rule = { workspace = parts[1] }
    if not rule.workspace then
        error("workspace selector is missing", 0)
    end

    for index = 2, #parts do
        local key, item = parts[index]:match("^([%w_-]+)%s*:%s*(.+)$")
        local normalized = key and key:gsub("[_-]", ""):lower()
        local lua_key = normalized and workspace_fields[normalized]
        if not lua_key then
            error("unsupported workspace field: " .. parts[index], 0)
        end
        rule[lua_key] = typed(trim(item))
    end

    hl.workspace_rule(rule)
end)
