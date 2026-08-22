{envTheme, envColors}:
''
local mainMod = "ALT"
local subMod = "SUPER"
local wobSock = os.getenv("XDG_RUNTIME_DIR") .. "/wob.sock"

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("bitdepth", "10")
hl.env("XCURSOR_SIZE", "14")

hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XMODIFIERS QT_IM_MODULE")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("rm -f " .. wobSock .. " && mkfifo " .. wobSock .. " && tail -f " .. wobSock .. " | wob")
    hl.exec_cmd("fcitx5 -D --replace")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("hyprpaper")
end)

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "ctrl:nocaps",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = false },
    },
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(${envColors.fg}ee)", "rgba(${envColors.blue}ee)" }, angle = 45 },
            inactive_border = "rgba(${envColors.black}aa)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },
    decoration = {
        rounding = 10,
        blur = { enabled = true, size = 3, passes = 1 },
        shadow = { enabled = true, range = 4, render_power = 3, color = "rgba(${envColors.black}ee)" },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    master = { new_on_active = "master" },
    misc = { force_default_wallpaper = -1 },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

local function bind(key, dispatch)
    return hl.bind(key, dispatch)
end

bind(subMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill wofi || wofi --show drun -I"))
bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("pkill wlogout || wlogout -b 5"))
bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
bind(mainMod .. " + F", hl.dsp.window.fullscreen())
bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + P", hl.dsp.window.pseudo())
bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("pkill wofi || (cliphist list | wofi --dmenu | cliphist decode | wl-copy)"))

local volumeUp = "pamixer -i 10 && pamixer --get-volume > " .. wobSock
local volumeDown = "pamixer -d 10 && pamixer --get-volume > " .. wobSock
local volumeMute = "pamixer -t && (pamixer --get-mute && echo 0 > " .. wobSock .. ") || pamixer --get-volume > " .. wobSock
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volumeUp), { repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volumeDown), { repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd(volumeMute), { repeating = true })
bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer --default-source -i 10 && pamixer --default-source --get-volume > " .. wobSock), { repeating = true })
bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer --default-source -d 10 && pamixer --default-source --get-volume > " .. wobSock), { repeating = true })
bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("pamixer --default-source -t"), { repeating = true })
bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
bind("PRINT", hl.dsp.exec_cmd("grimblast --notify copy area | wl-paste -t image/png > ~/Pictures/Screenshots/$(date +%Y%m%d-%H%M%S)_grim_area.png"))

local directions = { H = "left", J = "down", K = "up", L = "right" }
for key, direction in pairs(directions) do
    bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
    local key = workspace % 10
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.define_submap("resize", function()
    bind("h", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    bind("j", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    bind("l", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    bind("escape", hl.dsp.submap("reset"))
end)
bind(mainMod .. " + SHIFT + R", hl.dsp.submap("resize"))
''
