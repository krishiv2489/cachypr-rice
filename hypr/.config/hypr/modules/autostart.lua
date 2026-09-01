-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd(
        "sh -c 'sleep 1 && swww img ~/Pictures/your-wallpaper.jpg && matugen image ~/Pictures/Wallpaper/ddg_1776968628942805169.jpg'")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)
