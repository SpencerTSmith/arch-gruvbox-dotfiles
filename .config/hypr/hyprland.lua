-- Requires a color.lua next to this file returning a table like:
-- return { fg1 = "rgba(...)", bg2 = "rgba(...)", bg = "rgba(...)" }
local bg_h       = "rgb(1d2021)"
local bg         = "rgb(282828)"
local bg_s       = "rgb(32302f)"
local bg1        = "rgb(3c3836)"
local bg2        = "rgb(504945)"
local bg3        = "rgb(665c54)"
local bg4        = "rgb(7c6f64)"
local fg         = "rgb(fbf1c7)"
local fg1        = "rgb(ebdbb2)"
local fg2        = "rgb(d5c4a1)"
local fg3        = "rgb(bdae93)"
local fg4        = "rgb(a89984)"
local red        = "rgb(fb4934)"
local green      = "rgb(b8bb26)"
local yellow     = "rgb(fabd2f)"
local blue       = "rgb(83a598)"
local purple     = "rgb(d3869b)"
local aqua       = "rgb(8ec07c)"
local gray       = "rgb(928374)"
local orange     = "rgb(fe8019)"
local red_dim    = "rgb(cc2412)"
local green_dim  = "rgb(98971a)"
local yellow_dim = "rgb(d79921)"
local blue_dim   = "rgb(458588)"
local purple_dim = "rgb(b16286)"
local aqua_dim   = "rgb(689d6a)"
local gray_dim   = "rgb(a89984)"
local orange_dim = "rgb(d65d0e)"

----------------
-- MONITORS
----------------

hl.monitor({ output = "DP-4", mode = "highres@highrr", position = "0x0", scale = 1.25, bitdepth = 10 })
hl.monitor({ output = "DP-5", mode = "highres@highrr", position = "3072x0", scale = 1 })

-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

---------------------
-- MY PROGRAMS
---------------------

local terminal = "footclient"
local fileManager = "thunar"
local menu = "fuzzel"
local browser = "firefox"

-----------------
-- AUTOSTART
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user enable --now hypridle")
    hl.exec_cmd("systemctl --user enable --now hyprpaper")
    hl.exec_cmd("systemctl --user enable --now hyprsunset")
    hl.exec_cmd("systemctl --user enable --now hyprpolkitagent")

    hl.exec_cmd("systemctl --user enable --now waybar")
    hl.exec_cmd("systemctl --user enable --now foot-server")
    hl.exec_cmd("systemctl --user enable --now fnott")

    hl.exec_cmd("uwsm app -- nm-applet")
    hl.exec_cmd("uwsm app -- blueman-applet")
    hl.exec_cmd("uwsm app -- wl-paste --watch cliphist store")
    hl.exec_cmd("uwsm app -- tmux new-session -d")
    hl.exec_cmd("uwsm app -- solaar --window=hide")

    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Plus-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Capitaine Cursors (Gruvbox) - White'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'BlexMono Nerd Font Propo 11'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

    hl.exec_cmd("hyprctl hyprsunset identity")
end)

---------------------
-- LOOK AND FEEL
---------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = fg1,
            inactive_border = bg2,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "scrolling",
    },

    scrolling = {
        focus_fit_method = 1,
    },

    decoration = {
        rounding = 0,
        rounding_power = 4.0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 10,
        },
        blur = {
            enabled = true,
            size = 2,
            passes = 2,
            new_optimizations = true,
            contrast = 1.0,
            brightness = 1.0,
            vibrancy = 1.0,
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = bg,
        middle_click_paste = false,
        animate_manual_resizes = true,
        vrr = 0,
        font_family = "BlexMono Nerd Font",
    },

    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        kb_layout = "us",
        repeat_delay = 300,
        repeat_rate = 75,
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = false,
        },
    },

    cursor = {
        inactive_timeout = 5,
    },
})

hl.curve("coolBezier", { type = "bezier", points = { {0.83, 0}, {0.17, 1} } })

