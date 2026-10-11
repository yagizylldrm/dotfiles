-- hyprland/rules.lua
-- Window, layer, and workspace rules

-- Disable blur for xwayland context menus and all windows
hl.window_rule({ match = { class = "^()$", title = "^()$" }, no_blur = true })
hl.window_rule({ match = { class = ".*" }, no_blur = true })

-- Helper for common dialog window rules (centered and floating)
local function dialog_rule(pattern, size_w, size_h)
    local rule = {
        match = { title = pattern },
        float = true,
        center = true,
    }
    if size_w and size_h then
        rule.size = string.format("(monitor_w*%s) (monitor_h*%s)", size_w, size_h)
    end
    hl.window_rule(rule)
end

-- Common file dialogs
dialog_rule("^(Open File)(.*)$")
dialog_rule("^(Select a File)(.*)$")
dialog_rule("^(Choose wallpaper)(.*)$", "0.60", "0.65")
dialog_rule("^(Open Folder)(.*)$")
dialog_rule("^(Save As)(.*)$")
dialog_rule("^(Library)(.*)$")
dialog_rule("^(File Upload)(.*)$")
dialog_rule("^(.*)(wants to save)$")
dialog_rule("^(.*)(wants to open)$")

-- Class-based floating dialogs
local class_dialogs = {
    { class = "^(blueberry\\.py)$", float = true },
    { class = "^(guifetch)$", float = true },
    { class = "^(pavucontrol)$", float = true, size = "(monitor_w*0.45) (monitor_h*0.45)", center = true },
    { class = "^(org\\.pulseaudio\\.pavucontrol)$", float = true, size = "(monitor_w*0.45) (monitor_h*0.45)", center = true },
    { class = "^(nm-connection-editor)$", float = true, size = "(monitor_w*0.45) (monitor_h*0.45)", center = true },
    { class = ".*plasmawindowed.*", float = true },
    { class = "kcm_.*", float = true },
    { class = ".*bluedevilwizard", float = true },
    { class = "org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde", float = true, size = "(monitor_w*0.60) (monitor_h*0.65)" },
    { class = "^(Zotero)$", float = true, size = "(monitor_w*0.45) (monitor_h*0.45)" },
}

for _, r in ipairs(class_dialogs) do
    hl.window_rule({
        match = { class = r.class },
        float = r.float,
        size = r.size,
        center = r.center,
    })
end

-- Title-based floating dialogs
local title_dialogs = {
    ".*Welcome",
    "^(illogical-impulse Settings)$",
    ".*Shell conflicts.*",
}

for _, title in ipairs(title_dialogs) do
    hl.window_rule({ match = { title = title }, float = true })
end

-- Move rules
hl.window_rule({
    match = { class = "^(plasma-changeicons)$" },
    float = true,
    no_initial_focus = true,
    move = "999999 999999",
})

hl.window_rule({
    match = { title = "^(Copying — Dolphin)$" },
    move = "40 80",
})

-- Tiling rules
hl.window_rule({ match = { class = "^dev\\.warp\\.Warp$" }, tile = true })

-- Picture-in-Picture
hl.window_rule({
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float = true,
    keep_aspect_ratio = true,
    move = "(monitor_w*0.73) (monitor_h*0.72)",
    size = "(monitor_w*0.25) (monitor_h*0.25)",
    pin = true,
})

-- Tearing (immediate) for games and wine
hl.window_rule({ match = { title = ".*\\.exe" }, immediate = true })
hl.window_rule({ match = { title = ".*minecraft.*" }, immediate = true })
hl.window_rule({ match = { class = "^(steam_app).*" }, immediate = true })

-- JetBrains IDEs fix
hl.window_rule({
    match = { class = "^jetbrains-.*$", float = true, title = "^$|^\\s$|^win\\d+$" },
    no_initial_focus = true,
})

-- No shadow for tiled windows
hl.window_rule({ match = { float = false }, no_shadow = true })

-- Workspace rules
hl.workspace_rule({ workspace = "special:special", gaps_out = 30 })

-- Layer rules (helper function for deduplication)
local function apply_layer_rules(namespaces, rules)
    for _, ns in ipairs(namespaces) do
        for rule, val in pairs(rules) do
            hl.layer_rule({ match = { namespace = ns }, [rule] = val })
        end
    end
end

-- Global layer rules
hl.layer_rule({ match = { namespace = ".*" }, xray = true })

-- Fast launchers (no animations)
local no_anim_layers = {
    "walker", "selection", "overview", "anyrun", "indicator.*",
    "osk", "hyprpicker", "noanim", "gtk4-layer-shell"
}
for _, ns in ipairs(no_anim_layers) do
    hl.layer_rule({ match = { namespace = ns }, no_anim = true })
end

-- GTK and Notification layer rules
hl.layer_rule({ match = { namespace = "gtk-layer-shell" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "launcher" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0.69 })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })

-- Quickshell layer rules
hl.layer_rule({ match = { namespace = "quickshell:.*" }, blur = true, blur_popups = true, ignore_alpha = 0.79 })
hl.layer_rule({ match = { namespace = "quickshell:bar" }, animation = "slide" })
hl.layer_rule({ match = { namespace = "quickshell:actionCenter" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:cheatsheet" }, animation = "slide bottom" })
hl.layer_rule({ match = { namespace = "quickshell:dock" }, animation = "slide bottom" })
hl.layer_rule({ match = { namespace = "quickshell:screenCorners" }, animation = "popin 120%" })
hl.layer_rule({ match = { namespace = "quickshell:lockWindowPusher" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:notificationPopup" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "quickshell:overlay" }, no_anim = true, ignore_alpha = 1 })
hl.layer_rule({ match = { namespace = "quickshell:overview" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:osk" }, animation = "slide bottom", order = -1 })
hl.layer_rule({ match = { namespace = "quickshell:polkit" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:popup" }, xray = false, ignore_alpha = 1 })
hl.layer_rule({ match = { namespace = "quickshell:mediaControls" }, ignore_alpha = 1 })
hl.layer_rule({ match = { namespace = "quickshell:reloadPopup" }, animation = "slide" })
hl.layer_rule({ match = { namespace = "quickshell:regionSelector" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:screenshot" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:session" }, blur = true, no_anim = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "quickshell:sidebarRight" }, animation = "slide right" })
hl.layer_rule({ match = { namespace = "quickshell:sidebarLeft" }, animation = "slide left" })
hl.layer_rule({ match = { namespace = "quickshell:verticalBar" }, animation = "slide" })

-- Quickshell: waffles widgets
hl.layer_rule({ match = { namespace = "quickshell:wallpaperSelector" }, animation = "slide top" })
hl.layer_rule({ match = { namespace = "quickshell:wNotificationCenter" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:wOnScreenDisplay" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:wStartMenu" }, no_anim = true })
hl.layer_rule({ match = { namespace = "quickshell:wTaskView" }, no_anim = true, ignore_alpha = 0 })
