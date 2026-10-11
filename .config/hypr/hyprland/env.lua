-- hyprland/env.lua
-- Environment variables for Wayland, applications, themes

-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Applications
hl.env("XDG_DATA_DIRS", "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:$XDG_DATA_DIRS")

-- Themes
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("XDG_MENU_PREFIX", "plasma-")

-- Virtual environment
hl.env("ILLOGICAL_IMPULSE_VIRTUAL_ENV", "~/.local/state/quickshell/.venv")

-- Terminal application
hl.env("TERMINAL", "kitty")

-- Hardware-specific settings (AMD + Nvidia hybrid GPU)
-- These fix cursor stuttering on hybrid systems
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")

-- Force Hyprland to run on AMD iGPU (for smoothness)
-- Games will use Nvidia when needed
-- card1=NVIDIA(01:00.0), card2=AMD(64:00.0) - AMD first for compositor
hl.env("WLR_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")