hl.animation({ leaf = "windows",     enabled = true,  speed = 1, bezier = "coolBezier", style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = false, speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "border",      enabled = true,  speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "borderangle", enabled = false, speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "fade",        enabled = true,  speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "workspaces",  enabled = true,  speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "layers",      enabled = true,  speed = 1, bezier = "coolBezier" })
hl.animation({ leaf = "layersOut",   enabled = true,  speed = 1, bezier = "coolBezier", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "coolBezier", style = "slidevert -50%" })

hl.device({
    name = "sony-interactive-entertainment-wireless-controller-touchpad",
    enabled = false,
})

--------------------
-- KEYBINDINGS
--------------------

local mainMod = "SUPER"

-- Start apps, on dedicated workspaces
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("[workspace 1 silent] uwsm app -- " .. terminal .. " -e tmux a"))
hl.bind(mainMod .. " + Q", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("[workspace 2 silent] uwsm app -- raddbg"))
hl.bind(mainMod .. " + B", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("[workspace 3 silent] uwsm app -- " .. browser))
hl.bind(mainMod .. " + W", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("[workspace 5 silent] uwsm app -- steam"))
hl.bind(mainMod .. " + G", hl.dsp.focus({ workspace = 5 }))

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("[workspace 6 silent] uwsm app -- " .. browser))
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("[workspace 7 silent] uwsm app -- spotify"))
hl.bind(mainMod .. " + M", hl.dsp.focus({ workspace = 7 }))

-- Fuzzel scripts
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("fuzzel-power-menu.sh"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("fuzzel-cliphist.sh"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("fuzzel-files.sh"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("fuzzel-windows.sh"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("fuzzel-actions.sh"))

-- Start apps anywhere
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Dropdown terminal workspace
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("dropdown"))

-- Refresh waybar
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))

-- Copy and save screenshots
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("grimblast --notify save area"))

-- Control windows
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Resize window with mainMod + shift + vim keys
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -50, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = 50 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = -50 }), { repeating = true })

-- Move window with mainMod + control + vim keys
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "down" }), { repeating = true })

-- Switch workspaces with mainMod + [0-9], move window with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set +33%"), { repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"), { repeating = true })

------------------------------
-- WINDOWS AND WORKSPACES
------------------------------

-- Persistent workspaces
hl.workspace_rule({ workspace = "name:1", monitor = "DP-4" })
hl.workspace_rule({ workspace = "name:2", monitor = "DP-4" })
hl.workspace_rule({ workspace = "name:3", monitor = "DP-4" })
hl.workspace_rule({ workspace = "name:4", monitor = "DP-4" })
hl.workspace_rule({ workspace = "name:5", monitor = "DP-4" })
hl.workspace_rule({ workspace = "name:6", monitor = "DP-5" })
hl.workspace_rule({ workspace = "name:7", monitor = "DP-5" })
hl.workspace_rule({ workspace = "name:8", monitor = "DP-5" })
hl.workspace_rule({ workspace = "name:9", monitor = "DP-5" })
hl.workspace_rule({
    workspace = "special:dropdown",
    on_created_empty = "[float; size monitor_w monitor_h*0.3 ; move 0 30] foot",
    gaps_out = 0,
    no_border = true,
})

-- QOL
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({ match = { class = "^*$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { title = "^*$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

hl.window_rule({
    match = { class = "steam", title = "^notificationtoasts_.*_desktop$" },
    no_focus = true,
})

-- Float these
hl.window_rule({
    match = { class = "(dialog|splash|floating|pavucontrol|blueman-manager|imv|nm-connection-editor|org.pulseaudio.pavucontrol|nwg-look|engrampa|xarchiver)" },
    float = true,
})
hl.window_rule({
    match = { class = "(dialog|splash|floating|pavucontrol|blueman-manager|imv|nm-connection-editor|org.pulseaudio.pavucontrol|nwg-look|engrampa|xarchiver)" },
    size = "1100 900",
})

-- Specifically for working on stuff
hl.window_rule({ match = { title = "Ekwos" }, float = true })
hl.window_rule({ match = { title = "Heraclitus" }, float = true })
hl.window_rule({ match = { title = "Heraclitus" }, move = "monitor_w*0.5 monitor_h*0.5" })

-- Layer rules
hl.layer_rule({ match = { namespace = "launcher" }, animation = "slide", blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, animation = "slide", blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, animation = "slide", blur = true })
