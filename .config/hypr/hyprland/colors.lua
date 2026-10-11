-- hyprland/colors.lua
-- Border and background colors

hl.config({
    general = {
        ["col.active_border"] = "rgba(908fa077)",
        ["col.inactive_border"] = "rgba(45465455)",
    },

    misc = {
        background_color = "rgba(12131bFF)",
    },
})

-- Pinned window rule
hl.window_rule({
    match = { pin = true },
    border_color = "rgba(bec2ffAA) rgba(bec2ff77)",
})
