-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- h1.env("XCURSOR_THEME", )
-- h1.env("GTK_THEME",)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct", true)

--Toolkit Bankend--
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.67")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
